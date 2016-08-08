;;; Date: Thu, 10 Mar 88 17:13:14 pst
;;; Message-Id: <8803110113.AA25984@ssc-vax>
;;; In-Reply-To: John A Dilley's message of Thu, 10 Mar 88 09:38:52 MST <8803101638.AA17135@hpcndm.HP.COM>
;;; 
;;; Here is what we use here for completion in shell-mode.  It is
;;; currently working on version 18.44.1 on BSD 4.3 Unix.  The best way to
;;; load it is with a shell-mode-hook as follows:
;;; 
;;; (setq shell-mode-hook
;;;       '(lambda ()
;;; 	 (require 'shell-completion "shell-completion")
;;; 	 (process-kill-without-query (get-process "shell"))))
;;; 
;;; To get completion at any point, type <TAB>.
;;; 
;;; If anyone makes improvements on this please send them to me and/or
;;; info-gnu.
;;; 
;;; Gregg Lobdell
;;; Boeing Aerospace Co.          usenet: {theknownworld}!uw-beaver!ssc-vax!gml
;;; Seattle, WA                   arpanet: ssc-vax!gml@beaver.cs.washington.edu
;;; 
;;; 
;;; ------------------------------ cut here ------------------------------
;;;
;;; Functions to provide filename completion in the shell.
;;;

;;; Do shell completion.

(defun shell-completion ()
  "\
  Provide filename completion for a c-shell command."
  (interactive)
  (save-excursion
    (let* ((enable-recursive-minibuffers t)
           (end-of-filename (point))
           (beginning-of-filename
              (progn (re-search-backward "[ \t]" nil t)
                     (forward-char 1)
                     (point)))
           ;; Grab the last argument typed.
           (initial-string (buffer-substring beginning-of-filename
                                             end-of-filename))
           ;; Do completion.
           (pathname
              (read-file-name
                 "Filename: "
                 (expand-file-name
                    (concat (if (file-name-directory initial-string)
                                (expand-file-name
                                   (file-name-directory initial-string))
                                default-directory)
                            (file-name-completion
                               (file-name-nondirectory initial-string)
                               (if (file-name-directory initial-string)
                                   (expand-file-name
                                      (file-name-directory
                                         initial-string))
                                   default-directory))))
                 nil nil))
           ;; Get absolute pathname for testing against default directory.
           (abs-pathname (expand-file-name pathname))
           ;; Put default-directory value into dummy for manipulation.
           (test-dir default-directory))
          ;; Insert results of completion.
          (kill-region beginning-of-filename end-of-filename)
          (insert-string
             (cond ((string-equal test-dir abs-pathname) "")
                   ((and (< (length test-dir) (length abs-pathname))
                         (string-equal test-dir
                                       (substring abs-pathname
                                                  0
                                                  (length test-dir))))
                    (substring abs-pathname (length test-dir)))
                   ((and (<= (length (setq test-dir
                                       (file-name-directory
                                          (substring test-dir 0 -1))))
                            (length abs-pathname))
                         (string-equal test-dir
                                       (substring
                                          abs-pathname
                                          0
                                          (length test-dir))))
                    (concat "../" (substring abs-pathname (length test-dir))))
                   (t pathname)))))
    (end-of-line))

(define-key shell-mode-map "\t" 'shell-completion)

(provide 'shell-completion)

