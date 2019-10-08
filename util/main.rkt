#lang racket

(provide book-image
  inline-book-image
  pict->img
  (all-from-out pict))

(require pict
   net/base64
   file/convertible)

(require book-spines)

(define (first-word s)
  (first (string-split s " ")))

(define book-list
 (list
  (red-spine)
  (green-spine)
  (blue-spine)))

(define counter -1)

(define (next-book!)
 (set! counter (remainder (add1 counter) 3))
 (list-ref
  book-list
  counter))

(define (book-image title tags)
 (pict->img
  (scale 
   (with-text (first-word title)
    (next-book!))
   0.5)))


(define (pict->img pict)
 (~a "<img align=\"left\" style=\"height: 250px; margin-right: 10px;\" src=\"" 
  (format "data:image/png;base64,~a"
   (base64-encode (convert pict 'png-bytes)))
 "\"/>"))


(define (book)
 (scale 
  (rotate
   (cc-superimpose
    (filled-rounded-rectangle 80 40 #:color "limegreen" #:border-width 2)
    (text "Lost Library"))
   (- (/ pi 2)))
  0.5))


(define (inline-book-image)
  (pict->img (book)))

