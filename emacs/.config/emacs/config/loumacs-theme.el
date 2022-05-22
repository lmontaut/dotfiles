; Custom theme based on adwaita is in custom.el
(use-package spacemacs-theme
  :straight t
  :defer t
;; :init
;  (load-theme 'spacemacs-light t)
;  (load-theme 'spacemacs-dark t)
); have it available if needed

(use-package doom-modeline
  :straight t
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;(use-package spaceline
;  :straight t
;  :ensure t
;  :config (spaceline-spacemacs-theme))

(provide 'loumacs-theme)
