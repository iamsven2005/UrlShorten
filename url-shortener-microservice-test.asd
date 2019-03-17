(defsystem "url-shortener-microservice-test"
  :defsystem-depends-on ("prove-asdf")
  :author ""
  :license ""
  :depends-on ("url-shortener-microservice"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "url-shortener-microservice"))))
  :description "Test system for url-shortener-microservice"
  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
