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
    "tt" '(counsel-load-theme :which-key "choose theme")
    ;; leader-f
    "f" '(:ignore t :which-key "files")
    "fp" '(loumacs/counsel-private-config :which-key "emacs config")
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
  )
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
