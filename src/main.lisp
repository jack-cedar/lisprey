(defpackage #:lisprey
  (:use #:cl
	#:lisprey.core
	#:lisprey.gateway))
(in-package #:lisprey)

(defun infermsg (msg)
  (let ((op (gethash "op" msg)))
    (case op
      (11 (setf (lisprey*-heartbeat-ack *instance*) t)))))

(defun start ()
  (let ((l (init-lisprey :token "")))
    (setf *instance* l))
  (connect *instance*)
  (print *instance*)
  (sleep 2)
  (infermsg (pop (lisprey*-msgbuffer *instance*)))
  (kill *instance*)
  (print *instance*)
  nil)


