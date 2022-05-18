;; UX related
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the graphical toolbar (open file etc.)
(menu-bar-mode -1)            ; Disable the menu bar
(tooltip-mode -1)           ; Tooltips shows info at the bottom
(set-fringe-mode 0)        ; Border on the side

;; Set default font size
(defvar loumacs/default-font-size 100)
(set-face-attribute 'default nil :height loumacs/default-font-size)

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

;; Emacs customizations -- done automatically by Emacs
(defvar loumacs/custom-file (expand-file-name "custom.el" user-emacs-directory))
(setq custom-file                        loumacs/custom-file
      make-backup-files                  nil
      display-line-numbers-type          'relative
      inhibit-startup-message            t
      use-package-always-ensure          t) ; always ensure that used packages are downloaded
;; Disable line numbers for certain modes
;; TODO: add vterm
(dolist (mode '(term-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Need to load custom file to avoid being overwritten
;; more at https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Customizations.html
(if (file-exists-p loumacs/custom-file)
  (load custom-file))

;; Keep buffers automatically up to date -> when changed by another program, updates the buffer
(global-auto-revert-mode t)

;; Display line number
(global-display-line-numbers-mode)

;; Show matching parentheses
(show-paren-mode 1)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'base)
