;; useful-c.el                    Copyright (C), Shinji Kamikaseda
;;
;;                                Aug. 25, 1989 in Yamanashi Univ.

;;   ���Υ��եȥ���������������ơ�������� ���� �˽�°���ޤ�������
;; Free Software Foundation ������ʪ���̸�Ū���ѵ����˳��������¤�ˤ����ơ�
;; ���Υ��եȥ������λ����¤Ӥ˺����ۤ�ǧ����ޤ���
;; �ʤäƽ񤤤Ƥ����Ф����Τ��ʡ�:-) �������ʤ��Ƚ񤤤Ƥ���ɤ����褦��;-(��

;;   useful-c.el �� GNU Emacs �� c-mode.el �򡢤����֤�Ȥ��䤹��������ΤǤ���
;;   useful-c.el �λ��Ѥϡ� c-mode.el �ν�ͭ��������Ȥʤ�ޤ���
;;   useful-c.el �λ��Ѥˤ�äơ����ʤ��Σåץ���ߥ󥰥饤�դ������Ǥ�ڤ���
;; ��Τˤʤ�й����Ǥ���:-)

;;   useful-c.el ����Ѥ���ˤ� useful-c.el ���Ȥ��ѿ� load-path �ǻ��ꤵ�줿
;; �ǥ��쥯�ȥ�����֤���.emacs ����¾�� GNU Emacs �ν�����ե������
;; (setq c-mode-hook '(lambda () (load "useful-c"))
;; �ȡ��񤭹���ǲ�������

;;   �Ȥ���ǻ�� c-mode �������ѿ���
;; (setq c-indent-level 6)
;; (setq c-continued-statement-offset 6)
;; (setq c-brace-imaginary-offset 0)
;; (setq c-argdecl-indent 6)
;; (setq c-label-offset -3)
;; �ʤɤȤ��Ƥ��ޤ�����¾�οͤϤɤ����Ƥޤ�����

(defvar c-kernel-style nil
; Kernel Style ��Ȥ����ɤ������椹���ѿ���
  nil)

(defvar c-indent-newline-indent t
; RET ��ؿ� c-indent-newline-indent �˥Х���ɤ��뤫�ɤ������椹���ѿ���
  nil)

(defvar insert-parentheses t
; '(' ��ؿ� insert-parentheses �˥Х���ɤ��뤫�ɤ������椹���ѿ���
  nil)

(defvar insert-bracket t
; '[' ��ؿ� insert-bracket �˥Х���ɤ��뤫�ɤ������椹���ѿ���
  nil)

(defvar c-insert-brace t
; '{' ��ؿ� c-insert-brace �˥Х���ɤ��뤫�ɤ������椹���ѿ���
  nil)

(defvar electric-c-preprosessor t
; '#' ��ؿ� electric-c-preprosessor �˥Х���ɤ��뤫�ɤ������椹���ѿ���
  nil)

(defvar insert-single-quotation t
; ' ��ؿ� insert-single-quotation �˥Х���ɤ��뤫�ɤ������椹���ѿ���
  nil)

(defvar insert-double-quotation t
; " ��ؿ� insert-double-quotation �˥Х���ɤ��뤫�ɤ������椹���ѿ���
  nil)

(setq c-auto-newline t)

(if c-indent-newline-indent
    (define-key c-mode-map "\C-m" 'c-indent-newline-indent))

(if insert-parentheses
    (define-key c-mode-map "(" 'insert-parentheses))

(if insert-bracket
    (define-key c-mode-map "[" 'insert-bracket))

(if c-insert-brace
    (define-key c-mode-map "{" 'c-insert-brace))

(if electric-c-preprosessor
    (define-key c-mode-map "#" 'electric-c-preprosessor))

(if insert-single-quotation
    (define-key c-mode-map "'" 'insert-single-quotation))

(if insert-double-quotation
    (define-key c-mode-map """" 'insert-double-quotation))

(defun c-indent-newline-indent () nil
; �����ȹԤ򥤥�ǥ�Ȥ��Ʋ��Ԥ������ιԤ�⥤��ǥ�Ȥ���ؿ���
  (interactive)
  (c-indent-command)
  (newline)
  (c-indent-command))

(defun insert-bracket () nil
; '[' �������˹�碌�� ']' ��������Ԥ��ؿ���
  (interactive)
  (insert "[]")
  (backward-char))

(defun c-insert-brace () nil
; '{' ������������ '}' �򣲡ʣ��˹��ܤ������������Ԥ򥤥�ǥ�Ȥ��ơ�
;  �ݥ���Ȥ� '{' �� '}' �δ֤ιԤκǹ����˰ܤ��ؿ���
  (interactive)
  (if c-kernel-style nil
     (newline)
     (c-indent-command))
  (insert "{")
  (c-indent-command)
  (newline)(newline)
  (insert "}")(c-indent-command)
  (call-interactively 'previous-line)(c-indent-command))

(defun electric-c-preprosessor () nil
; #d �����Ϥ����� #defineSPC ��#iSPC �ޤ��� #iTAB ������
;  ������ #includeSPC ����������ؿ���
  (interactive)
  (insert "#")
  (setq char (read-char))
  (if (eq 100 char)
      (insert "define ")
    (if (eq 105 char)
	(progn (insert-char char 1)
	       (setq char (read-char))
	       (if (or (eq 32 char)
		       (eq 9 char))
		   (insert "nclude ")
		 (insert-char char 1)))
      (insert-char char 1))))

(defun insert-single-quotation () nil
; ' �����Ϥ����� '' ����������ؿ���
  (interactive)
  (insert "''")
  (backward-char))

(defun insert-double-quotation () nil
; " �����Ϥ����� "" ����������ؿ���
  (interactive)
  (insert-char 34 2)
  (backward-char))

