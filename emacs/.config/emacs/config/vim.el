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
  (evil-mode 1)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  ;; Start in normal mode
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
)

(use-package evil-commentary
  :straight t
  :config
  (evil-commentary-mode)
)

;; key-chord allows to type sequences of keys
(use-package key-chord
  :straight t
  :init
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  :config
  (key-chord-mode 1))


(provide 'vim)
