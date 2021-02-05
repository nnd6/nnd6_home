(setq exec-path (cons "C:/GNU/emacs/24.5-shared-libgcc-nodebug/libexec/emacs/24.5/ak2pr_bin" exec-path))
;;(set-language-environment "Japanese")
;;(set-default-coding-systems 'utf-8)
;;(set-keyboard-coding-system 'japanese-cp932) ;; おまじないかも

;;
(set-face-attribute 'default nil
        :family "Meiryo UI"
;;        :family "MS 明朝"
;;        :family "MS UI Gothic"
        :height 90)
(set-fontset-font "fontset-default"
        'japanese-jisx0208
        '("Meiryo UI" . "jisx0208-sjis")
;;           '("MSMS 明朝" . "jisx0208-sjis")
;;           '("MS UI Gothic" . "jisx0208-sjis")
		)

;;; IME の設定
(setq default-input-method "W32-IME")
(setq-default w32-ime-mode-line-state-indicator "[--]") ;; おこのみで
(setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]")) ;; おこのみで
(w32-ime-initialize)

;;; IME ON/OFF 時にカーソル色を変える。
(setq ime-activate-cursor-color "#00a000")
;;(setq ime-inactivate-cursor-color "#000000")
;; ダークテーマに対応 -- 初期値として現在のテーマに合わせて設定
(setq ime-inactivate-cursor-color (face-attribute 'cursor :background))
(set-cursor-color ime-inactivate-cursor-color)
;; ※input-method-activate-hook, input-method-inactivate-hook じゃない方がいい感じになる。
(add-hook 'w32-ime-on-hook
          (function (lambda ()
                      (set-cursor-color ime-activate-cursor-color))))
(add-hook 'w32-ime-off-hook
          (function (lambda ()
                      (set-cursor-color ime-inactivate-cursor-color)))) 

;;; isearchの時にIMEを使えるように。
(defun w32-isearch-update ()
  (interactive)
  (isearch-update))
(define-key isearch-mode-map [compend] 'w32-isearch-update)
(define-key isearch-mode-map [kanji] 'isearch-toggle-input-method)

;; ;;; shell の設定

;; ;;; Cygwin の bash を使う場合
;;(setq explicit-shell-file-name "bash")
;;(setq shell-file-name "sh")
;;(setq shell-command-switch "-c") 

;; ;;; Virtually UN*X!にある tcsh.exe を使う場合
;; (setq explicit-shell-file-name "tcsh.exe") 
;; (setq shell-file-name "tcsh.exe") 
;; (setq shell-command-switch "-c") 

;; ;;; WindowsNT に付属の CMD.EXE を使う場合。
;;(setq explicit-shell-file-name "CMD.EXE") 
;;(setq shell-file-name "CMD.EXE") 
;;(setq shell-command-switch "\\/c") 
;;(setq explicit-shell-file-name "cmdproxy.exe") 
;;(setq shell-file-name "cmdproxy.exe") 
;;(setq shell-command-switch "\\/c") 

;;;;;;;; coding setting
(when (equal emacs-major-version 21) (require 'un-define))
;;(set-language-environment "Japanese")
;;(set-keyboard-coding-system 'utf-8-unix)
(setq file-name-coding-system 'shift_jis)

;;;;;;; print設定
(setq lpr-command "ak2pr.exe")
(setq lpr-switches '())
(setq lpr-add-switches t)
(setq lpr-command-switches '())
