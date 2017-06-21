#lang racket 

#| Init Block |#

(define tiles '())
(define die1 0)
(define die2 0)

(define (start-game)
  (set! tiles '(1 2 3 4 5 6 7 8 9)))
  
    
(define (dice)
    (+ 1 (random 6)))

(define (dice-roll)
  (set! die1 (dice))
  (set! die2 (dice)))
  
(define (sum-of-dice die1 die2)
  (+ die1 die2))
        

(define (shut-tiles tilelist)
    (for ([i tilelist])
        (if (index-of tiles i)
            (set! tiles (remove i tiles))
            (print "Tile already shut"))))

(start-game)
(dice-roll)

(define (next-turn)
  (dice-roll)
  (show-turn))

(define (show-turn)
  (println tiles)
  (printf "Dice roll ~v ~v = ~v" die1 die2 (sum-of-dice die1 die2) ))


