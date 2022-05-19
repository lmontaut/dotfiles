;; Helm
(use-package helm
  :straight t
  :bind
  ([remap find-file] . #'helm-find-files)
  ([remap execute-extended-command] . #'helm-M-x)
  ([remap switch-to-buffer] . #'helm-mini)
)
(helm-mode)

;; Better help with helpful
(use-package helpful
  :straight t
  ;; :after counsel
  ;; :custom
  ;; (counsel-describe-function-function #'helpful-callable)
  ;; (counsel-describe-variable-function #'helpful-variable)
  ;; :bind
  ;; ([remap describe-function] . counsel-describe-function)
  ;; ([remap describe-command] . helpful-command)
  ;; ([remap describe-variable] . counsel-describe-variable)
  ;; ([remap describe-key] . helpful-key)
)

(provide 'loumacs-helm)
