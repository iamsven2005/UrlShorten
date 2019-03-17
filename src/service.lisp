(in-package :cl-user)

(defpackage url-shortener-microservice.service
  (:use :cl :sxql)
  (:import-from :url-shortener-microservice.db
                :db
                :with-connection)
  (:import-from :datafly
                :execute
                :retrieve-one
                :retrieve-all)
  (:export :create-service-table
           :add-shortened))
(in-package url-shortener-microservice.service)

(defun create-service-table ()
  (with-connection (db)
    (execute
     (create-table (:service :if-not-exists t)
         ((id :type 'serial :primary-key t)
          (long-url :type 'text :not-null t)
          (short-url :type 'text :not-null t :unique t))))))

(defun add-shortened ()
  )
