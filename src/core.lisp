(defpackage #:lisprey.core
  (:use #:cl)
  (:export #:*instance*
	   #:lisprey*
	   #:init-lisprey
	   #:lisprey*-token
	   #:lisprey*-state
	   #:lisprey*-running
	   #:lisprey*-msgbuffer
	   #:lisprey*-heartbeat
	   #:lisprey*-heartbeat-ack
	   #:lisprey*-connection))

(in-package #:lisprey.core)

;; Holds The Current Active Lisprey Instance
(defparameter *instance* nil)

;; Structure For A Lisprey Instance
(defstruct (lisprey* (:constructor init-lisprey)) 
  (token "" :type string :read-only t)
  (running nil :type boolean)
  connection
  (heartbeat)
  (heartbeat-ack nil :type boolean)
  (msgbuffer '() :type list)
  (state "" :type string))



