(provide 'TVreserv)

;;タイトルを変更 / 推奨しない
(setq system-name "TV予約システム")
;; メニューバーを消す
(menu-bar-mode -1)

(defun TVreserv (yoyaku)
  (switch-to-buffer "* SHARP TV予約システム *")
  (delete-other-windows-quietly)
  (end-of-buffer)
  (if (not (eq (buffer-size) 0))
      (insert-string "---------------------------------\n"))
  (insert-string yoyaku)
  (insert-string "\n\n予約を受け付けました\n")
)
