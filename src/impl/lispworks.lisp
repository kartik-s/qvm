;;;; lispworks.lisp

(in-package #:qvm)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun call-at-exit (fun)
    (lw:define-action "When quitting image" "Deallocate shared memories"
      fun)))
