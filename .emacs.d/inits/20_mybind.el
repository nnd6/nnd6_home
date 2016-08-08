;; my bindings
(if (keymapp (lookup-key global-map "\E\E"))
    (global-unset-key "\e\e"))
(global-unset-key "\C-X\C-L")
;;(load "mybind" 'missing-ok nil)
;;(define-key global-map	"\C-A"	nnd6-map)
(define-key esc-map	"h"	'backward-kill-word)
(define-key global-map	"\C-z"	'scroll-one-line-up)
(define-key ctl-x-map	"!"	'shell-command)
;;(define-key ctl-x-map	"\C-M"	'save-some-buffers-no-question)
(define-key ctl-x-map	"\C-M"	'save-some-buffers)
(define-key ctl-x-map	"V"	'find-file-other-window)
(define-key esc-map	"?"	'apropos)
(define-key esc-map	"p"	'scroll-one-line-down)
(define-key esc-map	"o"	'occur)
(define-key esc-map	"n"	'scroll-one-line-up)
(define-key minibuffer-local-completion-map
			" "	'minibuffer-complete)
(define-key minibuffer-local-completion-map
			"\C-I"	'minibuffer-complete-word)
(define-key minibuffer-local-must-match-map
			" "	'minibuffer-complete)
(define-key minibuffer-local-must-match-map
			"\C-I"	'minibuffer-complete-word)
