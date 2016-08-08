
(defmacro locate (x y)
  (list 'progn
	(list 'goto-line y)
	(list 'move-to-column x)))

(defmacro flush-screen (x)
  (list 'progn
	(list 'goto-line 1)
	(list 'move-to-column 0)
	(list 'sit-for x)))

(setq hny-object-list
      '(small-star small-cannon-1 small-cannon-2 ball carrier
	fuse rocketrocket-rancher))

(setplist 'small-star '(shape ("*")))

(setplist
 'small-cannon-1
 '(status 0
	  shape (("           o"
		  "====&&=p--//"
		  "   ()-()  //")
		 ("           o"
		  "====&&=p--//"
		  "   ()-()  /|"))))
(setplist
 'small-cannon-2
 '(status 0
	  shape (("            "
		  "\\\\          "
		  " \\\\      o  "
		  "  &&=p--//   "
		  " ()-()   || ")
		 ("%%          "
		  " \\\\         "
		  "  \\\\      o "
		  "   &&=p--// "
		  "  ()-()   |\\")
		 (" %%*        "
		  "*%%         "
		  "  \\\\      o "
		  "   &&=p--// "
		  "  ()-()   |\\"))))
(setplist
 'ball
 '(status 0
	  shape (("   @@@@   "
		  "  @@@@@@  "
		  "   @@@@   "
		  "          ")
		 ("   @@@@@  "
		  " @@@@ @ @ "
		  "  @ @    @"
		  "          ")
		 ("   @@@@@  "
		  " @@@@=_| @"
		  " @ @  @  @"
		  "  @    @  ")
		 ("   @@@@@  "
		  " @@ @  @@@"
		  "@ @|=--| @"
		  " @   @   @"))))
(setplist
 'flag-1
 '(status 0
	  shape (("| A |" "`~@~\"")
		 ("@  @|" "`~~~\"")
		 ("| H |" "`~~~\"")
		 ("| A |" "`~~~\"")
		 ("| P |" "`~~~\"")
		 ("| P |" "`~~~\"")
		 ("| Y |" "`~~~\"")
		 ("|   |" "`~~~\"")
		 ("| N |" "`~~~\"")
		 ("| E |" "`~~~\"")
		 ("| W |" "`~~~\"")
		 ("|   |" "`~~~\"")
		 ("| Y |" "`~~~\"")
		 ("| E |" "`~~~\"")
		 ("| A |" "`~~~\"")
		 ("| R |" "l___l"))))

(setplist
 'rocket-rancher
 '(shape ("                 /\\    "
	  "                |  |   "
 	  "                |19|   "
	  "o   o   o       |  |   "
	  "\\\\-+-\\-+-\\===q__/==\\__ "
	  "\\\\  \\\\  \\\\    <oo><oo>  ")))

(setplist
 'rocket
 '(status 0
	  shape ((" /\\ " "|  |" "|98|" "|  |" "/==\\" " WW " " VV ")
		 (" /\\ " "|  |" "|89|" "|  |" "/==\\" " WW " " VV ")
		 (" /\\ " "|  |" "|9 |" "|  |" "/==\\" " WW " " VV ")
		 (" /\\ " "|  |" "|  |" "|  |" "/==\\" " WW " " VV ")
		 (" /\\ " "|  |" "| 1|" "|  |" "/==\\" " WW " " VV ")
		 (" /\\ " "|  |" "|19|" "|  |" "/==\\" " WW " " VV "))))

(setplist
 'carrier
 '(status 0
	  shape (("o   o   o "
		  "\\\\ / \\  \\\\"
		  "|\\  \\\\  |\\")
		 ("   o   o  "
		  "o\\/ \\  \\\\ "
		  "<\\ \\\\  \\\\_")
		 ("      o   "
		  "o\\o\\  \\\\  "
		  "<<<\\  |\\__")
		 ("          "
		  "o\\o\\  o\\  "
		  "<<<<  <\\__"))))

(setplist
 'fuse
 '(shape ("               "
	  "______________/")))

(defun clear-object (obj)
  (let ((xy (get obj 'xy)))
    (locate (car xy) (cdr xy))
    (put obj 'xy nil)
    (picture-insert-rectangle (get obj 'empty-shape))))

(defun write-object (obj &optional fix)
  (let* ((xy (get obj 'xy))
	 (st (get obj 'status))
	 (sp (get obj 'shape)))
    (locate (car xy) (cdr xy))
    (if (not st)
	(picture-insert-rectangle sp)
      (if fix (picture-insert-rectangle (car sp))
	(picture-insert-rectangle
	 (nth st sp))
	(put obj 'status  (if (< (1+ st) (length sp)) (1+ st) 0))))))

(defun move-object (obj x y &optional fix)
  (if (get obj 'xy)
      (clear-object obj))
  (put obj 'xy (cons x y))
  (write-object obj fix))

(defun hny-buffer-initialize ()
  (beginning-of-buffer)
  (let ((n 22))
    (while (> n 0)
      (insert (make-string 120 ? ))
      (insert "\n")
      (setq n (1- n))))
  (scroll-left 19))

(defun object-initialize (obj)
  (put obj 'xy nil)
  (let ((shape (get obj 'shape)))
    (if (get obj 'status) (setq shape (car shape)))
    (put obj 'empty-shape
	 (make-list (length shape)
		    (make-string (length (car shape)) ? )))))

(defun hny-object-initialize (obj-list)
  (if obj-list
      (progn
	(object-initialize (car obj-list))
	(hny-object-initialize (cdr obj-list)))))

(defun move-small-cannon ()
  (let ((x 0) (y 20))
    (while (< x 84)
      (move-object 'small-cannon-1 x y)
      (flush-screen 0)
      (setq x (+ x 2)))
    (flush-screen 1)
    (clear-object 'small-cannon-1)
    (move-object 'small-cannon-2 x (- y 2))
    (flush-screen 1)))

(defun shoot-small-cannon ()
  (let ((x 84) (y 19) (i 18))
    (while (> i 3)
      (if (memq i '(18 16 13)) (move-object 'small-cannon-2 84 18))
      (setq x (- x 3))
      (setq y (- y (/ i 7)))
      (move-object 'small-star x y)
      (flush-screen 0)
      (setq i (1- i)))))

(defun show-ball ()
  (move-object 'ball 30 1))

(defun explode-ball ()
  (let ((i (length (get 'ball 'shape))))
    (while (> i 1)
      (move-object 'ball 30 1)
      (flush-screen 0)
      (setq i (1- i)))))

(defun show-flag-1 ()
  (let ((i (length (get 'flag-1 'shape)))
	(y 2))
    (while (> i 0)
      (move-object 'flag-1 33 y)
      (setq y (1+ y))
      (flush-screen 0)
      (setq i (1- i)))))

(defun move-rocket-rancher ()
  (let ((x 82) (y 17))
    (clear-object 'small-cannon-2)
    (while (< x 98)
      (move-object 'small-cannon-1 x 20)
      (flush-screen 0)
      (setq x (1+ x)))
    (setq x 100)
    (while (> x 55)
      (move-object 'rocket-rancher x y)
      (flush-screen 0)
      (setq x (1- x)))
    (flush-screen 1)))
  
 (defun fire-rocket ()
  (move-object 'fuse 54 21 t)
  (let ((i 10))
    (while (> i 0)
      (move-object 'carrier (+ 45 i) 20 t)
      (flush-screen 0)
      (write-object 'fuse)
      (setq i (1- i)))
    (setq i 4)
    (while (> i 0)
      (write-object 'fuse)
      (move-object 'carrier 45 20)
       (flush-screen 0)
      (setq i (1- i)))
    (setq i 16)
    (while (> i 0)
      (move-object 'small-star (- 69 i) 22)
      (flush-screen 0)
      (setq i (1- i)))
    (clear-object 'small-star)
    (setq i 14)
    (while (> i 0)
      (move-object 'rocket 72 i)
      (flush-screen 0)
      (setq i (1- i)))
    (flush-screen 0)))

(defun happy-new-year ()
  (interactive)
  (require 'picture)
  (let ((hny-buffer (get-buffer-create "1989!! A Happy New Year!"))
	(sc-height (screen-height))
	(tr-line truncate-lines))
    (set-screen-height 24)
    (save-excursion
      (set-buffer hny-buffer)
      (setq truncate-lines t)
      (hny-buffer-initialize)
      (hny-object-initialize hny-object-list)
      (switch-to-buffer hny-buffer)
      (show-ball)
      (move-small-cannon)
      (shoot-small-cannon)
      (explode-ball)
      (show-flag-1)
      (move-rocket-rancher)
      (fire-rocket)
      (message "Hit space bar to flush this window!")
      (sit-for 30))
    (kill-buffer hny-buffer)
    (scroll-right 20)
    (setq truncate-lines tr-line)
    (set-screen-height sc-height))) 

(happy-new-year)
 

  
