(provide 'TVreserv)

;;�^�C�g����ύX / �������Ȃ�
(setq system-name "TV�\��V�X�e��")
;; ���j���[�o�[������
(menu-bar-mode -1)

(defun TVreserv (yoyaku)
  (switch-to-buffer "* SHARP TV�\��V�X�e�� *")
  (delete-other-windows-quietly)
  (end-of-buffer)
  (if (not (eq (buffer-size) 0))
      (insert-string "---------------------------------\n"))
  (insert-string yoyaku)
  (insert-string "\n\n�\����󂯕t���܂���\n")
)
