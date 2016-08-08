
;; move forward/backward with seaching cpp directives.
;; $Id: cpp.el,v 1.45 1993/10/18 10:09:32 enami Exp $
;; BUGS: should treat comments.
;;
(require 'backquote)

(defmacro cpp/stay-unless (&rest form)
  "Stay here unless FORM yields non-NIL."
  (` (let ((point (save-excursion (if (progn (,@ form)) (point) ))))
       (if (not point)
	   nil
	 (goto-char point) ))))

(put 'cpp/stay-unless 'lisp-indent-hook 0)
(put 'cpp/stay-unless 'lisp-indent-function 0)

(defconst cpp/directive-regexp "^#\\s *\\(if\\|endif\\|else\\|elif\\)")
(defconst cpp/if-endif-regexp "^#\\s *\\(if\\|endif\\)")

(defun cpp/getline (&optional whole)
  "Return current line as a string.  If optional argument WHOLE is non nil,
succeeding continuous lines are included."
  (save-excursion
    (buffer-substring (progn (beginning-of-line) (point))
		      (progn (while (progn (end-of-line)
					   (if (or (not whole) (eobp))
					       nil
					     (eq (preceding-char) ?\\)))
			       (forward-line))
			     (if (eobp)
				 (point)
			       (1+ (point) ))))))

;; (defvar cpp/logging-buffer (get-buffer-create "hoge"))
(defun cpp/do-logging (string level)
  (let ((line (cpp/getline)))
    (save-excursion
      (set-buffer cpp/logging-buffer)
      (insert (format "%d %s\n" level line)) )))

(defun cpp/directive-line-p ()
  "T if current line is cpp directive."
  (save-excursion
    (beginning-of-line)
    (looking-at "^#") ))

;;;### autoload
(defvar cpp/indent-offset 2
  "*Unit of indentation used in cpp/indent-line.")

(defun cpp/indent-line (string level)
  "Indent current cpp directive."
  ;; (cpp/do-logging string level)
  (or (zerop level)
      (let ((indent (1- (* level cpp/indent-offset))))
	(save-excursion
	  (beginning-of-line)
	  (forward-char)		; skip #
	  (if (looking-at "\\s +")
	      (delete-region (match-beginning 0) (match-end 0)))
	  (indent-to (if (looking-at "if\\|else\\|elif\\|endif")
			 indent
		       (+ indent cpp/indent-offset) ))))))

(defun cpp/scan-directive (search enter leave action level)
  (catch 'break
    (while (funcall search level)
      (let ((match (buffer-substring (match-beginning 0) (match-end 0))))
	(cond ((funcall enter match level)
	       ;; skip nested #if / #endif pair.
	       (and action (funcall action match (1+ level)))
	       (cpp/scan-directive search enter leave action (1+ level)) )
	      ((funcall leave match level)
	       (and action (funcall action match level))
	       (throw 'break t) )
	      (action (funcall action match level)) )))))

(defun cpp/indent-directive ()
  (interactive "*")
  (save-excursion
    ;; (beginning-of-line)
    (cpp/beginning-of-directive)
    (cpp/scan-directive
     (function (lambda (level) (re-search-forward "^#\\s *\\w+" nil t) ))
     (function (lambda (match level) (string-match "^#\\s *if" match)))
     (function (lambda (match level) (string-match "^#\\s *endif" match)))
     (function cpp/indent-line)
     0)))

(defun cpp/skip-directive-backward (&optional skip)
  (interactive "P")
  (let ((cpp/directive-regexp (if skip
				  cpp/if-endif-regexp
				cpp/directive-regexp)))
    (cpp/scan-directive
     (function (lambda (level)
		 (beginning-of-line)
		 (re-search-backward (if (zerop level)
					 cpp/directive-regexp
				       cpp/if-endif-regexp)
				     nil t) ))
     (function (lambda (match level) (string-match "^#\\s *endif" match)))
     (function (lambda (match level)
		 (string-match (if (zerop level)
				   cpp/directive-regexp
				 "^#\\s *if")
			       match)))
     nil
     0)))

(defun cpp/skip-directive-forward (&optional skip)
  (interactive "P")
  (let ((cpp/directive-regexp (if skip
				  cpp/if-endif-regexp
				cpp/directive-regexp)))
    (cpp/scan-directive
     (function (lambda (level)
		 (end-of-line)
		 (re-search-forward (if (zerop level)
					cpp/directive-regexp
				      cpp/if-endif-regexp)
				    nil t) ))
     (function (lambda (match level) (string-match "^#\\s *if" match)))
     (function (lambda (match level)
		 (let ((result 
			(string-match (if (zerop level)
					  cpp/directive-regexp
					"^#\\s *endif")
				      match)))
		   (if result (beginning-of-line))
		   result)))
     nil
     0)))


;;;
;;; user visible entry points.
;;;

;;;###autoload
(defun cpp/previous-directive ()
  "move searching prevoius cpp if/else/endif directive."
  (interactive)
  (if (save-excursion
	(beginning-of-line)
	(looking-at "^#\\s *\\(endif\\|else\\|elif\\)"))
      ;; move to next cpp directive of same level.
      (cpp/skip-directive-backward t)
    ;; move to next cpp directive.  if not found, don't move.
    (re-search-backward cpp/directive-regexp nil t) ))

;;;###autoload
(defun cpp/next-directive ()
  "move searching next cpp if/else/endif directive."
  (interactive)
  (if (save-excursion
	(beginning-of-line)
	(looking-at "^#\\s *\\(if\\|else\\|elif\\)"))
      ;; move to next cpp directive of same level.
      (cpp/skip-directive-forward t)
    ;; move to next cpp directive.  if not found, don't move.
    (cpp/stay-unless
      (end-of-line)
      (if (re-search-forward cpp/directive-regexp nil t)
	  ;; goto the beginning of line.
	  (goto-char (match-beginning 0)) ))))

;;;###autoload
(defun cpp/beginning-of-directive ()
  "move to the beginning of cpp directive."
  (interactive)
  (let ((point (point)))
    (while (and (not (looking-at "^#\\s *if"))
		(cpp/stay-unless (cpp/skip-directive-backward)) ))
    (or (/= point (point))
	(looking-at "^#\\s *if") )))

;;;###autoload
(defun cpp/end-of-directive ()
  "move to the end of cpp directive."
  (interactive)
  (let ((point (point)))
    (while (and (not (looking-at "^#\\s *endif"))
		(cpp/stay-unless (cpp/skip-directive-forward)) ))
    (or (/= point (point))
	(looking-at "^#\\s *endif") )))

;;;###autoload
(defun cpp/mark-directive ()
  "Put point at the beginning of cpp directive and mark at the end of
cpp directive."
  (interactive)
  (cpp/end-of-directive)
  (push-mark (save-excursion (forward-line) (point)))
  (cpp/beginning-of-directive) )

;;;###autoload
(defun cpp/up-directive (&optional all)
  "Up the nesting of cpp directive.  If optional argument ALL is non nil,
stop at else/elif."
  (interactive "P")
  (cpp/stay-unless
    (if all
	(cpp/skip-directive-backward)
      (if (looking-at "^#\\s *if")
	  (forward-line -1) )
      (cpp/beginning-of-directive) )))

;;;###autoload
(defun cpp/forward-directive (&optional up)
  "move ot forward cpp directive.  if optional argument UP is non nil, move up
when there is no next one."
  (interactive "P")
  (or (and (not up) (looking-at "^#\\s *endif"))
      (cpp/stay-unless (cpp/skip-directive-forward)) ))

;;;###autoload
(defun cpp/backward-directive (&optional up)
  "move ot backward cpp directive.  if optional argument UP is non nil, move up
when there is no backward one."
  (interactive "P")
  (or (and (not up) (looking-at "^#\\s *if"))
      (cpp/stay-unless (cpp/skip-directive-backward)) ))

;;;###autoload
(defun cpp/show-nestings (&optional indent)
  "Show the nesting of cpp directive.  If optional argument INDENT is non
nil, re-indent each line."
  (interactive "P")
  (save-excursion
    (with-output-to-temp-buffer "*cpp nestings*"
      (let ((lines (cons (cpp/getline) nil)))
	(while (cpp/skip-directive-backward)
	  (setq lines (cons (cpp/getline t) lines)) )
	(while lines
	  (princ (car lines))
	  (setq lines (cdr lines)) )))
    (if (not indent)
	nil
      (set-buffer "*cpp nestings*")
      (goto-char (point-min))
      (cpp/indent-directive) )))


;;;
;;; wrapper functions.
;;;

;;;###autoload
(defun cpp/forward-list (n)
  "Wrapper for forward-list.  If current line is cpp directive, call
cpp/next-directive, otherwise call forward-list."
  (interactive "P")
  (call-interactively (if (cpp/directive-line-p)
			  (function cpp/next-directive)
			(function forward-list) )))

;;;###autoload
(defun cpp/backward-list (n)
  "Wrapper for backward-list.  If current line is cpp directive, call
cpp/previous-directive, otherwise call backward-list."
  (interactive "P")
  (call-interactively (if (cpp/directive-line-p)
			  (function cpp/previous-directive)
			(function backward-list) )))

;;;###autoload
(defun cpp/forward-sexp (n)
  "Wrapper for forward-sexp.  If current line is cpp directive, call
cpp/forward-directive, otherwise call forward-sexp."
  (interactive "P")
  (call-interactively (if (cpp/directive-line-p)
			  (function cpp/forward-directive)
			(function forward-sexp) )))

;;;###autoload
(defun cpp/backward-sexp (n)
  "Wrapper for backward-sexp.  If current line is cpp directive, call
cpp/backward-directive, otherwise call backward-sexp."
  (interactive "P")
  (call-interactively (if (cpp/directive-line-p)
			  (function cpp/backward-directive)
			(function backward-sexp) )))

;;;###autoload
(defun cpp/indent-sexp (n)
  "Wrapper for indent-sexp.  If current line is cpp directive, call
cpp/indent-directive, otherwise call indent-sexp."
  (interactive "P")
  (call-interactively (if (cpp/directive-line-p)
			  (function cpp/indent-directive)
			(function indent-sexp) )))

;;;###autoload
(defun cpp/backward-up-list (n)
  "Wrapper for backward-up-list.  If current line is cpp directive, call
cpp/up-directive, otherwise call backward-up-list."
  (interactive "P")
  (call-interactively (if (cpp/directive-line-p)
			  (function cpp/up-directive)
			(function backward-up-list) )))


;;;
;;; minor mode for debug.
;;;
;;;###autoload
(defvar cpp-directive-mode-hook nil)

;; (makunbound 'cpp-directive-mode-map)
(defvar cpp-directive-mode-map nil)
(if cpp-directive-mode-map
    nil
  (setq cpp-directive-mode-map (make-sparse-keymap))
  (define-key cpp-directive-mode-map "\C-c\C-u" 'cpp/up-directive)
  (define-key cpp-directive-mode-map "\C-c\C-s" 'cpp/show-nestings)
  (define-key cpp-directive-mode-map "\C-c\C-a" 'cpp/beginning-of-directive)
  (define-key cpp-directive-mode-map "\C-c\C-e" 'cpp/end-of-directive)
  (define-key cpp-directive-mode-map "\C-c\C-n" 'cpp/next-directive)
  (define-key cpp-directive-mode-map "\C-c\C-p" 'cpp/previous-directive)
  (define-key cpp-directive-mode-map "\C-c\C-f" 'cpp/forward-directive)
  (define-key cpp-directive-mode-map "\C-c\C-b" 'cpp/backward-directive)
  (define-key cpp-directive-mode-map "\C-c\C-m" 'cpp/mark-directive)
  (define-key cpp-directive-mode-map "\e\C-q" 'cpp/indent-sexp)
  (define-key cpp-directive-mode-map "\e\C-f" 'cpp/forward-sexp)
  (define-key cpp-directive-mode-map "\e\C-b" 'cpp/backward-sexp)
  (define-key cpp-directive-mode-map "\e\C-u" 'cpp/backward-up-list)
  (define-key cpp-directive-mode-map "\e\C-n" 'cpp/forward-list)
  (define-key cpp-directive-mode-map "\e\C-p" 'cpp/backward-list)
;  (define-key cpp-directive-mode-map "\C-c\C-c"
;	      (function (lambda () (interactive)
;			  (cpp/toggle-directive-mode nil))))
  (define-key cpp-directive-mode-map "\C-c\C-q"
	      (function (lambda () (interactive) (cpp-directive-mode nil)))
	      ))

(defvar cpp-directive-mode nil)
(defvar cpp-directive-mode-original-map nil)
(or (assq 'cpp-directive-mode minor-mode-alist)
    (setq minor-mode-alist
	  (cons (list 'cpp-directive-mode " CPP")
		minor-mode-alist)))

(defun cpp-directive-mode-1 ()
  "cpp directive minor mode."
  (if cpp-directive-mode
      nil
    (make-local-variable 'cpp-directive-mode-original-map)
    (make-local-variable 'cpp-directive-mode)
    (setq cpp-directive-mode-original-map (current-local-map))
    (use-local-map cpp-directive-mode-map)
    (run-hooks 'cpp-directive-mode-hook)))

;;;###autoload
(defun cpp-directive-mode (&optional on)
  "toggle cpp directive mode."
  (interactive "P")
  (setq on (or on
	       (cond (current-prefix-arg t)
		     (t (not cpp-directive-mode)))))
  (if on
      (cpp-directive-mode-1)
    (if cpp-directive-mode
	(use-local-map cpp-directive-mode-original-map)))
  (setq cpp-directive-mode on)
  (set-buffer-modified-p (buffer-modified-p)) )

;;;### autoload
(defvar cpp-load-hook nil "*if non nil, evaluated when cpp.el is loaded.")
(run-hooks 'cpp-load-hook)
(provide 'cpp)
