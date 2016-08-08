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
;;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
;; from .emacs
;;(package-initialize)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;;; (install-elisp "http://www.rubyist.net/~rubikitch/archive/init-loader-x.el")
(require 'init-loader-x )
(init-loader-load "~/.emacs.d/inits")

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
;;(set-buffer-file-coding-system 'utf-8-unix)
;;(setq default-buffer-file-coding-system 'utf-8-unix)
;;(prefer-coding-system 'utf-8-unix)
;;(set-default-coding-systems 'utf-8-unix)
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
