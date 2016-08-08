;; useful-c.el                    Copyright (C), Shinji Kamikaseda
;;
;;                                Aug. 25, 1989 in Yamanashi Univ.

;;   このソフトウェアの著作権は全て、上加世田 真二 に所属します。が、
;; Free Software Foundation の著作物一般公的使用許諾に該当される限りにおいて、
;; このソフトウェアの使用並びに再配布が認められます。
;; （って書いておけばいいのかな？:-) おかしなこと書いてたらどうしよう？;-(）

;;   useful-c.el は GNU Emacs の c-mode.el を、いくぶん使いやすくしたものです。
;;   useful-c.el の使用は、 c-mode.el の所有が前提条件となります。
;;   useful-c.el の使用によって、あなたのＣプログラミングライフが少しでも楽しい
;; ものになれば幸いです。:-)

;;   useful-c.el を使用するには useful-c.el 自身を変数 load-path で指定された
;; ディレクトリに配置し、.emacs その他の GNU Emacs の初期化ファイルに
;; (setq c-mode-hook '(lambda () (load "useful-c"))
;; と、書き込んで下さい。

;;   ところで私は c-mode の制御変数を
;; (setq c-indent-level 6)
;; (setq c-continued-statement-offset 6)
;; (setq c-brace-imaginary-offset 0)
;; (setq c-argdecl-indent 6)
;; (setq c-label-offset -3)
;; などとしていますが、他の人はどうしてますか？

(defvar c-kernel-style nil
; Kernel Style を使うかどうか制御する変数。
  nil)

(defvar c-indent-newline-indent t
; RET を関数 c-indent-newline-indent にバインドするかどうか制御する変数。
  nil)

(defvar insert-parentheses t
; '(' を関数 insert-parentheses にバインドするかどうか制御する変数。
  nil)

(defvar insert-bracket t
; '[' を関数 insert-bracket にバインドするかどうか制御する変数。
  nil)

(defvar c-insert-brace t
; '{' を関数 c-insert-brace にバインドするかどうか制御する変数。
  nil)

(defvar electric-c-preprosessor t
; '#' を関数 electric-c-preprosessor にバインドするかどうか制御する変数。
  nil)

(defvar insert-single-quotation t
; ' を関数 insert-single-quotation にバインドするかどうか制御する変数。
  nil)

(defvar insert-double-quotation t
; " を関数 insert-double-quotation にバインドするかどうか制御する変数。
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
; カレント行をインデントして改行し、次の行をもインデントする関数。
  (interactive)
  (c-indent-command)
  (newline)
  (c-indent-command))

(defun insert-bracket () nil
; '[' の挿入に合わせて ']' の挿入も行う関数。
  (interactive)
  (insert "[]")
  (backward-char))

(defun c-insert-brace () nil
; '{' が挿入されると '}' を２（３）行目に挿入し、全行をインデントして、
;  ポイントを '{' と '}' の間の行の最高尾に移す関数。
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
; #d が入力されれば #defineSPC を、#iSPC または #iTAB が入力
;  されれば #includeSPC を挿入する関数。
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
; ' が入力されると '' を挿入する関数。
  (interactive)
  (insert "''")
  (backward-char))

(defun insert-double-quotation () nil
; " が入力されると "" を挿入する関数。
  (interactive)
  (insert-char 34 2)
  (backward-char))

