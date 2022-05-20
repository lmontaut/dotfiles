;; Helm
(use-package helm
  :straight t
  :bind
  ([remap find-file] . #'helm-find-files)
  ([remap execute-extended-command] . #'helm-M-x)
  ([remap switch-to-buffer] . #'helm-mini)
  ("C-x f" . helm-find-files)
)
(helm-mode)

;; Better help with helpful & counsel
(use-package helpful
  :straight t
  :after helm
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-key] . helpful-key)
)

(provide 'loumacs-helm)
