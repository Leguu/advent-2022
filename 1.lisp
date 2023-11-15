(defpackage #:advent-lisp/1
  (:use #:cl)
  (:export :solution-part-one :solution-part-two))

(in-package #:advent-lisp/1)

(defvar *input* '(()))

(defun string-blank-p (string)
  "Return t if STRING is empty or contains only whitespace."
  (string= (string-trim '(#\Space #\Newline #\Return) string) ""))

(defmacro iflet ((value test) &body body)
  `(let ((,value ,test))
     (when ,value
           ,@body)))

(defun read-input ()
  (setq *input* '(()))
  (with-open-file (stream "1.input")
    (loop for line = (read-line stream nil)
          while line
          do (if (string-blank-p line)
                 (push '() *input*)
                 (iflet (value (parse-integer line :junk-allowed t))
                   (push value (car *input*)))))
    *input*))

(defun sum (list)
  (reduce #'+ list))

(defun sum-sublists (list)
  (map 'list #'sum list))

(defun solution-part-one ()
  (read-input)
  (apply #'max (sum-sublists *input*)))

(defun solution-part-two ()
  (read-input)
  (sum (subseq (sort (sum-sublists *input*) #'>) 0 3)))

