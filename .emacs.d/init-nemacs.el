;;
;; .emacs for nemacs
;;
;; ntext set
      (define-service-kanji-code "lpr" nil 2)
      (define-program-kanji-code "lpr" nil 2)
      (define-service-kanji-code "ls" nil 1)
      (define-program-kanji-code "ls" nil 1)
      (if (fboundp 'wnn-server-open)
	  (setq boiled-egg-mode-hook
		'(lambda ()
		   (local-set-key "\033Oz" 'rK-trans)
		   (local-set-key "\033O{" 'rhkR-trans))))

