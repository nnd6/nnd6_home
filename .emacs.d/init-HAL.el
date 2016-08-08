;;; -*- mode: lisp-interaction; syntax: elisp -*-
;;;
(if (not (fboundp 'normal-top-level-add-to-load-path))
    ;; subdirs.el���Ȃ��V�X�e���ł͂�����.emacs_XX�������Ă���f�B���N�g�����p�X�ɉ�����
    (setq load-path (append load-path '("d:/hirai/gnu")))
)
;;;;;;;;;;;;;;;;;;;;;;;; Emacs system�ŗL�̐ݒ� ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(cond ((fboundp 'Meadow-version)
       (load ".emacs_Meadow" 'missing-ok nil))	;; Meadow�����̋L�q
      ((boundp 'MULE)
       (load ".emacs_Mule" 'missing-ok nil))	;; Mule for win32�����̋L�q
      ((fboundp 'nemacs-version)
       (load ".emacs_nemacs" 'missing-ok nil))	;; nemacs�����̋L�q
)
;;;;;;;;;;;;;;;;;;;;;;;; emacs �̐ݒ� ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq next-line-add-newlines nil)
(load "term/bobcat" 'missing-ok nil)
;(line-number-mode t)

;;;;;;;;;;;;;;;;;;;;;;;; lisp�p�b�P�[�W���̐ݒ� ;;;;;;;;;;;;;;;;;;;;;;
(load ".emacs_gnus" 'missing-ok nil)

(setq smtp-server "islix")
(setq pop-server "beam")
(load ".emacs_mail" 'missing-ok nil)

;;���䓿�s�ǉ��֐�/�ݒ�
(load "start-up" 'missing-ok nil)

;; �l�I�Ȑݒ�
;;(load-file "/hirai/tcode/.emacs")
;;(load-file "/hirai/tcode/eelll-mule2.el")
