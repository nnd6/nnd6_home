;;
;; start-up routine
;;

(load "expand" 'missing-ok nil)
(require 'ml-lib)
(require 'eddiefunc)
(require 'slowsplit)


;; file
(setq track-eol t)
(setq kept-old-versions 0)
(setq kept-new-versions 1)
(setq backup-by-copying-when-linked t)
;;(setq backup-by-copying t)
(setq next-line-add-newlines nil)

;; buffer
(setq default-truncate-lines t)
(setq text-mode-hook '(lambda () (auto-fill-mode 1)))

;; use these commands
;; $AW"Rb$7$FJ9$&$(IJ=$AJ}(B
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'eval-expression 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'overwrite-mode 'disabled t)
