;; c-mode definition
(add-hook 'c-mode-common-hook 
	  '(lambda ()
	     ;; VCと一緒に使おうとするとこれがあると便利
	     (setq tab-width 4)
	     ;; c-mode
	     (setq c-tab-always-indent nil)
	     (setq c-indent-level 4)
	     (setq c-brace-imaginary-offset 0)
	     (setq c-brace-offset -4)
	     (setq c-argdecl-indent 1)
	     (setq c-label-offset -4)
	     (setq c-continued-statement-offset 4)
	     (setq c-continued-brace-offset 0)
	     (setq c-auto-newline nil)
	     ;; cc-mode
	     (c-set-style "cc-mode")
	     ;; sample (小関さん)
	     ;; offset customizations not in my-c-style
	     ;; (c-set-offset 'member-init-intro '++)  ;; tab-width  (setq tab-width 4)
	     ;; this will make sure spaces are used instead of tabs
	     ;; (setq indent-tabs-mode nil)  ;; we like auto-newline and hungry-delete
	     ;; (c-toggle-auto-hungry-state 1)
	     ;; keybindings for C, C++, and Objective-C.  We can put these in
	     ;; c-mode-map because c++-mode-map and objc-mode-map inherit it
	     (define-key c-mode-map "\C-m" 'newline-and-indent)  ;;; match-paren
	     ))
;;
;;(require 'cmutex-set)
;;(setq cmutex-load-hook 
;;      (list cmutex-load-hook '(lambda () 
;;				(setq tex-command "jlatex")
;;				(setq tex-view-dvi-file-command "jxdvi %s")
;;				(setq tex-show-queue-command "lpq -Plw22")
;;				(setq tex-dvi-print-command "jdvi2kps %s |lpr -Plw22 -m")))
;;)
;; mail mode 
;;(setq mail-setup-hook
;;      '(lambda ()
;;	 (my-mail-from (concat (user-login-name) "@isl.nara.sharp.co.jp"))
;;	 (my-mail-bcc (concat (user-login-name) "@isl.nara.sharp.co.jp"))
;;	 ))
