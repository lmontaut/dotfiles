(use-package lsp-mode
  :straight t
  :init
  (setq lsp-keymap-prefix "C-x l"
        lsp-enable-file-watchers nil
        lsp-headerline-breadcrumb-enable nil ;; disable the lsp bar above
        lsp-ui-doc-show-with-mouse nil
        ;; setq lsp-ui-doc-show-with-cursor nil
        ;; lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-show-diagnostics t
        lsp-idle-delay 0.1
        )
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration)
        )
  :commands (lsp lsp-deferred)
)

;; Setup LSP
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

;; Some languages need to be installed
;; PYTHON
(use-package lsp-pyright
  :straight t
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred)))
  :config
  (setq lsp-pyright-typechecking-mode "off")
)

;; ANACONDA
(use-package conda
  :straight t
  :config
  (custom-set-variables '(conda-anaconda-home "/home/lou/anaconda3/"))
  (setq conda-env-home-directory (expand-file-name "/home/lou/anaconda3/")
        conda-env-subdirectory "envs")
)

(use-package flycheck
  :straight t
  :after lsp-mode
)

(use-package hydra
  :straight t
  :after lsp-mode
)

(use-package avy
  :straight t
  :after lsp-mode
)

(use-package lsp-ui
  :straight t
  :after lsp-mode
  :config
  (setq lsp-ui-doc-position 'bottom)
)

(use-package lsp-treemacs
  :straight t
  :commands lsp-treemacs-errors-list
)

(use-package lsp-ivy
  :straight t
  :after lsp-mode
)

;; TODO optionally if you want to use debugger
;; (use-package dap-mode
;;   :straight t
;; )
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; Interaction with helm
(use-package helm-xref ;; find references
  :straight t
  :after helm)

(use-package helm-lsp
  :straight t
  :after lsp)

(provide 'loumacs-lsp)
