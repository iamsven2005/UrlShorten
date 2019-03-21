(in-package :cl-user)
(defpackage url-shortener-microservice
  (:use :cl)
  (:import-from :url-shortener-microservice.config
                :config)
  (:import-from :clack
                :clackup)
  (:export :start
           :stop
           :my-restart
           :main))
(in-package :url-shortener-microservice)

(defvar *appfile-path*
  (asdf:system-relative-pathname :url-shortener-microservice #P"app.lisp"))

(defvar *handler* nil)

(defun start (&rest args &key server port debug &allow-other-keys)
  (declare (ignore server port debug))
  (when *handler*
    (restart-case (error "Server is already running.")
      (restart-server ()
        :report "Restart the server"
        (stop))))
  (setf *handler*
        (apply #'clackup *appfile-path* args)))

(defun stop ()
  (prog1
      (clack:stop *handler*)
    (setf *handler* nil)))

(defun my-restart (port)
  (stop)
  (start :port port :server 'hunchentoot))

;; for building an executable, launch sbcl in cli
;; and type
;; (ql:quickload :url-shortener-microservice)
;; (sb-ext:save-lisp-and-die "usm" :compression t
;;                                 :executable t
;;                                 :toplevel 'url-shortener-microservice:main)

(defun main ()
  (start :port (parse-integer (uiop:getenv "PORT")))
  ;; with bordeaux-threads
  (handler-case (bt:join-thread (find-if (lambda (th)
                                             (search "hunchentoot" (bt:thread-name th)))
                                         (bt:all-threads)))
    (#+sbcl sb-sys:interactive-interrupt
      #+ccl  ccl:interrupt-signal-condition
      #+clisp system::simple-interrupt-condition
      #+ecl ext:interactive-interrupt
      #+allegro excl:interrupt-signal
      () (progn
           (format *error-output* "Aborting.~&")
           (clack:stop *server*)
           (uiop:quit 1)) ;; portable exit, included in ASDF, already loaded.
    ;; for others, unhandled errors (we might want to do the same).
    (error (c) (format t "Woops, an unknown error occured:~&~a~&" c)))))
