;; Add color to a shell running in emacs 'M-x shell' or M-x eshell
(autoload 'ansi-color-for-comment-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comment-mode-on)
(add-hook 'eshell-mode-hook 'ansi-color-for-comment-mode-on)
