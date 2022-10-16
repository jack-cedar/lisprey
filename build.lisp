(pushnew (uiop:getcwd) ql:*local-project-directories*)
(ql:quickload :lisprey)
(asdf:make :lisprey)
