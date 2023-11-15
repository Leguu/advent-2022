(defpackage #:advent-lisp/5
  (:use #:cl #:arrow-macros #:f-underscore)
  (:export :solution-part-one :solution-part-two))

(in-package #:advent-lisp/5)

(defvar *pallet* nil)

(defun reset-pallet ()
  (setq *pallet* (copy-list '((N V C S)
                              (S N H J M Z)
                              (D N J G T C M)
                              (M R W J F D T)
                              (H F P)
                              (J H Z T C)
                              (Z L S F Q R P D)
                              (W P F D H L S C)
                              (Z G N F P M S D)))))

(defvar *input-instructions* nil)
(defun read-instructions ()
  (setq *input-instructions*
        (uiop:read-file-lines "5.input")))

(defun convert-string-instruction (instruction)
  (let* ((string-parts (uiop:split-string instruction :separator " "))
         (parts (list (second string-parts) (fourth string-parts) (sixth string-parts))))
    (mapcar 'parse-integer parts)))

(defvar *instructions* nil)
(defun initialize-instructions ()
  (read-instructions)
  (setq *instructions* (mapcar 'convert-string-instruction *input-instructions*)))

(defun execute-instruction (instruction)
  (symbol-macrolet ((amount (first instruction))
                    (source (nth (- (second instruction) 1) *pallet*))
                    (destination (nth (- (third instruction) 1) *pallet*)))
       
    (loop for i from 1 to amount do
      (push (pop source) destination))))

(defun solution-part-one ()
  (reset-pallet)
  (initialize-instructions)
  (loop for instruction in *instructions* do
    (execute-instruction instruction))
  (format nil "~{~A~}"
    (loop for tower in *pallet* collect (first tower))))

(defun execute-instruction-2 (instruction)
  (symbol-macrolet ((amount (first instruction))
                    (source (nth (- (second instruction) 1) *pallet*))
                    (destination (nth (- (third instruction) 1) *pallet*)))
    (let ((temp nil))
      (loop for i from 1 to amount do
        (push (pop source) temp))
      (loop while temp do
        (push (pop temp) destination)))))

(defun solution-part-two ()
  (reset-pallet)
  (initialize-instructions)
  (loop for instruction in *instructions* do
    (execute-instruction-2 instruction))
  (format nil "~{~A~}"
    (loop for tower in *pallet* collect (first tower))))
         
    
