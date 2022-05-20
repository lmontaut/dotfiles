;; Ivy & councel deal with completion for files, M-x
;; Module for completing stuff
(use-package company
  :straight t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
)
(global-company-mode)

(provide 'loumacs-completion)
