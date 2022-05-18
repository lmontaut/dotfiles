;; Ivy & councel deal with completion for files, M-x
(use-package ivy
  :straight t
  :bind (("C-x C-s" . swiper)
	 ("C-x C-r" . ivy-resume)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil))

;; Ivy and counsel are the same package. See above.
(use-package counsel
  :straight t
  :bind
  ("M-x" . counsel-M-x)
  ("C-x C-m" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("C-x c k" . counsel-yank-pop))

;; Module for completing stuff
(use-package company
  :straight t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package which-key
  :straight t
  :defer 0
  ;; A diminished mode is a minor mode that has had its mode line display diminished
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5))

(provide 'completion)
