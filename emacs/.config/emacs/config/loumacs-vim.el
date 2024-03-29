;; evil vim
(use-package evil
  :straight t
  :init
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump t)
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  (setq evil-shift-width 2)
  :config
  (evil-mode 1)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  ;; Start in normal mode
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
)

;; more evil -> more support for areas in emacs where evil is not well supported
(use-package evil-collection
  :straight t
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-commentary
  :straight t
  :config
  (evil-commentary-mode)
)

;; key-chord allows to type sequences of keys
;; (use-package key-chord
;;   :straight t
;;   :init
;;   (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
;;   :config
;;   (key-chord-mode 1))


(provide 'loumacs-vim)
