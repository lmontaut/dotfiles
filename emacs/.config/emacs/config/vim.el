;; evil vim
(use-package evil
  :straight t
  :init
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

;; key-chord allows to type sequences of keys
(use-package key-chord
  :straight t
  :init
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  :config
  (key-chord-mode 1))

(provide 'vim)
