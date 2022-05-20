;; show hunk on the sidebar
(use-package git-gutter
  :straight t
  :config
  (add-hook 'prog-mode-hook 'git-gutter-mode)
)

;; Magit
(use-package magit
  :straight t
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; evil-magit is part of the evil collection
;; (use-package evil-magit
;;   :straight t
;;   :after magit)


(provide 'loumacs-git)
