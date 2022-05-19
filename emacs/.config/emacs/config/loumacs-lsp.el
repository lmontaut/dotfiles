(use-package lsp-mode
  :straight t
  :init
  (setq lsp-keymap-prefix "C-x l")
  (setq lsp-enable-file-watchers nil)
  (setq lsp-headerline-breadcrumb-enable nil) ;; disable the lsp bar above
  ;; (setq lsp-ui-doc-show-with-cursor nil)
  (setq lsp-ui-doc-show-with-mouse nil)
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration)
        )
  :commands (lsp lsp-deferred)
)

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

(use-package lsp-ui
  :straight t
  :after lsp-mode
  :commands lsp-ui-mode
)

;; (use-package lsp-treemacs
;;   :straight t
;;   :commands lsp-treemacs-errors-list
;; )

;; optionally if you want to use debugger
;; (use-package dap-mode
;;   :straight t
;; )
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; Choose btw ivy and helm
;; ivy + lsp
(use-package lsp-ivy
  :straight t
  :commands lsp-ivy-workspace-symbol
)


(provide 'loumacs-lsp)
