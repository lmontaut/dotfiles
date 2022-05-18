;; adding elisp files in config/
(add-to-list 'load-path (concat user-emacs-directory "config"))

;; Basic config && package manager
(require 'base)

;; Theme
(require 'theme)

;; Evil mode
(require 'vim)

;; Completion
(require 'completion)

;; Keybindings
(require 'keybindings)

;; (byte-recompile-directory (expand-file-name "~/.emacs.d") 0)
