(global-set-key "\C-h" 'delete-backward-char)
#(setq display-time-day-and-date t)
#(setq display-time-24hr-format t)
(display-time)
;; 駄目 表示更新時に 日本語に戻ってしまう orz      (let* ((system-time-locale "English")) (display-time))
;;(shell)

;; オートインデントでスペースを使う
;;(setq-default indent-tabs-mode nil)


; goto japanese sentence {start,end} M-a M-e
(setq sentence-end "[.?!][]\"')}]*\\($\\|\t\\|  \\)[ \t\n]*\\|\
[．。！？]+[]\"')}］”’）｝」]*"
      paragraph-separate "^$\\|^"
      paragraph-start "^　\\|^  [^ ]")

(require 'dvorak)
;;(to-dvorak)
;; (set-dvorak-function)
(defconst *dmacro-key* "\C-t" "繰返し指定キー")
(global-set-key *dmacro-key* 'dmacro-exec)
(autoload 'dmacro-exec "dmacro" nil t)


;; jupter setup
(autoload 'jupiter "jupiter/jupiter" nil t)
(setq jupiter:command "/home/hirai/gnu/jupiter/galileo")
(setq jupiter:menu "/home/hirai/gnu/jupiter/MENU")
;; coding form
(set-default 'default-tab-width 4)
;; keyword: universal-coding-system-argument
(defun find-euc-file-mada-dame (file-name)
  (interactive "FFind file:")
(universal-coding-system-argument
 'euc-japan
 (find-file file-name)
 )
)


;;
;; recentf and recentf-ext.el
;;
(require 'recentf)
(setq recentf-save-file "~/.emacs.d/.recentf")
(setq recentf-max-saved-items 1000)            ;; recentf に保存するファイルの数
(setq recentf-exclude '(".recentf"))           ;; .recentf自体は含まない
(setq recentf-auto-cleanup 10)                 ;; 保存する内容を整理
(run-with-idle-timer 30 t 'recentf-save-list)  ;; 30秒ごとに .recentf を保存
;;(autoload 'recentf-ext 'recentf-ext nil t)
