(defun recover-kanji ()
  (interactive)
  (let ((buffer-read-only nil)(kanji-flag nil))
    (save-excursion
      (goto-char (point-min))
      (while (search-forward "$" (point-max) t)
        (if (looking-at "[@B]")
            (let (beg)
              (backward-char 1)
              (insert ?\e)
              (forward-char 2)
              (setq beg (point))
              (while (and (search-forward "(" (point-max) t)
                          (not (and (looking-at "[JBH]")
                                    (= 1 (% (- (point) beg) 2))
                                    (progn
                                      (backward-char 1)
                                      (insert ?\e)
                                      t))))))))
      (convert-region-kanji-code (point-min) (point-max) 2 3))))

(defun recover-other-window ()
  (interactive)
  (save-excursion
    (set-buffer "*Article*")
    (recover-kanji)))

(setq gnus-Subject-mode-hook
   '(lambda ()
	(define-key gnus-Subject-mode-map "\C-r" 'recover-other-window)
 ))
