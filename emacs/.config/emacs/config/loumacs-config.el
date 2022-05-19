;; Basic config && package manager
(require 'loumacs-base)

;; Theme
(require 'loumacs-theme)

;; Evil mode
(require 'loumacs-vim)

;; Navigation stuff -- choose ivy or helm
;; Ivy
;; (require 'loumacs-ivy)
;; helm
(require 'loumacs-helm)

;; Completion
(require 'loumacs-completion)

;; Keybindings - needs to be loaded last probably
(require 'loumacs-keybindings)

;; TODO: Language specific settings/keybindings
;; (require 'language_specifics)

;; LSP
;; inside, choose btw ivy and helm
(require 'loumacs-lsp)

;; Keybindings - needs to be loaded last probably
;; actually I think I like immediatly having a scratch buffer
;; (require 'dashboard)

;; byte compilation
;; (byte-recompile-directory (expand-file-name "~/.config/emacs") 0)

(provide 'loumacs-config)
