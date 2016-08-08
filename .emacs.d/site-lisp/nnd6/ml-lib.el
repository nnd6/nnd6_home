;;; @(#) mock lisp function on GNU emacs (1.0)
(provide 'ml-lib)

(defun beginning-of-window ()
        "mlisp function
move cusor to beginning of window
    Ref. move-to-window-line"
    (interactive)
    (move-to-window-line 0)
)
(defun end-of-window ()
        "mlisp function
move cusor to end of window
    Ref. move-to-window-line"
    (interactive)
    (move-to-window-line -1)
)
(defun scroll-one-line-up ()
  "mlisp function :
Scroll text of current window upward 1 line.
... ref. scroll-up()"
    (interactive)
    (scroll-up 1)
)
(defun scroll-one-line-down ()
  "mlisp function :
Scroll text of current window downward 1 line.
... ref. scroll-down()"
    (interactive)
    (scroll-down 1)
)
(defun line-to-top-of-window ()
    "mlisp function :
Scroll text of current window. the cursor position is  top of window"
    (interactive)
    (recenter 0)
)



(defun no-backup-save-buffer ()
  "save buffer without backup file"
  (interactive)
  (if make-backup-files
    (progn
      (defconst make-backup-files nil)
      (save-buffer)
      (defconst make-backup-files t))
    (save-buffer)))

(defun save-lines (&optional count)
  "save lines."
  (interactive "p")
  (or count (setq count 1))
  (beginning-of-line)
  (let* ((save-beg (point)))
    (next-line count)
    (copy-region-as-kill save-beg (point)))
  (message "%d line saved" count))

(defun save-lines-and-yank (&optional count)
  "save lines and yank."
  (interactive "p")
  (or count (setq count 1))
  (beginning-of-line)
  (let* ((save-beg (point)))
    (next-line count)
    (copy-region-as-kill save-beg (point)))
  (yank)
  (previous-line count)
  (message "%d line saved" count))
