#lang racket

(provide book-image
  inline-book-image
  pict->data-uri
  (all-from-out pict))

(require pict
   net/base64
   file/convertible)

(define (book-image title tags)
  #;
  (displayln title)
  #;
  (displayln tags)
  (circle 60))

(define (pict->data-uri pict)
  (format "data:image/png;base64,~a"
          (base64-encode (convert pict 'png-bytes))))


(define (book)
 (scale 
 (rotate
   (cc-superimpose
    (filled-rounded-rectangle 80 40 #:color "limegreen" #:border-width 2)
    (text "Lost Library"))
   (- (/ pi 2)))
  0.5))


 
(define (inline-book-image)
  (~a "<img style=\"\" src=\"" 
      (pict->data-uri (book))
      "\"/>"))
