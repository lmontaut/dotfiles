;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Louis Montaut"
      user-mail-address "louismontaut@gmail.com")

;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept.
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14 :weight 'normal))
;; doom-variable-pitch-font (font-spec :family "Fira Sans" :size 12))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-oksolar-light)
;; (setq doom-theme 'doom-oksolar-dark)
(custom-set-faces!
  `(font-lock-comment-face :foreground "#289c81"))
(after! evil-snipe
  (set-face-foreground 'evil-snipe-matches-face "white")
  (set-face-foreground 'evil-snipe-first-match-face "white")
  (set-face-background 'evil-snipe-matches-face "magenta")
  (set-face-background 'evil-snipe-first-match-face "orange")
  )

(setq evil-normal-state-cursor '(box "orange")
      evil-insert-state-cursor '(bar "orange")
      evil-visual-state-cursor '(hollow "orange"))

;; Show indentation lines
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(after! highlight-indent-guides
  (setq-default highlight-indent-guides-method 'bitmap)
  (setq-default highlight-indent-guides-auto-enabled nil)
  (set-face-background 'highlight-indent-guides-odd-face "lightgray")
  (set-face-background 'highlight-indent-guides-even-face "lightgray")
  (set-face-foreground 'highlight-indent-guides-character-face "lightgray")
  )

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; Disable if performance if bad.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; (setq display-line-numbers-type nil)

;; -------------------------------------
;; -------------- LSP ------------------
;; -------------------------------------
;;
;; C / C++
;;
;; For some reason lsp-lens is mega slow in c-mode
(setq lsp-lens-enable nil)
;; Disable invasive lsp-mode features
(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil
        ;; If an LSP server isn't present when I start a prog-mode buffer, you
        ;; don't need to tell me. I know. On some machines I don't care to have
        ;; a whole development environment for some ecosystems.
        lsp-enable-suggest-server-download nil))
(after! lsp-ui
  (setq lsp-ui-sideline-enable nil  ; no more useful than flycheck
        lsp-ui-doc-enable nil))     ; redundant with K

;;
;; Python
;;
(after! lsp-pyright
  (setq lsp-pyright-typechecking-mode "off"))

;; -------------------------------------------
;; -------------- DEBUG MODE -----------------
;; -------------------------------------------
;;
(after! dap-mode
  (setq dap-auto-configure-mode t) ;; "Automatically configure dap."
  (setq dap-auto-configure-features
        '(sessions locals breakpoints expressions tooltip)) ;; "Remove the button panel in the top."

  ;; dap for c++
  (require 'dap-lldb)

  ;;; set the debugger executable (c++)
  (setq dap-lldb-debug-program '("/opt/homebrew/Cellar/llvm/16.0.6/bin/lldb-vscode"))

  ;;; ask user for executable to debug if not specified explicitly (c++)
  (setq dap-lldb-debugged-program-function (lambda () (read-file-name "Select file to debug.")))

  ;;; default debug template for (c++)
  (dap-register-debug-template
   " ---- C++ LLDB dap ----"
   (list :type "lldb-vscode"
         :cwd nil
         :args nil
         :request "launch"
         :program nil))

  (defun dap-debug-create-or-edit-json-template ()
    "Edit the C++ debugging configuration or create + edit if none exists yet."
    (interactive)
    (let ((filename (concat (lsp-workspace-root) "/launch.json"))
	  (default "~/.config/doom/default-cpp-debug-launch.json"))
      (unless (file-exists-p filename)
	(copy-file default filename))
      (find-file-existing filename))))

;; -------------------------------------------
;; -------------- COMPLETION -----------------
;; -------------------------------------------
(setq-default company-idle-delay nil) ;; remove auto completion-search
;; Toggle completion-search with tab/S-tab
(after! company
  (define-key company-mode-map (kbd "<tab>") 'company-complete)
  )
(after! company
  (map! :i "S-<tab>" #'company-abort))
;; How to add a keybind for a specific mode:
;; (add-hook 'LaTeX-mode-hook
;;         (lambda () (local-set-key (kbd "C-0") #'run-latexmk)))

;; ------------------------------------
;; -------------- LSP -----------------
;; ------------------------------------
;; Clangd
(after! lsp-clangd
  (setq lsp-clients-clangd-args
        '("-j=4"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=never"
          "--header-insertion-decorators=0"))
  (set-lsp-priority! 'clangd 2))

;; --------------------------------------
;; -------------- IMENU -----------------
;; --------------------------------------
(after! imenu-list
  (setq imenu-list-size 0.3))

;; -------------------------------------------
;; -------------- EVIL SETUP -----------------
;; -------------------------------------------
;; Utility function to jump back/forth and recenter
(defun mm/evil-jump-forward-and-recenter()
  (evil-jump-forward)
  (recenter))
(defun mm/evil-jump-backward-and-recenter()
  (evil-jump-backward)
  (recenter))
(setq +evil-want-o/O-to-continue-comments nil)

;; --------------------------------------------------------
;; -------------- WHICH KEY / KEYBINDINGS -----------------
;; --------------------------------------------------------
;;
;; Utility function to record compilation commands in a buffer
;;
(defun mm/compile-and-record-command(cmd)
  (interactive
   (list (completing-read "Compile command: " compile-history)))
  (compile cmd)
  (push cmd compile-history))
;; Reset compile history
(defun mm/reset-compile-history()
  (interactive
   (setq-default compile-history nil))
  (message "Reset compilation history."))

(setq which-key-idle-delay 0.3)
(after! which-key
  ;; Comments
  (map! :nv "\\" #'evilnc-comment-operator)

  ;; Window manipulation
  (map! :nv "C-<right>" #'evil-window-increase-width)
  (map! :nv "C-<left>" #'evil-window-decrease-width)
  (map! :nv "C-<up>" #'evil-window-increase-height)
  (map! :nv "C-<down>" #'evil-window-decrease-height)

  ;; Code/LSP/Compilation
  (map! :leader
        (:prefix-map("c" . "code")
         :desc "Compile" "c" #'mm/compile-and-record-command
         :desc "lsp-ui-imenu" "I" #'lsp-ui-imenu
         :desc "Reset compile commands" "R" #'mm/reset-compile-history
         :desc "compilation-goto-in-progress-buffer" "p" #'compilation-goto-in-progress-buffer
         :desc "compilation-goto-in-progress-buffer" "k" #'kill-compilation))

  ;; Search
  (map! :leader
        (:prefix-map("s" . "search")
         :desc "consult-ripgrep" "g" #'consult-ripgrep))
  ;; Org mode
  (map! :leader
        (:prefix-map("ms")
         :desc "org-move-item-up"   "K" #'org-move-item-up
         :desc "org-move-item-down" "J" #'org-move-item-down
         ))

  ;; Indentation
  (map! :v "C-." #'+evil/shift-right
        :v "C-," #'+evil/shift-left
        :ni "C-." #'evil-shift-right-line
        :ni "C-," #'evil-shift-left-line)

  (map! :i "C-d" #'kill-word)
  )

;; Don't omit hidden files in dired & show r/w rights
;; (defun louis-configure-dired-mode ()
;;   (dired-omit-mode nil))
;; (add-hook 'dired-mode-hook 'louis-configure-dired-mode)

(add-hook 'dired-mode-hook (lambda () (dired-omit-mode nil)))
