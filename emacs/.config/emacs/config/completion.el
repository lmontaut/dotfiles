;; Ivy & councel deal with completion for files, M-x
(use-package ivy
  :straight t
  :bind (("C-s" . swiper)
	 ("C-x C-r" . ivy-resume)
	 :map ivy-minibuffer-map
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line) ;; needed, otherwise C-k deletes the buffer
	 ("C-d" . ivy-switch-buffer-kill)
	 )
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil))

;; Ivy and counsel are the same package. See above.
(use-package counsel
  :straight t
  :bind
;  ("M-x" . counsel-M-x)
  ("C-x C-m" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("C-x c k" . counsel-yank-pop))

;; Better help with Helpful & counsel
(use-package helpful
  :straight t
  :after counsel
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key)
)

;; Module for completing stuff
(use-package company
  :straight t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package helm
  :straight t
  :bind (("M-x" . helm-M-x)
	 )
  )

(use-package which-key
  :straight t
  :defer 0
  ;; A diminished mode is a minor mode that has had its mode line display diminished
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5))

(provide 'completion)
