From: hirano@ten.fujitsu.co.jp (HIRANO toshihiro)
Newsgroups: fj.editor.emacs
Subject: desktop.el
Date: 20 Aug 93 06:43:57 GMT
Distribution: fj
Organization: Fujitsu TEN LTD., Kobe, Japan.
In-reply-to: hirano@ten.fujitsu.co.jp's message of 18 Aug 93 13:09:09 JST


平野＠富士通テンです。

何人かの方から desktop.el をメールで送ってくれとの御要望がありましたが、
面倒になってきたのでここに転載します。

saveconf.el については、磯部さんの質問記事よりだいぶ前にフォローが来て
いたらしく読み飛ばしてました。desktop.el は RMAIL や dired も復元する
ということなので、比べてみて下さい（僕も比べてみよう）。

僕は desktop.el を変数 load-path で指定したディレクトリに放り込み、
 .emacs の最後で
  (load "desktop")
  (defvar desktop-dirname "~/")
  (desktop-load-default)
  (desktop-read)
などとやってます。（NEmacs でも Mule でも使えてます）

状態をセーブしたくないときは M-x desktop-clear とやってクリアします。
これが結構便利で、現在開いているバッファの群を一挙にクリアしてくれます
（もちろん、セーブしてない奴は処置を聞いてきますが）。

GNUS で NetNews を読んでる状態はセーブできません。.newsrc のバッファ
が、さみしくできるだけでした ;_;


---
        平野敏弘＠富士通テン
        あしたは晴れかなァ ... おや？二だ ... また、二だ ...


;; From terra@diku.dk Thu May 13 12:29:33 1993
;; From: terra@diku.dk (Morten Welinder)
;; Newsgroups: gnu.emacs.sources
;; Subject: desktop.el -- update
;; Date: 12 May 93 16:15:03 JST
;; Organization: Department of Computer Science, U of Copenhagen
;; 
;; Hi!
;; 
;; I got a lot of comments of my desktop.el released recently.  Here is
;; an updated that fixed several bugs with strange modes.  You should
;; now be able to save dired and RMAIL buffers as well as normal buffers.
;; 
;; If anyone out there knows a cleaner way to hook the leaving of Emacs,
;; please let me know.


; ---------------------------------------------------------------------------
;			     Emacs Desktop Saver
; ---------------------------------------------------------------------------
; LCD Archive Entry:
; desktop|Morten Welinder|terra@diku.dk|
; Save (partial) status of Emacs when killing it.|
; 93-05-07|1.3|~/misc/desktop.el|
;
; This is free software; you can redistribute and/or modify it at will.
;
; Save the Desktop, i.e.,
;	- meta-flag
;	- the kill ring and its yank pointer
;	- desktop-missing-file-warning
; 	- the list of buffers with associated files. For each buffer also
;		- the major mode
;		- the default directory
;		- the point
;		- the mark
;		- buffer-read-only
;		- truncate-lines
;		- case-fold-search
;		- case-replace
;		- fill-column
;
; This piece of Emacs Lisp helps you to keep track of where you working
; in some project last time you was there.
;
; To use this, first put these three lines in the bottom of your .emacs 
; file (the later the better):
;
;	(load "desktop")
;	(desktop-load-default)
;	(desktop-read)
;
; Start Emacs in the root directory of your "project". The desktop saver
; is inactive by default. You activate it by M-X desktop-save RET. When 
; you exit the next time the above data will be saved. This ensures that
; all the files you were editing will be reloaded the next time you start
; Emacs from the same directory and that points will be set where you
; left them.
;
; PLEASE NOTE: When the kill ring is saved as specified by the variable 
; `desktop-globals-to-save' (by default it isn't).  This may result in saving
; things you did not mean to keep.  Use M-X desktop-clear RET.
;
; Thanks to  hetrick@phys.uva.nl (Jim Hetrick)  for useful ideas.
; ---------------------------------------------------------------------------
; HISTORY:
;
; Dec   , 1992: Version 1.0 written; never released.
; Jan   , 1993: Minor modes now saved: auto-fill-mode, overwrite-mode.
; Apr 26, 1993: Version 1.1 released.
; Apr 29, 1993: Now supports RMAIL, Info, and dired modes.
;               Will now search home directory for desktop file.
;               desktop-save asks for directory to save in.
;
; TODO:
;
; Save window configuration.
; Recognize more minor modes.
; Save mark rings.
; Start-up with buffer-menu???
; List of regexps identifying buffers not to save???
; ---------------------------------------------------------------------------
; USER OPTIONS -- settings you might want to play with.
;
(defconst desktop-basefilename 
  (if (equal system-type 'ms-dos)
      "emacs.dsk" ; Ms-Dos does not support multiple dots in file name
    ".emacs.desktop")
  "File for Emacs desktop.  A directory name will be prepended to this name.")

(defvar desktop-missing-file-warning t 
  "*If non-nil then issue warning if a file no longer exists. Otherwise simply
ignore the file.")

(defvar desktop-globals-to-save 
  (list 'desktop-missing-file-warning
	; 'kill-ring ; Feature: Also saves kill-ring-yank-pointer
	'desktop-globals-to-save) ; Itself!
  "List of global variables to save when killing Emacs.")

(defvar desktop-buffers-not-to-save
 "(ftp)$"
 "Regexp identifying buffers that are to be excluded from saving.")

(defvar desktop-buffer-handlers
  '(desktop-buffer-dired 
    desktop-buffer-rmail
    desktop-buffer-info
    desktop-buffer-file)
  "*List of functions to call in order to create a buffer.  The functions 
are called without parameters but may access the the major mode as "mam", 
the file name as "fn", the buffer name as "bn", the default directory as 
"dd".  If some function returns non-nil no further functions are called.  
If the function returns t then the buffer is considered created.")
; ---------------------------------------------------------------------------
(defvar desktop-dirname nil 
  "The directory in which the current desktop file resides.")

(defconst desktop-header
"; ---------------------------------------------------------------------------
; Desktop File for Emacs
; ---------------------------------------------------------------------------
" "*Header to place in Desktop file.")
; ---------------------------------------------------------------------------
(defun desktop-clear () "Empty the Desktop."
  (interactive)
  (setq kill-ring nil)
  (setq kill-ring-yank-pointer nil)
  (mapcar (function kill-buffer) (buffer-list)))
; ---------------------------------------------------------------------------
(if (not (fboundp 'original-kill-emacs))
  (progn  
    (fset 'original-kill-emacs (symbol-function 'kill-emacs))
))
; ---------------------------------------------------------------------------
(defun kill-emacs (&optional query)
  "End this Emacs session.
Prefix ARG or optional first ARG non-nil means exit with no questions asked,
even if there are unsaved buffers.  If Emacs is running non-interactively
and ARG is an integer, then Emacs exits with ARG as its exit code.

If the variable `desktop-dirname' is non-nil,
the function desktop-save will be called first."
  (interactive "P")
  (if desktop-dirname (desktop-save desktop-dirname))
  (original-kill-emacs query))
; ---------------------------------------------------------------------------
(defun desktop-outvar (VAR)
  "Output a setq statement for VAR to the desktop file."
  (if (boundp VAR)
      (progn
	(insert "(setq ")
	(prin1 VAR (current-buffer))
	(insert " '")
	(prin1 (symbol-value VAR) (current-buffer))
	(insert ")\n"))))
; ---------------------------------------------------------------------------
(defun desktop-save-buffer-p (name buffer mode)
  "Determine if the buffer attached to file NAME and having name BUFFER using
mode MODE is to be saved."
  
  (or (and name
	   (not (string-match desktop-buffers-not-to-save buffer)))
      (and (null name)
	   (memq mode '(Info-mode dired-mode rmail-mode)))))
; ---------------------------------------------------------------------------
(defun desktop-save (dirname)
  "Save the Desktop file.  Parameter DIRNAME specifies where to save desktop."
  (interactive "DDirectory to save desktop file in: ")
  (save-excursion
    (let ((filename (expand-file-name (concat dirname desktop-basefilename)))
	  (info (nreverse 
		 (mapcar 
		  (function (lambda (b)
			      (set-buffer b)
			      (list 
			       (buffer-file-name)
			       (buffer-name)
			       (list 'quote major-mode)
			       (list 'quote
				     (list overwrite-mode 
					   (not (null auto-fill-hook))))
			       (point)
			       (mark)
			       buffer-read-only
			       truncate-lines
			       fill-column
			       case-fold-search
			       case-replace
			       (list 
				'quote
				(cond ((equal major-mode 'Info-mode)
				       (list Info-current-file
					     Info-current-node))
				      ((equal major-mode 'dired-mode)
				       (list default-directory))
				      ))
			       )))
		  (buffer-list))))
	  (buf (get-buffer-create "*desktop*")))
      (set-buffer buf)
      (erase-buffer)

      (insert desktop-header 
	      "; Created " (current-time-string) "\n\n"
	      "; Global section:\n")
      (mapcar (function desktop-outvar) desktop-globals-to-save)
      (if (memq 'kill-ring desktop-globals-to-save)
	  (insert "(setq kill-ring-yank-pointer (nthcdr " 
		  (int-to-string 
		   (- (length kill-ring) (length kill-ring-yank-pointer)))
		  " kill-ring))\n"))

      (insert "\n; Buffer section:\n")
      (mapcar 
       (function (lambda (l)
		   (if (desktop-save-buffer-p 
			(car l) 
			(nth 1 l)
			(nth 1 (nth 2 l)))
		       (progn
			 (insert "(desktop-buffer")
			 (mapcar 
			  (function (lambda (e)
				      (insert "\n  ")
				      (prin1 e buf)))
			  l)
			 (insert ")\n\n")))))
       info)
      (if (file-exists-p filename) (delete-file filename))
      (write-region (point-min) (point-max) filename nil 'nomessage)
      (kill-buffer buf)))
  (setq desktop-dirname dirname))
; ---------------------------------------------------------------------------
(defun desktop-remove ()
  "Delete the Desktop file and inactivate the desktop system."
  (interactive)
  (if desktop-dirname
      (let ((filename (concat desktop-dirname desktop-basefilename)))
	(if (file-exists-p filename) (delete-file filename))
	(setq desktop-dirname nil))))
; ---------------------------------------------------------------------------
(defun desktop-read ()
  "Read the Desktop file and the files it specifies."
  (interactive)
  (let ((filename))
    (if (file-exists-p (concat "./" desktop-basefilename))
	(setq desktop-dirname (expand-file-name "./"))
      (if (file-exists-p (concat "~/" desktop-basefilename))
	  (setq desktop-dirname (expand-file-name "~/"))
	(setq desktop-dirname nil)))
    (if desktop-dirname
	(progn
	  (load (concat desktop-dirname desktop-basefilename) t t t)
	  (message "Desktop loaded."))
      (desktop-clear))))
; ---------------------------------------------------------------------------
(defun desktop-load-default ()
  "Load the `default' start-up library manually and inhibit further loading
of it.  This function is supposed to be called from your .emacs in order to
provide correct modes for autoloaded files."
  (if (not inhibit-default-init)
      (progn
	(load "default" t t)
	(setq inhibit-default-init t))))
; ---------------------------------------------------------------------------
(defun desktop-buffer-info () "Load an info file."
  (if (equal 'Info-mode mam)
      (progn
	(require 'info)
	(Info-find-node (nth 0 misc) (nth 1 misc))
	t)))
; ---------------------------------------------------------------------------
(defun desktop-buffer-rmail () "Load a RMAIL file."
  (if (equal 'rmail-mode mam)
      (progn (rmail-input fn) t)))
; ---------------------------------------------------------------------------
(defun desktop-buffer-dired () "Load a directory using dired."
  (if (equal 'dired-mode mam)
      (progn (dired (nth 0 misc)) t)))
; ---------------------------------------------------------------------------
(defun desktop-buffer-file () "Load a file."
  (if fn
      (if (or (file-exists-p fn)
	      (and desktop-missing-file-warning
		   (y-or-n-p (format 
			      "File \"%s\" no longer exists. Re-create? " 
			      fn))))
	  (progn (find-file fn) t)
	'ignored)))
; ---------------------------------------------------------------------------
(defun desktop-buffer (fn bn mam mim pt mk ro tl fc cfs cr misc)
  "Create a buffer, load its file, set is mode, ...;  called from Desktop file
only."
  (let ((hlist desktop-buffer-handlers)
	(result)
	(handler))
    (while (and (not result) hlist)
      (setq handler (car hlist))
      (setq result (funcall handler))
      (setq hlist (cdr hlist)))
    (if (equal result t)
	(progn
	  (if (not (equal (buffer-name) bn))
	      (rename-buffer bn))
	  (if (nth 0 mim)
	      (overwrite-mode 1)
	    (overwrite-mode 0))
	  (if (nth 1 mim)
	      (auto-fill-mode 1)
	    (overwrite-mode 0))
	  (goto-char pt)
	  (set-mark mk)
	  (setq buffer-read-only ro)
	  (setq truncate-lines tl)
	  (setq fill-column fc)
	  (setq case-fold-search cfs)
	  (setq case-replace cr)
	  ))))
; ---------------------------------------------------------------------------

;; -- 
;; -------------------------------------------------------------------------
;; Visit the lyrics archive at ftp.uwp.edu (mirrored to nic.funet.fi, a site
;; in Finland). All kinds of lyrics available -- upload "yours" and join.
;; -------------------------------------------Morten Welinder, terra@diku.dk
--
        平野敏弘＠富士通テン
        あしたは晴れかなァ ... おや？二だ ... また、二だ ...
