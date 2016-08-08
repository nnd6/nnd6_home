;;; -*- mode: lisp-interaction; syntax: elisp -*-
;;;
(if (not (fboundp 'normal-top-level-add-to-load-path))
    ;; subdirs.elがないシステムではここで.emacs_XXがおいてあるディレクトリをパスに加える
    (setq load-path (append load-path '("d:/hirai/gnu")))
)
;;;;;;;;;;;;;;;;;;;;;;;; Emacs system固有の設定 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(cond ((fboundp 'Meadow-version)
       (load ".emacs_Meadow" 'missing-ok nil))	;; Meadowだけの記述
      ((boundp 'MULE)
       (load ".emacs_Mule" 'missing-ok nil))	;; Mule for win32だけの記述
      ((fboundp 'nemacs-version)
       (load ".emacs_nemacs" 'missing-ok nil))	;; nemacsだけの記述
)
;;;;;;;;;;;;;;;;;;;;;;;; emacs の設定 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq next-line-add-newlines nil)
(load "term/bobcat" 'missing-ok nil)
;(line-number-mode t)

;;;;;;;;;;;;;;;;;;;;;;;; lispパッケージ毎の設定 ;;;;;;;;;;;;;;;;;;;;;;
(load ".emacs_gnus" 'missing-ok nil)

(setq smtp-server "islix")
(setq pop-server "beam")
(load ".emacs_mail" 'missing-ok nil)

;;平井徳行追加関数/設定
(load "start-up" 'missing-ok nil)

;; 個人的な設定
;;(load-file "/hirai/tcode/.emacs")
;;(load-file "/hirai/tcode/eelll-mule2.el")
