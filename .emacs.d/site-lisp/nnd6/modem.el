;;;
;;; for AT command
;;;
(defun at-to-command-mode ()
  (interactive)
  (process-send-string (get-buffer-process (current-buffer)) "+++"))
(defun at-dial (tel)
  (process-send-string (get-buffer-process (current-buffer))
		       (concat "ATDP" tel "AG")))

;;;
;;; for ns-2012
;;;
(defun ns2012-joint-modem ()
  (interactive)
  (process-send-string (get-buffer-process (current-buffer))
		       (concat "joint tty10 -x 1b6b")))
(defun ns2012-detach-modem ()
  (interactive)
  (process-send-string (get-buffer-process (current-buffer)) "k"))

;;;
;;; for nifty
;;;
(defun connect-nifty ()
  (interactive)
  (process-send-string (get-buffer-process (current-buffer)) ".00+"))
(defun enter-passwd ()
;; require telnet.el
  (interactive)
  (process-send-string (get-buffer-process (current-buffer))
		       (concat
			(let ((echo-keystrokes 0)) (read-password))
			"")))
(defun dial-nifty ()
  (interactive)
  (at-dial "0742-36-0857"))
(defun dial-niftyf ()
  (interactive)
  (at-dial "0742-34-4191"))

(defun upload-region (start end)
  (interactive "r")
  (process-send-region (get-buffer-process (current-buffer))
		       start end)
)
