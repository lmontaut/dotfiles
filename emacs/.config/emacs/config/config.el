;; Basic config && package manager
(require 'base)

;; Theme
(require 'theme)

;; Evil mode
(require 'vim)

;; Completion
(require 'completion)

;; Keybindings - needs to be loaded last probably
(require 'keybindings)

;; (byte-recompile-directory (expand-file-name "~/.emacs.d") 0)
(provide 'config)
