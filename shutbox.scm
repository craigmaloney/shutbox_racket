(define tiles `(1 2 3 4 5 6 7 8 9))
(define die1 (+ 1 (random 6)))
(define die2 (+ 1 (random 6)))
(define roll (+ die1 die2))

(define tilelist '(4 5))

(define (shuttiles tilelist)
    (for ([i tilelist])
        (if (index-of tiles i)
            (set! tiles (remove i tiles))
            ("Tile already shut"))))

(shuttiles tilelist)
