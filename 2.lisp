(defpackage #:advent-lisp/2
  (:use #:cl #:cl-ppcre)
  (:export :solution-part-two))

(in-package #:advent-lisp/2)

(defparameter point-values '(("A" 1)
                             ("B" 2)
                             ("C" 3)
                             ("X" 1)
                             ("Y" 2)
                             ("Z" 3)))

(defparameter beats '(("A" "Z") ("B" "X") ("C" "Y") ("X" "C") ("Y" "A") ("Z" "B")))

(defun get-point-value (letter)
  (getf-string letter point-values))

(defun can-beat (a b)
  (string= (getf-string a beats) b))

(defun getf-string (key alist)
  (second (assoc key alist :test #'string=)))

(defun trim-blankspace (string)
  (string-trim '(#\Space #\Newline #\Return) string))

(defun string-blank-p (string)
  "Return t if STRING is empty or contains only whitespace."
  (string= (trim-blankspace string) ""))

(defvar instructions nil)

(defun read-input ()
  (with-open-file (stream "2.input")
    (setq instructions nil)
    (loop for line = (trim-blankspace (read-line stream nil))
          while (not (string-blank-p line))
          do (push (cl-ppcre:split " " line) instructions))))

(defun get-points (your-move enemy-move)
  (+ (get-point-value your-move)
     (if (string= your-move enemy-move)
         3
         (if (can-beat your-move enemy-move)
             6
             0))))

(defun solution-part-two ()
  (read-input)
  (reduce #'+
          (mapcar #'(lambda (value)
                      (get-points (second value) (first value)))
                  instructions)))

