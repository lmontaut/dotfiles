(use-package dashboard
  :straight t
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-banner-logo-title nil)
  (setq dashboard-items '((projects . 5)
                          (agenda . 5)
                          ))
)

(provide 'loumacs-dashboard)
