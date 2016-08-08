;;; GNU Emacs code converted from Mocklisp
(require 'mlsupport)

(progn i
    (setq i ?\ )
    (while (not (zerop (< i 0177)))
	(local-bind-to-key "self-insert" i)
	(setq i (+ i 1)))
)
