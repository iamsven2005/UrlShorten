(in-package :cl-user)

(defpackage url-shortener-microservice.service
  (:use :cl :sxql)
  (:import-from :url-shortener-microservice.db
                :db
                :with-connection)
  (:import-from :datafly
                :execute
                :retrieve-one)
  (:import-from :cl-ppcre
                :scan)
  (:export :create-service-table
           :add-shortened
           :get-long-url
           :get-short-url
           :is-long-urlp))
(in-package url-shortener-microservice.service)

;; create a new service table
;; to keep the shortened
;; and long urls
(defun create-service-table ()
  (with-connection (db)
    (execute
     (create-table (:service :if-not-exists t)
         ((id :type 'integer :primary-key t)
          (long-url :type 'text :not-null t))))))

;; return nil
;; create a new database if the database
;; is deleted *AND*
;; create a new shortened URL.
;;
;; the reason why I'm calling
;; create-service-table here is
;; because of SQLite3 on Heroku
;; temporary filesystem will make
;; the database gone if the app
;; "sleeps"
(defun add-shortened (long-url)
  (create-service-table)
  (with-connection (db)
    (execute
     (insert-into :service
       (set= :long-url long-url)))))

;; return list
(defun get-long-url (short-url)
   "lookup long url record by short-url"
   (with-connection (db)
     (retrieve-one
      (select :long-url (from :service)
              (where (:= :id short-url))))))

;; return list
(defun get-short-url (long-url)
  "find short url record by long-url"
  (with-connection (db)
    (retrieve-one
     (select :id (from :service)
             (where (:= :long-url long-url))))))
;;
;; Utils

;; return t or nil
;; check if original (long) URL is valid http URL
(defun is-long-urlp (long-url)
  "reject long urls that are not even urls"
  (if (not (scan "^https?:" long-url))
      nil
      long-url))
