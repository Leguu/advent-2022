(defpackage #:advent-lisp/3
  (:use #:cl #:arrow-macros #:f-underscore)
  (:export :solution-part-two))

(in-package #:advent-lisp/3)

(defvar *input-lines* nil)

(defvar *groups* nil)

(defun read-input ()
  (let ((lines (uiop:read-file-lines "3.input")))
    (setq *input-lines* lines)))

(defun define-groups ()
  (setq *groups* nil)
  (loop for line in *input-lines* do
     (let ((len (if (equal (first *groups*) nil)
                  0
                  (length (first *groups*)))))
       (if (or (equal len 3) (equal len 0))
        (push (list line) *groups*)
        (push line (first *groups*))))))
       
(defun get-badge (group)
  (first (-<> group
           (mapcar (f_ (coerce _ 'list)) <>)
           (reduce 'intersection (rest <>) :initial-value (first <>)))))
   
(defun get-priority (item)
  (let ((code (char-code item))
        (A (char-code #\A))
        (Z (char-code #\Z))
        (lower-a (char-code #\a)))
         
    (if (<= code Z) (+ 27 (- code A))
        (+ 1 (- code lower-a)))))

(defun solution-part-two ()
  (read-input)
  (define-groups)
  (->> *groups*
    (mapcar 'get-badge)
    (mapcar 'get-priority)
    (reduce '+)))

