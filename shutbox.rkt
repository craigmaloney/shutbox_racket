#lang racket 

#| Init Block |#

(define tiles '())
(define die1 0)
(define die2 0)
(define turn-number 1)
(define took-turn #f)
(define end-of-game #f)

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

(define (list-check l1 l2)
  (andmap (lambda (x) (not (boolean? (memq x l2)))) l1))

(define (shut-tiles tilelist)
  (if (not took-turn) 
    (if (list-check tilelist tiles)
      (for ([i tilelist])
           (if (index-of tiles i)
             (begin
               (set! tiles (remove i tiles))
               (set! took-turn #t))
             (error "Tile already shut")))
      (println "Tile not available to be shut"))
    (println "Already took your turn")))

(define (check-roll dice-sum tile-sum)
  (= dice-sum tile-sum))

(define (player-turn tilelist)
  (if (member "hint" tilelist)
    (hint (sum-of-dice))
    (if (check-roll (sum-of-dice) (sum-of-tiles tilelist))
        (shut-tiles tilelist)
        (println "Roll does not equal shut tiles. Try again."))))

(define (my-read-line)
  (let ([contents (read-line)])
    (if (string=? contents "")
      (read-line)
      contents)))

(define (input) 
  (let ((input-line (my-read-line))) 
        (if (string=? input-line "hint")
          '("hint")
          (map string->number (string-split input-line)))))

(define (next-turn)
  (set! turn-number (+ 1 turn-number))
  (set! took-turn #f)
  (dice-roll)
  (show-turn))

(define (show-turn)
  (printf "Turn: ")
  (println turn-number)
  (println tiles)
  (printf "Dice roll ~v ~v = ~v\n" die1 die2 (sum-of-dice) ))

(define (tile-combinations sum)
  (filter (lambda (x) (eq? (apply + x) sum)) (cdr ( combinations tiles))))

(define (hint sum)
   (println sum)
   (println (tile-combinations sum)))

(define (end-of-game-test sum)
  (let ((combinations (tile-combinations sum))) 
    (empty? combinations)
    ))

#| Main Loop |#
(start-game)
(dice-roll)
(show-turn)
(let loop()
  (define tilelist (input))
  (player-turn tilelist)
  (cond 
    [took-turn (next-turn)])
  (when (not (end-of-game-test (sum-of-dice))) (loop)))
(if (empty? tiles)
  (println "Congratulations! You shut the box!")
  (println "No more moves available. Try again?"))
