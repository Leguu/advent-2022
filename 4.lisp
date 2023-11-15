(defpackage #:advent-lisp/4
  (:use #:cl #:arrow-macros #:f-underscore)
  (:export :solution-part-one :solution-part-two))

(in-package #:advent-lisp/4)

(defvar *id-ranges* nil)

(defun convert-string-to-range (input)
  (let* ((parts (uiop:split-string input :separator "-"))
         (start (parse-integer (first parts)))
         (end (parse-integer (second parts))))
    (loop for i from start to end collect i)))

(defun init-ranges ()
  (setq *id-ranges*
    (->> (uiop:read-file-lines "4.input")
         (mapcar (f_ (uiop:split-string _ :separator ",")))
      (mapcar (f_ (mapcar 'convert-string-to-range _))))))

(defun equal-unordered (set1 set2)
  (and (loop for i in set1
             always (find i set2))
       (loop for i in set2
             always (find i set1))))
       

(defun pair-fully-contains? (&rest pair)
  (let* ((_1 (first pair))
         (_2 (second pair))
         (intersect (intersection _1 _2)))
    (or (equal-unordered intersect _1) (equal-unordered intersect _2))))


(defun solution-part-one ()
  (loop for pair in *id-ranges*
        when (apply 'pair-fully-contains? pair)
        count pair))
    
(defun solution-part-two ()
  (let ((intersections (mapcar (f_ (apply 'intersection _)) *id-ranges*)))
    intersections))

