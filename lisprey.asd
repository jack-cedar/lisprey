(defsystem "lisprey"
  :description "A Lisp Based Discord Bot THat Evaluates Lisp As Commands"
  :author "Jack Cedar Janousek-Weaver"
  :licence "mit"
  :depends-on (:websocket-driver-client
	       :yason)
  :components ((:module "src"
		:components ((:file "core")
			     (:file "gateway")
			     (:file "main"))))
  :build-operation "program-op"
  :build-pathname "lisprey"
  :entry-point "lisprey::start")
