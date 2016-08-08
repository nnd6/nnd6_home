;;
;;	kmacs like command
;;
(provide 'eddiefunc)

(defun string-car (string)
  (cond ((null (string= string "")) nil
	 t      (substring string 0 (string-match " " string)))))
(defun string-cdr (string)
  (let (first)
    (cond ((setq first (string-match " " string)) nil
	   t      (substring string (1+ first) nil)))))

;;(defun pipe-region (start end program)
;;  "Execute 
;;  (interactive "r
;;sExec Pipe to Mark: ")
;;  (call-process-region start end "/bin/sh" nil nil nil
;;		       "-c" (concat "exec " program))
;;)
;;(defun pipe-buffer (program)
;;  (interactive "sExec Pipe: ")
;;  (call-process-region start end "/bin/sh" nil nil nil
;;		       "-c" (concat "exec " program))
;;)

(defun goto-mark ()
  (interactive)
  (goto-char (mark)))
(defun copy-line ()
  (interactive)
    (set-mark-command nil)
    (if (eolp)
	(forward-char 1)
	(end-of-line))
    (copy-region-as-kill (mark) (point))
)
