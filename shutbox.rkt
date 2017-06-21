#lang racket 

#| Init Block |#

(define tiles '())
(define die1 0)
(define die2 0)
(define turn-number 1)

(define (start-game)
  (set! tiles '(1 2 3 4 5 6 7 8 9)))


(define (dice)
  (+ 1 (random 6)))

(define (dice-roll)
  (set! die1 (dice))
  (set! die2 (dice)))

(define (sum-of-dice)
  (+ die1 die2))

(define (sum-of-tiles tilelist)
  (apply + tilelist))

(define (check-roll dice-sum tile-sum)
  (= dice-sum tile-sum))

(define (shut-tiles tilelist)
  (for ([i tilelist])
       (if (index-of tiles i)
         (set! tiles (remove i tiles))
         (print "Tile already shut"))))

(define (player-turn tilelist)
  (if (check-roll (sum-of-dice) (sum-of-tiles tilelist))
      (shut-tiles tilelist)
      (print "Roll does not equal shut tiles. Try again.")))
  
(start-game)
(dice-roll)

(define (next-turn)
  (set! turn-number (+ 1 turn-number))
  (dice-roll)
  (show-turn))

(define (show-turn)
  (printf "Turn: ")
  (println turn-number)
  (println tiles)
  (printf "Dice roll ~v ~v = ~v" die1 die2 (sum-of-dice) ))
