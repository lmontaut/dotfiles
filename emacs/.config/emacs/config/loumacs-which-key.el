;; which-key to track keybindings
(use-package which-key
  :straight t
  :defer 0
  ;; A diminished mode is a minor mode that has had its mode line display diminished
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5))

(provide 'loumacs-which-key)
