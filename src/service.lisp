(in-package :cl-user)

(defpackage url-shortener-microservice.service
  (:use :cl :sxql)
  (:import-from :url-shortener-microservice.db
                :db
                :with-connection)
  (:import-from :datafly
                :execute
                :retrieve-one)
  (:export :create-service-table
           :add-shortened
           :get-long-url))
(in-package url-shortener-microservice.service)

(defun create-service-table ()
  (with-connection (db)
    (execute
     (create-table (:service :if-not-exists t)
         ((id :type 'integer :primary-key t)
          (long-url :type 'text :not-null t))))))

(defun add-shortened (&key long-url)
  (with-connection (db)
    (execute
     (insert-into :service
       (set= :long-url long-url)))))

(defun get-long-url (id)
   "lookup user record by email."
   (with-connection (db)
     (retrieve-one
      (select :long-url (from :service)
              (where (:= :id id))))))
