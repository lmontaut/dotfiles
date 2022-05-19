;; Ivy & councel deal with completion for files, M-x
;; Module for completing stuff
(use-package company
  :straight t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(provide 'loumacs-completion)
