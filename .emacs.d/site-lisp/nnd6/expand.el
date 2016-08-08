;;;	@(#) expand command by nnd6
;;	make-comment-box	1.1
;;	escape-work		1.0
;;	visit-function		1.0
;;	toggle-truncate-lines	1.0
;;	current-row		1.0
;;	close-line		1.0
;;	save-some-buffers-no-question	1.0
;;	inc-insert-number	1.0
;;	inc-insert-character	1.0
;
(provide 'expand)
(defun save-some-buffers-no-question ()
  (interactive)
  (save-some-buffers t))

(defun make-comment-box ()
    "Making comment box for function header."
    (interactive "*")
    (beginning-of-line)
    (insert-string "\t/****************/\n")
    (insert-string "\t/*\t\t*/\n")
    (insert-string "\t/****************/\n")
    (previous-line 2)
    (forward-char 3)
)
(defun escape-work ()
    "Escape to another work for a time. 
Finish the work, execute \'exit-recursive-edit\' then 
go back initial world."
    (interactive)
    (save-excursion (save-window-excursion
	(recursive-edit)
    ))
)
;;
(defun visit-function ()
    "Find tag (in current tag table) like find-tag(function).
This is same without this function is into recursive edit."
    (interactive)
    (save-excursion (save-window-excursion
	(find-tag "")
	(recursive-edit)
    ))
)
(defun new-visit-function ()
    "Find tag (in current tag table) like find-tag(function).
This is same without this function is into recursive edit."
    (interactive)
    (let ((config (current-window-configuration)))
      (find-tag "")
      (make-local-variable 'tags-parent-window-config)
      (setq tags-parent-window-config config)
    )
)
(defun tags-return ()
  ""
  (interactive)
  (if tags-parent-window-config
      (set-window-configuration tags-parent-window-config)))
;;
(defun toggle-truncate-lines (&optional switch)
    "switch the variable `truncate-lines'
	case argument `switch'
	0: nil
	1: t
       *2: toggle t and nil"
    (interactive)
    (setq switch (or switch 2))
    (cond
    ((equal switch 0)
	(setq truncate-lines nil)
    )
    ((equal switch 1)
	(setq truncate-lines t)
    )
    (t
	(setq truncate-lines (not truncate-lines))
    )
    )
    (recenter (current-row))
    truncate-lines
)
;;
;;(defun current-row ()
;;    "return current row in WINDOW"
;;    (if (pos-visible-in-window-p)
;;	(progn 
;;	    (setq original-dot (dot))
;;	    (goto-char (window-start))
;;	    (setq current-row-num 0)
;;	    (while (>= original-dot (dot))
;;		(next-line 1)
;;		(setq current-row-num (+ current-row-num 1))
;;	    )
;;	    (goto-char original-dot)
;;	    (- current-row-num 1)
;;	)
;;	nil
;;  )
;;)
(defun current-row ()
  (what-line)
  )

(defun close-line nil
  (interactive)
  (end-of-line nil)
  (delete-char 1)
  (delete-horizontal-space)
  (insert-char ?\  1)
)

(defvar default-mail-return-path nil)

(defun my-mail-return-path (return-path)
;;  (interactive (if (null default-mail-return-path)
;;		   "sReturn-Path: "
;;	失	 (concat
;;	敗	  "sReturn-Path: (default "
;;		  default-mail-return-path
;;		  ") ")))
  (interactive "sReturn-Path: ")
  (if (string= return-path "")
      (if (not (null default-mail-return-path))
	  (setq return-path default-mail-return-path)))
  (if (string= return-path "")
    (mail-return-path)
     (save-excursion
	(mail-return-path)
	(insert return-path))
     ))



(defun ring-a-bell ()
  (interactive)
  (send-string-to-terminal "")
)
(defun mail-return-path ()
  "Move point to end of Return-Path-field. create Return-Path field if none."
  (interactive)
  (expand-abbrev)
  (or (mail-position-on-field "return-path" t)
      (progn (mail-position-on-field "subject")
	     (insert "\nReturn-Path: ")))
)

(defvar default-mail-from nil)
(defun my-mail-from (from)
  (interactive "sFrom: ")
  (if (string= from "")
      (if (not (null default-mail-from))
	  (setq from default-mail-from)))
  (if (string= from "")
    (mail-from)
     (save-excursion
	(mail-from)
	(insert from))
     ))

(defun mail-from ()
  "Move point to end of From-field. create From field if none."
  (interactive)
  (expand-abbrev)
  (or (mail-position-on-field "from" t)
      (progn (mail-position-on-field "subject")
	     (insert "\nFrom: ")))
)

(defvar default-mail-bcc nil)
(defun my-mail-bcc (bcc)
  (interactive "sBcc: ")
  (if (string= bcc "")
      (if (not (null default-mail-bcc))
	  (setq bcc default-mail-bcc)))
  (if (string= bcc "")
    (mail-bcc)
     (save-excursion
	(mail-bcc)
	(insert bcc))
     ))

(defun mail-bcc ()
  "Move point to end of Bcc-field. create Bcc field if none."
  (interactive)
  (expand-abbrev)
  (or (mail-position-on-field "bcc" t)
      (progn (mail-position-on-field "subject")
	     (insert "\nBcc: ")))
)




(defun inc-insert-numeric ()
  "callされるたびに挿入する数値を増やす。keyboad macro で使用すると便利。
previx-arg を与えるとその値に数値を初期化する。"
  (interactive)
  (if current-prefix-arg
      (setq inc-insert-num current-prefix-arg)
    (if (not (boundp 'inc-insert-num))
	(error "最初はpre-fix arg を与えて実行してください。")
      (setq inc-insert-num (1+ inc-insert-num))))
    (insert-string inc-insert-num)
    inc-insert-num)

(defun inc-insert-character ()
  "callされるたびに挿入するascii codeを増やす。keyboad macro で使用すると便利。
previx-arg を与えるとその値に数値を初期化する。"
  (interactive)
  (if current-prefix-arg
      (setq inc-insert-char current-prefix-arg)
    (if (not (boundp 'inc-insert-char))
	(error "最初はpre-fix arg を与えて実行してください。")
      (setq inc-insert-char (1+ inc-insert-char))))
      (insert inc-insert-char))

(defun inc-insert-bit ()
  "callされるたびに挿入するbit pattern をshiftする。keyboad macro で使
用すると便利。previx-arg を与えるとその値に数値を初期化する。"
  (interactive)
  (if current-prefix-arg
      (setq inc-insert-char current-prefix-arg)
    (if (not (boundp 'inc-insert-char))
	(error "最初はpre-fix arg を与えて実行してください。")
      (setq inc-insert-char (* 2 inc-insert-char))))
      (insert (format "0x%x" inc-insert-char)))

(defun scroll-other-window-reverse ()
  "Scroll text of next window downward ARG lines; or near full screen if no ARG.
The next window is the one below the current one; or the one at the top
if the current one is at the bottom.
When calling from a program, supply a number as argument or nil."
  (interactive)
  (other-window 1)
  (scroll-down current-prefix-arg)
  (other-window 1)
)

;;
;; 下記２つは
;; miyata@netg.ksp.fujixerox.co.jp (Takashi Miyata)氏の作
;;
(defun previous-window-line (n)
  (interactive "p")
  (let ((cur-col
         (- (current-column)
            (save-excursion (vertical-motion 0) (current-column)))))
    (vertical-motion (- n))
    (move-to-column (+ (current-column) cur-col))))

(defun next-window-line (n)
  (interactive "p")
  (let ((cur-col
         (- (current-column)
            (save-excursion (vertical-motion 0) (current-column)))))
    (vertical-motion n)
    (move-to-column (+ (current-column) cur-col))))
(defun BS-exec ()
  ""
  (interactive)
  (while (search-forward "" (buffer-size) t)
      (delete-backward-char 1)
      (delete-char 1)))

(defun vi-type-paren-match (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "[([{]") (forward-sexp 1) (backward-char))
        ((looking-at "[])}]") (forward-char) (backward-sexp 1))
        (t (self-insert-command (or arg 1)))))

(defun set-buffer-correct-coding-system(coding-system &optional force nomodify)
  "Correct coding system"
  (interactive
   (let ((default (and buffer-file-coding-system
		       (not (eq (coding-system-type buffer-file-coding-system)
				'undecided))
		       buffer-file-coding-system)))
     (list (read-coding-system
	    (if default
		(format "Coding system for following command (default %s): " default)
	      "Coding system for following command: ")
	    default))
  (let ((coding-system-for-read default)
        (coding-system-for-write default)
        (coding-system-require-warning t))
    (find-alternate-file buffer-file-name)))))

(global-set-key [(super c)] 'set-buffer-correct-coding-system)
