;; -- Misc functions
;; TODO: switch to helm to do that
(use-package counsel
  :straight t
)
(defun loumacs/counsel-private-config ()
  "Opens the private emacs config files"
  (interactive)
  (counsel-find-file "~/dotfiles/emacs/.config/emacs/config"))

;; -- General allows to easily create keybindings
(use-package general
  :straight t
  :config
  (general-evil-setup))

;; leader everywhere
(general-define-key
  :states '(normal insert visual)
  :prefix "SPC"
  :global-prefix "C-SPC"
  ;; leader-t
  "t"  '(:ignore t :which-key "toggles")
  ;; "tt" '(counsel-load-theme :which-key "choose theme")
  "tt" '(load-theme :which-key "choose theme")
  ;; leader-f
  "f" '(:ignore t :which-key "files")
  "fp" '(loumacs/counsel-private-config :which-key "emacs config")
  ;; leader-i
  "i" 'lsp-ui-imenu
  )
;; non-leader everywhere
(general-define-key
  :states '(normal insert visual)
  "M-v" 'scroll-other-window
  "M-V" 'scroll-other-window-down
)
;; non-leader normal + visual
(general-define-key
  :states '(normal visual)
  "\\" 'evil-commentary
)
;; non-leader normal
(general-define-key
  :states 'normal
  ">" 'evil-shift-right-line
  "<" 'evil-shift-left-line
  "K" 'lsp-ui-doc-glance
  "C-x l d" 'lsp-ui-flycheck-list
  "] e" 'flycheck-next-error
  "[ e" 'flycheck-next-error
  "g r" 'lsp-find-references
  "C-x l S" 'lsp-ivy-workspace-symbol
  "C-x l s" 'helm-imenu
  "C-w v" 'split-window-right
  "C-w s" 'split-window-below
)
;; Magit keybindings
(general-define-key
  :keymaps 'magit-mode-map
  "C-n" 'magit-section-up
  "C-p" 'magit-section-down
  "<escape>" 'keyboard-quit
)
;; non-leader visual
(general-define-key
  :states 'visual
  ">" 'evil-shift-right
  "<" 'evil-shift-left
)
;; non-leader insert
(general-define-key
  :states 'insert
  "TAB" 'evil-shift-right-line
  "<backtab>" 'evil-shift-left-line
)

;; (general-setq evil-search-module 'evil-search)
(provide 'loumacs-keybindings)
