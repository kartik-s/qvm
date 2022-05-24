;;;; allegro.lisp

(in-package #:qvm)

(defvar *cleanup-thunks* nil)

(defun %perform-cleanup ()
  (dolist (thunk *cleanup-thunks*)
    (ignore-errors (funcall thunk))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun call-at-exit (fun)
    (let ((cleanup-form '(%perform-cleanup)))
      (unless (member cleanup-form sys:*exit-cleanup-forms* :test #'equalp)
        (push cleanup-form sys:*exit-cleanup-forms*))
      (pushnew fun *cleanup-thunks*)
      (values))))
