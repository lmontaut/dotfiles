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
  (setq ivy-use-virtual-buffers nil)
  ;; by default ivy puts a "^" which means that it will find everything *starting* with
  ;; what is after "^". This setting removes that behavior
  (setq ivy-initial-inputs-alist nil)
  ;; the following prevents ivy from suggesting "." and ".." when listing dirs
  (setq ivy-extra-directories ())
  ;; fuzzy matching
  (setq ivy-re-builders-alist
        '((t . ivy--regex-fuzzy)))
)
;; we load ivy immediatly, otherwise it waits for a keystroke to be activated
;; this problematic when we want to do stuff which ivy works on but has no
;; "ivy-..." bindings attached to it
;; (ivy-mode 1)

;; Ivy and counsel belong to the same package. See above.
(use-package counsel
  :straight t
)

Better help with Helpful & counsel
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

(provide 'loumacs-ivy)
