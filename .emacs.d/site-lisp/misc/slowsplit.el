; slowsplit.el
;; Response to a challenge to build a split-window with minimum redisplay.
;; In the interests of really doing this, it may move point (the case where
;; the new modeline would cover point).  Replacement for
;; split-window-vertically and delete-other-windows.
;; John Robinson, <jr@bbn.com>, 16 Mar 89
;; updated 20 Mar 89, to use window lines so narrowing/wrapping works

(provide 'slowsplit)

(global-set-key "\C-x2" 'split-window-quietly)
(global-set-key "\C-x1" 'delete-other-windows-quietly)

(defun split-window-quietly (&optional arg)
  "Split the window vertically with minimum redisplay.
This window becomes the uppermost of the two, and gets
ARG lines.  No arg means split equally."
  (interactive "P")
  (let* (
	  (num-arg (and arg (prefix-numeric-value arg)))
	  (oldpt (point))		
	  (oldstart (window-start))	
	  (scroll (or num-arg (/ (window-height) 2)))
	  (scrollpoint (progn (move-to-window-line scroll)
			 (point)))
	  (barstart (progn 
		      (move-to-window-line (- scroll 1))
		      (point)))
	  )
    (split-window nil num-arg)	   
    (goto-char oldstart)
    (recenter 0)
    (other-window 1)
    (goto-char scrollpoint)
    (recenter 0)
    (if (< oldpt scrollpoint )
      (if (>= oldpt barstart)
	(progn
	  (other-window -1)
	  (move-to-window-line (- scroll 2))
	  )
	(progn
	  (other-window -1)
	  (goto-char oldpt)
	  ))
      (progn
	(goto-char oldpt)
	))
    ))


(defun delete-other-windows-quietly ()
  "Delete other windows with minimum redisplay"
  (interactive)
  (let* ((oldpt (point))
	  (oldtopchar (window-start))
	  (oldtop (car (cdr (window-edges))))
	  )
    (delete-other-windows (selected-window))
    (goto-char oldtopchar)
    (recenter oldtop)
    (goto-char oldpt)))
