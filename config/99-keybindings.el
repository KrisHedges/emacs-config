;;Option as meta, Command key now free to be ( Cmd-v/x/a/w/n/z/s )
(setq mac-command-key-is-meta 'nil)
(setq mac-option-modifier 'meta)

;;enables windmove Shift larrow/rarrow to switch buffers
(when (fboundp 'windmove-default-keybindings)
    (windmove-default-keybindings))

(global-set-key (kbd "C-;") 'anything-at-point)
(global-set-key "\M-n"      'duplicate-line)
(global-set-key "\C-x\\"    'align-regexp)
(global-set-key "\M-#"      'comment-or-uncomment-region)
(global-set-key "\C-xp"     'other-window-backward)
(global-set-key (kbd "M-.") 'anything-yaetags-find-tag)

;; make a new prefix key, C-l
(global-unset-key (kbd "C-l"))
(defvar layout-keymap (make-sparse-keymap "layout"))
(define-key global-map (kbd "C-l") layout-keymap)
;; define commands like C-l C-n
(define-key layout-keymap (kbd "C-l") 'recenter)
(define-key layout-keymap (kbd "C-a") 'delete-other-windows)
(define-key layout-keymap (kbd "C-b") 'balance-windows)
(define-key layout-keymap (kbd "C-n") 'other-window)
(define-key layout-keymap (kbd "C-p") 'other-window-backward)
(define-key layout-keymap (kbd "C-f") 'toggle-fullscreen)
(define-key layout-keymap (kbd "C-c") 'split-window-vertically)
(define-key layout-keymap (kbd "C-h") 'delete-window)
(define-key layout-keymap (kbd "C-k") (lambda () (interactive) (kill-buffer nil)))
(define-key layout-keymap (kbd "C-w") 'toggle-truncate-lines)
(define-key layout-keymap (kbd "C-j") 'join-line)
(define-key layout-keymap (kbd "C-s") 'rgrep)

;; make a new prefix key, C-t
(global-unset-key (kbd "C-t"))
(defvar to-keymap (make-sparse-keymap "to"))
(define-key global-map (kbd "C-t") to-keymap)

(define-key to-keymap (kbd "C-t") 'transpose-chars)
(define-key to-keymap (kbd "C-a") 'beginning-of-line-text)
(define-key to-keymap (kbd "C-h") 'beginning-of-buffer)
(define-key to-keymap (kbd "C-l") 'end-of-buffer)

;; isearch customizations

(defun ja-isearch-current-match ()
  (buffer-substring (match-beginning 0) (match-end 0)))

(defvar isearch-paste-keymap (make-sparse-keymap "isearch-paste"))
(define-key isearch-mode-map (kbd "C-v") isearch-paste-keymap)

;; C-v C-v : paste isearch match
(define-key isearch-paste-keymap (kbd "C-v")
  (lambda () (interactive) 
    (goto-char isearch-opoint)
    (insert (ja-isearch-current-match))
    (isearch-done)))

;; C-v C-v : paste isearch match as ruby string quoted var
(define-key isearch-paste-keymap (kbd "C-s")
  (lambda () (interactive) 
    (goto-char isearch-opoint)
    (insert (concat "#{" (ja-isearch-current-match) "}"))
    (isearch-done)))

;;ORG-MODE Config
;; SET My preferred TODO Keywords
(setq org-todo-keywords
  '((sequence "TODO(t)" "WAITING(w@/!)" "|" "DONE(d@/!)")))
;; Here I point to where I keep my agenda files
(load-library "find-lisp")
(setq org-agenda-files (find-lisp-find-files "~/org" "\.org"))
;; SET Some good non-conflicting keys for storing a link to to global agenda 
(define-key global-map "\C-cl" 'org-store-link)
;; SET Keys for opening the Agenda dialog
(define-key global-map "\C-ca" 'org-agenda)

;;Add Remember Mode to Org
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(define-key global-map "\C-cr" 'org-remember)

;;Build Remember Templates
;;(setq project-remember-templates (find-lisp-find-files "~/org" "\.org"))
;;(while project-remember-templates

;; Resolve Windmove Conflicts in org-mode:
(setq org-disputed-keys '(([(shift up)] . [(meta p)])
                          ([(shift down)] . [(meta n)])
                          ([(shift left)] . [(meta -)])
                          ([(shift right)] . [(meta +)])
                          ([(meta return)] . [(control meta return)])
                          ([(control shift right)] . [(meta shift +)])
                          ([(control shift left)] . [(meta shift -)])))
(setq org-replace-disputed-keys t)

;; Org HTML Export
(setq org-export-html-preamble nil)
(setq org-export-html-postamble nil)
;;Removes <style> tags in the <head> and the default boilerplate CSS
(setq org-export-html-style-include-default nil)
;;Removes <script> tags in the <head> and the javascript helpers inside it
(setq org-export-html-style-include-scripts nil)
;; Changes the Doctype to HTML 5
(setq org-export-html-xml-declaration '"<!DOCTYPE html>")
;; Removes the old cluttered <html> tag and replaces it with a clean one.
(add-hook 'org-export-html-final-hook
          (lambda ()
           (let ((kill-whole-line t))
            (goto-char (point-min))
            (forward-line 1)
            (kill-line 3)
            (insert "<html>\n"))))


;; Latex PDF files
;; & Pygments in src examples
(require `org-latex)
(setq org-export-latex-listings 'minted)
(add-to-list 'org-export-latex-packages-alist '("" "minted"))
(setq org-export-latex-minted-options
    '(("frame" "leftline")
      ("linenos" "true")
      ("bgcolor" "bg") ; bg will need to be defined in the preamble of your document. It's defined in org-preamble-pdflatex.sty and org-preamble-xelatex.sty below.
      ))



