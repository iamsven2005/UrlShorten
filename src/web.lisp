(in-package :cl-user)
(defpackage url-shortener-microservice.web
  (:use :cl
        :caveman2
        :url-shortener-microservice.config
        :url-shortener-microservice.view
        :url-shortener-microservice.db
        :url-shortener-microservice.service
        :datafly
        :sxql)
  (:export :*web*))
(in-package :url-shortener-microservice.web)

;; for @route annotation
(syntax:use-syntax :annot)

;;
;; Application

(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;;
;; Routing rules

(defroute "/" ()
  (render #P"index.html"))

@route GET "/api/shorten/new"
(lambda (&key |long-url|)
  (render-json `(title ,|long-url|)))
;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
