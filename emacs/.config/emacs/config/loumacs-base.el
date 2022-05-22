;; UX related
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the graphical toolbar (open file etc.)
(menu-bar-mode -1)            ; Disable the menu bar
(tooltip-mode -1)           ; Tooltips shows info at the bottom
(set-fringe-mode 10)        ; Border on the side

;; Set default font size
(defvar loumacs/default-font-size 120)
(set-face-attribute 'default nil :height loumacs/default-font-size)
(set-face-attribute 'default nil :font "Inconsolata-13")

;; Package manager -> Straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; To install packages with straight, USE:
;; (use-package pkg_name
;;    :straight t
;;    ....
;; )
(straight-use-package 'use-package)
;; Configure use-package to use straight.el by default
(use-package straight
             :custom (straight-use-package-by-default t))

(use-package bind-key
  :straight t
  :ensure t
  :config
  (add-to-list 'same-window-buffer-names "*Personal Keybindings*"))

;; Eldoc mode -> documentation appears in minibuffer
(eldoc-mode)

;; Emacs customizations -- done automatically by Emacs
(defvar loumacs/custom-file (expand-file-name "custom.el" user-emacs-directory))
(setq custom-file                        loumacs/custom-file
      make-backup-files                  nil
      display-line-numbers-type          'relative ;; see below
      inhibit-startup-message            t
      use-package-always-ensure          t) ; always ensure that used packages are downloaded
(setq create-lockfiles nil)

;; Disable line numbers for certain modes
;; TODO: add vterm
(dolist (mode '(term-mode-hook
                eshell-mode-hook
                dashboard-setup-startup-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0)))
)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Need to load custom file to avoid being overwritten
;; more at https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Customizations.html
(if (file-exists-p loumacs/custom-file)
  (load custom-file))

;; Keep buffers automatically up to date -> when changed by another program, updates the buffer
(global-auto-revert-mode t)

;; Display line number
;; (setq-default display-line-numbers 'visual
;;               display-line-numbers-widen nil
;;               ;; this is the default
;;               display-line-numbers-current-absolute t)

;; customizing colors for current line number
(custom-set-faces '(line-number-current-line ((t :weight bold
                                                 :foreground "snow"
                                                 :background "deep pink"))))
;; Show matching parentheses
(show-paren-mode 1)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Default indent
(setq-default indent-tabs-mode nil
    tab-width 4)

(provide 'loumacs-base)
