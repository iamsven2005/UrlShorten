(defsystem "url-shortener-microservice"
  :version "0.1.0"
  :author "Momozor"
  :license "MIT"
  :depends-on ("clack"
               "lack"
               "caveman2"
               "envy"
               "cl-ppcre"
               "uiop"

               ;; for @route annotation
               "cl-syntax-annot"

               ;; HTML Template
               "djula"

               ;; for DB
               "datafly"
               "sxql")
  :components ((:module "src"
                :components
                ((:file "main" :depends-on ("config" "view" "db"))
                 (:file "web" :depends-on ("view" "service"))
                 (:file "view" :depends-on ("config"))
                 (:file "db" :depends-on ("config"))
                 (:file "service" :depends-on ("db"))
                 (:file "config"))))
  :description "URL Shortener microservice website"
  :in-order-to ((test-op (test-op "url-shortener-microservice-test"))))
