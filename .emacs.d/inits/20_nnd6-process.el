;; shell mode
;;(setq shell-prompt-pattern "^[^#$%>*]*\\([#$%>*]\\)\\1? *")

(setq shell-mode-hook
      '(lambda ()
	 (require 'shell-completion "sh-complet")
;;	 (require 'force-emacs-follow-shell "newPathset")
	 (process-kill-without-query (get-buffer-process (current-buffer)))
;;         (define-key shell-mode-map "\C-c\C-f" 'force-emacs-follow-shell)
	 ))
