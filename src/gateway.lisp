(defpackage #:lisprey.gateway
  (:use #:cl
	#:lisprey.core
	:websocket-driver-client
	:yason)
  (:export #:connect
	   #:kill))
(in-package #:lisprey.gateway)

(defun connect (instance)
  (let ((client (wsd:make-client "wss://gateway.discord.gg/?v=10&encoding=json")))
    (setf (lisprey*-connection instance) client)
    (setf (lisprey*-running instance) t)
    (wsd:on :open client
	    (lambda ()
	      (setf (lisprey*-state instance) "Connected")))
    (wsd:on :message client
	    (lambda (msg)
	      (push (yason:parse msg) (lisprey*-msgbuffer instance))))
    (wsd:start-connection client)
    (loop while (null (lisprey*-msgbuffer instance)))
    
    (heartbeat instance (gethash "heartbeat_interval"
				 (gethash "d"(pop (lisprey*-msgbuffer *instance*)))))
    ))

(defun kill (instance)
  (setf (lisprey*-running instance) nil)
  (setf (lisprey*-heartbeat instance) nil)
  (wsd:remove-all-listeners (lisprey*-connection instance))
  (wsd:close-connection (lisprey*-connection instance))
  (setf (lisprey*-connection instance) nil)
  (setf (lisprey*-state instance) "Dead"))

(defun heartbeat (instance interval)
  
  (setf (lisprey*-heartbeat instance)
	(sb-thread:make-thread
	 (lambda ()
	   (setf (lisprey*-heartbeat-ack instance) t)
	   (let ((heartbeatJSON "{\"op\": 1, \"d\": \"null\"}"))
	     (wsd:send (lisprey*-connection instance) heartbeatJSON)
	     (sleep (/ interval 1000))
		       )))))


