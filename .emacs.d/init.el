;;; -*- mode: lisp-interaction; syntax: elisp -*-
;;;

(setq
 my-name      "Hirai, Tokuyuki"
 e-mail	      "t.hirai@kodensha.jp"
 ;; my-load-path "C:/HIRAI/MyEnv/emacs/site-lisp"
 my-load-path (concat (getenv "HOME") "/.emacs.d/site-lisp")
 pop-server   "www.kodensha.jp"
 pop-login    "t.hirai"
 smtp-server  "www.kodensha.jp"
 my-domain    "kodensha.jp"
 my-nntp-server	"islix"
 )


    ;;; ref. http://masutaka.net/chalow/2009-07-05-3.html ;;;;
(dolist (dir (let ((dir (expand-file-name my-load-path)))
               (list dir (format "%s_%d" dir emacs-major-version))))
  (when (and (stringp dir) (file-directory-p dir))
    (let ((default-directory dir))
      (add-to-list 'load-path default-directory)
      (normal-top-level-add-subdirs-to-load-path))))
    ;;;   ;;;   ;;;  ;;;   ;;;   ;;;  ;;;

(require 'package)
(setq package-user-dir (concat my-load-path "/elpa")) ;; 
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
;; for ein (jupyter notebook)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
;; from .emacs
;;(package-initialize)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;;; (install-elisp "http://www.rubyist.net/~rubikitch/archive/init-loader-x.el")
(require 'init-loader-x )
(init-loader-load "~/.emacs.d/inits")

(load-theme 'tango-dark t)	;;; 2020/11/20
;;(load-theme 'soothe t)		;;; 2020/11/25


;;
(cd "~")

;;; init file for emacs-type.
(cond 
 ((fboundp 'nemacs-version)
 (load-file "~/.emacs.d/init-nemacs.el")
 )
 ((boundp 'MULE) 
  ;; mule for win32 特有の設定
  )
 ((featurep 'meadow)
  ;; Meadow 特有の設定
  (load "~/.emacs.d/init-Meadow.el")
  )
)
;;;
;;; init file for Environment specific.
;;;
(cond 
 ((eq window-system 'w32)
  (load "~/.emacs.d/init-windows.el")
  )
 ((eq window-system 'x)
  (load "~/.emacs.d/init-X.el")
  )
 (t
;;  (load-file ".emacs-windows")
  )
 )

(cond (window-system
       ;;++ hilit
       (setq hilit-mode-enable-list  '(not text-mode)
             hilit-background-mode   'light
             hilit-inhibit-hooks     nil
	     hilit-inhibit-rebinding nil)
       (if (fboundp 'meadow) (require 'hilit19))
       ;;++ window size
       (setq default-frame-alist (append (list '(width . 80) '(height . 30))))
	   ;; hirai
	   (menu-bar-mode -1)
	   (tool-bar-mode -1)
       ))
;;;;
;;;
;;;;
;;
;;(set-language-environment "Japanese")
;;(set-terminal-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq backup-by-copying-when-linked t)

;;(set-keyboard-coding-system 'sjis)

;; gnuservの設定
;;(require 'gnuserv)
;;(gnuserv-start)
;;(setq gnuserv-frame (selected-frame))
(server-start)

;; 同じファイル名の表示を見やすく
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;ファイルを開くときに大文字小文字の違いを無視
;;(setq read-buffer-completion-ignore-case t)    ;; バッファ名
(setq read-file-name-completion-ignore-case t) ;; ファイル名

(setq split-width-threshold nil)		;; 縦分割の抑止 ^Xbなどで。
;; (setq split-height-threshold xx)	;; 横分割の抑止

;; text-modeでauto-fillをOFFにする
(remove-hook 'text-mode-hook (lambda nil (auto-fill-mode 1)))

;;; VBA mode
 (autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
 (setq auto-mode-alist (append '(("\\.\frm\\|bas\\|cls\$" .
                                 visual-basic-mode)) auto-mode-alist))
;;;M-x eval-expression
;;;    (setq require-final-newline nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(soothe-theme eink-theme ein-mumamo ein srefactor markdown-mode helm-orgcard helm-migemo helm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; 余計な空白を色付きで表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

;; 履歴
(recentf-mode t)
(setq recentf-max-menu-items 30)
(setq recentf-max-saved-items 5000)

;; Jupyter notebook
(require 'ein)
