;; which-key to track keybindings
(use-package which-key
  :straight t
  :defer 0
  ;; A diminished mode is a minor mode that has had its mode line display diminished
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5))

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
  ;; leader everywhere
  (general-define-key
   :keymaps '(normal insert visual emacs)
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
  ;; non-leader normal + visual
  (general-define-key
   :keymaps '(normal visual)
    "\\" 'evil-commentary
  )
  ;; non-leader normal
  (general-define-key
    :keymaps '(normal)
    ">" 'evil-shift-right-line
    "<" 'evil-shift-left-line
    "K" 'lsp-ui-doc-glance
    "C-x l d" 'lsp-ui-flycheck-list
    "] e" 'flycheck-next-error
    "[ e" 'flycheck-next-error
    "g r" 'lsp-find-references
    "C-x l S" 'lsp-ivy-workspace-symbol
    "C-x l s" 'helm-imenu
  )
  ;; Magit keybindings
  ;; (general-define-key
  ;;   :keymaps '(normal)
  ;;   :hook magit-mode-hook
  ;;   "C-n" 'magit-section-up
  ;;   "C-p" 'magit-section-down
  ;; )
  ;; non-leader visual
  (general-define-key
    :keymaps '(visual)
    ">" 'evil-shift-right
    "<" 'evil-shift-left
  )
  ;; non-leader insert
  (general-define-key
   :keymaps '(insert)
    "TAB" 'evil-shift-right-line
    "<backtab>" 'evil-shift-left-line
  )
)

(provide 'loumacs-keybindings)
