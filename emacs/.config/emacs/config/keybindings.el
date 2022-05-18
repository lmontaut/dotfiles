;; Misc functions
(defun loumacs/counsel-private-config ()
  "Opens the private emacs config files"
  (interactive)
  (counsel-find-file "~/dotfiles/emacs/.config/emacs/config"))

;; General allows to easily create keybindings
(use-package general
  :straight t
  :config
  (general-create-definer loumacs/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"
  )
  (general-create-definer loumacs/non-leader-keys
    :keymaps '(normal insert visual emacs)
  )
)

;; LEADER
;; -- leader-t
(loumacs/leader-keys
  "t"  '(:ignore t :which-key "toggles")
  "tt" '(counsel-load-theme :which-key "choose theme")
)
;; -- leader-f
(loumacs/leader-keys
  "f" '(:ignore t :which-key "files")
  "fp" '(loumacs/counsel-private-config :which-key "emacs config")
)

;; NON-lEADER
(loumacs/non-leader-keys
  "\\" '(evil-commentary :which-key "comment")
)

(provide 'keybindings)
