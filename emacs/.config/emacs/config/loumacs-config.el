;; Basic config && package manager
(require 'loumacs-base)

;; Theme
(require 'loumacs-theme)

;; Evil mode
(require 'loumacs-vim)

;; Navigation stuff
;; Ivy counsel
;; (require 'loumacs-ivy)
;; helm --> preferred
(require 'loumacs-helm)

;; LSP
;; inside, choose btw ivy and helm
(require 'loumacs-lsp)

;; Completion
(require 'loumacs-completion)

;; TODO: Language specific settings/keybindings
;; (require 'language_specifics)

;; Git
(require 'loumacs-git)

;; actually I think I like immediatly having a scratch buffer
;; (require 'dashboard)

;; Keybindings - needs to be loaded last probably
(require 'loumacs-keybindings)

;; byte compilation
(byte-recompile-directory (expand-file-name "~/.config/emacs") 0)

(provide 'loumacs-config)
