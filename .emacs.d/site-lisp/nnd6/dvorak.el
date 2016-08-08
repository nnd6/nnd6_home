;;
;;	dvorak.el 1.0	1989.05.18	Hirai T.
;;

(provide 'dvorak)

(defun to-dvorak (&optional is-local)
  "key-bind to dvorak"
  (interactive "P")
  (if is-local
      (make-variable-buffer-local 'keyboard-translate-table))
;;  (let ((save-now keyboard-translate-table) (i 0))
;;	Sharp OA keyboard.
;;  (setq keyboard-translate-table "\C-@\C-a\C-b\C-c\C-d\C-e\C-f\C-g\
;;\C-?\C-i\C-j\C-k\C-l\C-m\C-n\C-o\C-p\C-q\C-r\C-s\C-t\C-u\C-v\C-w\
;;\C-x\C-y\C-z\C-[\C-\\\C-]\C-^\C-_ !@#$%&*()_Sw=vz0123456789-sW+VZ/\
;;AXJE>UIDCHTNMBRL\"POYGK<QF:[\\{^`?\
;;axje.uidchtnmbrl'poygk,qf;]|}~\C-h\
;;" )
;;	Mips RS3230 keyboard.
  (setq keyboard-translate-table "\C-@\C-a\C-b\C-c\C-d\C-e\C-f\C-g\
\C-?\C-i\C-j\C-k\C-l\C-m\C-n\C-o\C-p\C-q\C-r\C-s\C-t\C-u\C-v\C-w\
\C-x\C-y\C-z\C-[\C-\\\C-]\C-^\C-_ !}#$%&{()*+w-vz0123456789SsW=VZ@\
AXJE>UIDCHTNMBRL\"POYGK<QF:/\\[^_`\
axje.uidchtnmbrl'poygk,qf;?|]~\C-h\
" )
;;  (while (< i 32)
;;    (aset keyboard-translate-table i (aref save-now i))))
  (if is-local
      (define-key global-map "\C-Ua" 'to-qwerty)
      (local-set-key "\C-Ua" 'to-qwerty))      
)
(defun to-qwerty ()
  "key-bind to qwery"
  (interactive)
  (setq keyboard-translate-table nil)
  (load-library "term/bobcat")
  (define-key global-map "\C-Ua" 'to-dvorak)
)

(defun set-dvorak-function ()
  ""
  (interactive)
  (setup-terminal-keymap Cursor-key-map
	'(("X" . ?d)	   ; down-arrow
	 ("J" . ?r)	   ; right-arrow
	 ("E" . ?l)))	   ; left-arrow
  (global-set-key "\e[" Cursor-key-map)
)

(defun make-local-key-table ()
  (interactive)
  (make-variable-buffer-local 'keyboard-translate-table)
)

(define-key global-map "\C-Ua" 'to-dvorak)
