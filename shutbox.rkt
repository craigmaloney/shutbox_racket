#lang racket 
(define tiles `(1 2 3 4 5 6 7 8 9))

(define (dice)
    (+ 1 (random 6)))

(define (roll) 
    (list (dice) (dice)))

(define dice-roll (roll))

(define sum-roll (apply + dice-roll))

(define tilelist '(4 5))

(define (shut-tiles tilelist)
    (for ([i tilelist])
        (if (index-of tiles i)
            (set! tiles (remove i tiles))
            ("Tile already shut"))))

(shut-tiles tilelist)
