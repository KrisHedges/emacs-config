(add-to-list 'load-path (extern-path "php-mode"))
(require 'php-mode)
(setq-default tab-width 2)
(add-to-list 'auto-mode-alist '("\\.module\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . php-mode))
