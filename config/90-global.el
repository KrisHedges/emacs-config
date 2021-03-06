;;Enable Word Wrapping in Text and org mode
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'org-mode-hook 'turn-on-visual-line-mode)
;;Add Ack & PDFLatex bin to exec-path
(setenv "PATH" (concat "/Users/krishedges/bin:/Users/krishedges/.rvm/gems/ruby-1.9.2-p180/bin:/Users/krishedges/.rvm/gems/ruby-1.9.2-p180@global/bin:/Users/krishedges/.rvm/rubies/ruby-1.9.2-p180/bin:/Users/krishedges/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/texbin:/opt/local/bin:/usr/X11/bin" (getenv "PATH")))
(setq exec-path (append exec-path '("/Users/krishedges/bin" "/usr/local/bin/" "/usr/bin" "/usr/sbin" "/usr/local/bin" "/usr/texbin" "/opt/local/bin" "/usr/X11/bin")))

;; put scroll bar on right
(set-scroll-bar-mode 'right)

;; frame title bar formatting to show full path to file
(setq-default
 frame-title-format
 (list
  '((buffer-file-name
     " %f"
     (dired-directory
      dired-directory
      (revert-buffer-function
       " %b"
       ("%b - Dir:  " default-directory)))))))

;; allow line-wrap with vertical windows
(setq truncate-partial-width-windows nil)

; No line wrap by default
(set 'default-truncate-lines t)

;; enable copy / paste from other applications
(setq x-select-enable-clipboard t)

;; use y instead of yes
(fset 'yes-or-no-p 'y-or-n-p)

;; use spaces when indenting code
(setq-default indent-tabs-mode nil)

;; dired should offer to recursively copy folders
(setq dired-recursive-copies t)

;; don't have to C-k twice to delete the whole line
(setq kill-whole-line t)

;; tilde-files and #files# should go to a different dir
(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))

;; highlight parens 
(show-paren-mode 1)

;; this fixes a bug in isearch replace - it doesn't replace current selection
;; Move cursor to beginning of match after search
(add-hook 'isearch-mode-end-hook 'isearch-goto-beginning-after-finished)
(defun isearch-goto-beginning-after-finished ()
  (when (and isearch-forward isearch-success)
  (goto-char isearch-other-end)))

;; turn off the toolbar
(tool-bar-mode -1)

;; enable ido mode
(ido-mode 1)

;; record changes in window configuration to allow undo/redo
;; with C-c left (undo) and C-c right (redo)
(winner-mode 1)

;; show current column
(column-number-mode 1)

(defun generate-tags (tagfile)
  (interactive "DTag Dir:")
  (let* ((dir (file-name-directory tagfile))
         (cmd (concat "cd " dir " && ctags -e -R . -o TAGS 2>/dev/null")))
    (message "TAGS command: %s" cmd)
    (shell-command cmd)
    (visit-tags-table tagfile)))

;;Set Frame Size on init
(setq initial-frame-alist
      `((left . 0) (top . 0)
        (width . 183) (height . 48)))

;; javascript lint 
(defun jslint-thisfile ()
  (interactive)
  (compile (format "jsl -process %s" (buffer-file-name))))

(add-hook 'javascript-mode-hook
  '(lambda ()
  (local-set-key [f8] 'jslint-thisfile)))

;; save a list of open files in ~/.emacs.desktop
;; save the desktop file automatically if it already exists
(setq desktop-save 'if-exists)
(desktop-save-mode 1)

(setq desktop-globals-to-save
      (append '((extended-command-history . 30)
                (file-name-history        . 100)
                (grep-history             . 30)
                (compile-history          . 30)
                (minibuffer-history       . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name)))

