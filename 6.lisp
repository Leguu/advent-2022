(defpackage #:advent-lisp/6
  (:use #:cl #:arrow-macros #:f-underscore)
  (:export :solution-part-one :solution-part-two))

(in-package #:advent-lisp/6)

(defvar *input* nil)

(defun read-input ()
  (setq *input* (coerce (uiop:read-file-string "6.input") 'list)))

(defun take (list n)
  (if (<= (length list) n)
      list
      (subseq list 0 n)))

(defun all-unique? (list)
  (equal (length (remove-duplicates list)) (length list)))

(defun solution-part-one ()
  (read-input)
  (loop with i = 0
        with buf = (list)
        do (incf i)
           (setq buf (take buf 3))
           (push (pop *input*) buf)
        when (equal (length *input*) 0)
          return 'not-found
        when (and (equal (length buf) 4) (all-unique? buf))
          return i))
 

(defun solution-part-two ()
  (read-input)
  (loop with i = 0
        with buf = (list)
        do (incf i)
           (setq buf (take buf 13))
           (push (pop *input*) buf)
        when (equal (length *input*) 0)
          return 'not-found
        when (and (equal (length buf) 14) (all-unique? buf))
          return i))  


