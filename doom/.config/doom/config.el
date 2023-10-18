;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Louis Montaut"
      user-mail-address "louismontaut@gmail.com")

;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept.
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 13 :weight 'normal))
;; doom-variable-pitch-font (font-spec :family "Fira Sans" :size 12))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-oksolar-light)
;; (setq doom-theme 'doom-oksolar-dark)
;; (setq doom-theme 'doom-monokai-octagon)
;; (setq doom-theme 'doom-tomorrow-day)
(setq doom-theme 'spacemacs-light)
(custom-set-faces!
  '(doom-dashboard-banner :inherit default)
  '(doom-dashboard-loaded :inherit default))
(set-face-bold 'bold nil)
;; (setq doom-theme 'doom-bluloco-light)
;; (setq doom-theme 'doom-one-light)
;; (setq doom-theme 'doom-feather-light)
;; (custom-set-faces!
  ;; `(font-lock-comment-face :background "#d5e8db" :foreground "#69786e"))
  ;; `(hl-line :background "#e8e2cc"))
(after! evil-snipe
  (set-face-foreground 'evil-snipe-matches-face "white")
  (set-face-foreground 'evil-snipe-first-match-face "orange")
  (set-face-background 'evil-snipe-matches-face "gray")
  (set-face-background 'evil-snipe-first-match-face "white")
  )

(setq evil-normal-state-cursor '(box "orange")
      evil-insert-state-cursor '(bar "orange")
      evil-visual-state-cursor '(hollow "orange"))

;; Turn on tree sitter highlighting -> a bit distracting actually
;; (add-hook 'prog-mode-hook 'tree-sitter-hl-mode)

;; Show indentation lines
;; -- Cheap version --
;; (defun lm/set-up-whitespace-handling ()
;;   (interactive)
;;   (setq whitespace-style '(face tabs spaces trailing indentation empty newline space-mark tab-mark))
;;   (whitespace-mode 1))
;; (add-hook 'prog-mode-hook 'lm/set-up-whitespace-handling)
;; -- More expensive version --
;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;; (after! highlight-indent-guides
;;   (setq-default highlight-indent-guides-method 'character)
;;   (setq-default highlight-indent-guides-auto-enabled nil)
;;   (set-face-background 'highlight-indent-guides-odd-face "lightgray")
;;   (set-face-background 'highlight-indent-guides-even-face "lightgray")
;;   (set-face-foreground 'highlight-indent-guides-character-face "lightgray")
;;   )
;; Alternative
;; (add-hook 'prog-mode-hook 'highlight-indentation-mode)
;; (add-hook 'prog-mode-hook 'highlight-indentation-current-column-mode)
;; (after! highlight-indentation
;;   (set-face-background 'highlight-indentation-face "old lace")
;;   (set-face-background 'highlight-indentation-current-column-face "#c3b3b3")
;;   )

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
        lsp-enable-suggest-server-download nil)
  (setq lsp-idle-delay 1.0) ;; don't refresh the lsp too often, annoying
  )
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
  (define-key company-mode-map (kbd "<tab>") 'company-complete))
(after! company
  (map! :i "S-<tab>" #'company-abort)
  ;; Adding company fuzzy
  ;; (add-hook 'company-mode-hook 'company-fuzzy-mode)
  ;; (setq company-fuzzy-sorting-backend 'flx
  ;;       company-fuzzy-prefix-on-top nil
  ;;       company-fuzzy-trigger-symbols '("." "->" "<" "\"" "'" "@"))
)
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
(defun evil-jump-forward-and-recenter()
  (interactive)
  (evil-jump-forward)
  (recenter))
(defun evil-jump-backward-and-recenter()
  (interactive)
  (evil-jump-backward)
  (recenter))
(setq +evil-want-o/O-to-continue-comments nil)

;; Use emacs keybindings in insert mode
;; (use-package evil
;;   :hook (after-init . evil-mode)
;;   :custom
;;   ;; use emacs bindings in insert-mode
;;   (evil-disable-insert-state-bindings t)
;;   (evil-want-keybinding nil))

(after! evil-mode
  ;; TODO: change that for python, use a hook to detect prog mode type
  (setq tab-width 4)
  (setq  evil-shift-width 2)
  )

;; --------------------------------------------------------
;; -------------- WHICH KEY / KEYBINDINGS -----------------
;; --------------------------------------------------------
;;
;; General keybindings
;;
(defun insert-line-below ()
  "Insert an empty line below the current line."
  (interactive)
  (save-excursion
    (end-of-line)
    (open-line 1)))
(defun insert-line-above ()
  "Insert an empty line above the current line."
  (interactive)
  (save-excursion
    (end-of-line 0)
    (open-line 1)))
;; Navigation in insert mode
(map! :map general-override-mode-map
      :i "C-d" #'kill-word ;; delete word forward

      ;; Navigation
      :vi "C-f" #'forward-char
      :vi "C-b" #'backward-char
      :nvi "C-h" #'backward-word
      :nvi "C-l" #'forward-word
      :nvi "C-j" #'evil-next-line
      :nvi "C-k" #'evil-previous-line
      :vi "C-e" #'end-of-line
      :vi "C-a" #'evil-next-line-1-first-non-blank

      ;; Insert line above/below
      :ni "C-0" #'insert-line-above
      :ni "C-9" #'insert-line-below

      ;; Horizontal scroll
      :vni "M-l" #'evil-scroll-right
      :vni "M-h" #'evil-scroll-left
      )

;; To train to use caps lock to escape insert mode
;; (setq evil-escape-key-sequence nil)

(setq which-key-idle-delay 0.3)

;;
;; Faster window manipulation
(defun louis-evil-window-increase-width ()
  (interactive)
  (evil-window-increase-width 5))
(defun louis-evil-window-increase-height ()
  (interactive)
  (evil-window-increase-height 5))
(defun louis-evil-window-decrease-width ()
  (interactive)
  (evil-window-decrease-width 5))
(defun louis-evil-window-decrease-height ()
  (interactive)
  (evil-window-decrease-height 5))

;;
;; Increase font size - finer control
(defun louis-increase-font-size ()
  (interactive)
  (doom/increase-font-size 1 1))
(defun louis-decrease-font-size ()
  (interactive)
  (doom/decrease-font-size 1 1))

(after! which-key
  ;; Comments
  (map! :nv "\\" #'evilnc-comment-operator)

  ;; Window manipulation
  (map! :nv "C-<right>" #'louis-evil-window-increase-width)
  (map! :nv "C-<left>" #'louis-evil-window-decrease-width)
  (map! :nv "C-<up>" #'louis-evil-window-increase-height)
  (map! :nv "C-<down>" #'louis-evil-window-decrease-height)

  ;; Code/LSP/Compilation
  (map! :leader
        (:prefix-map("c" . "code")
         :desc "lsp-treemacs-type-hierarchy" "T" #'lsp-treemacs-type-hierarchy
         :desc "lsp-treemacs-symbols" "I" #'lsp-treemacs-symbols
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

  ;; Recenter window on cursor
  (map! :n "L" #'evil-scroll-line-to-center)

  ;; Select/expand text
  (map! :n "C-SPC" #'er/mark-word
        :v "C-SPC" #'er/expand-region
        :v "S-<tab>" #'er/contract-region
        )

  ;; Projectile dired
  (map! :leader
        (:prefix-map("o" . "open")
         :desc "Projectile dired" "_" #'projectile-dired))

  ;; Multiple cursors made easier
  (map! :leader
        :desc "Multicursor start" "2" #'+multiple-cursors/evil-mc-toggle-cursor-here)

  (map! :i "C-<backspace>" #'delete-forward-char)
  )

;; Don't omit hidden files in dired & show r/w rights
;; TODO this currently doesn't work
;; (dired-omit-mode nil)
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode -1)))

;; I had this warning message, which told me to add these lines, seems reasonable:
;; !Your $HOME is recognized as a project root
;; Emacs will assume $HOME is the root of any project living under $HOME. If this
;; isn't desired, you will need to remove ".git" from
;; `projectile-project-root-files-bottom-up' (a variable), e.g.
;; (after! projectile
;;   (setq projectile-project-root-files-bottom-up (remove ".git"
;;         projectile-project-root-files-bottom-up)))

;; Give some room to the cursor when scrolling up/down
(setq scroll-margin 4)

;; Change compilation window height/width
(setq compilation-window-height 20)
(defun louis-compilation-window-change-size ()
  "Change the value of `compilation-window-height`."
  (interactive)
  (message "Current value of `compilation-window-height`: %s" compilation-window-height)
  (setq compilation-window-height (string-to-number (read-from-minibuffer "Enter a new value for `compilation-window-height`: " (number-to-string compilation-window-height))))
  (message "New value of `compilation-window-height`: %s" compilation-window-height))
;;
;; Change compilation window orientation
(setq louis-compilation-window-is-vertical nil)
(defun louis-compilation-window-cycle-orientation ()
  (interactive)
  (if louis-compilation-window-is-vertical
      (progn
        (setq louis-compilation-window-is-vertical nil)
        (message "Compilation mode set to horizontal"))
    (progn
      (setq louis-compilation-window-is-vertical t)
      (message "Compilation mode set to vertical"))
    )
  )
;;
;; Open compilation buffer in window
(defun louis-compilation-hook ()
  (when (not (get-buffer-window "*compilation*"))
    (if (one-window-p)
        (save-selected-window
          (save-excursion
            (if louis-compilation-window-is-vertical
                (let* ((w (split-window-horizontally))
                       (h (window-height w)))
                  (select-window w)
                  (switch-to-buffer "*compilation*")
                  (shrink-window (- h compilation-window-height))
                  )
              (let* ((w (split-window-vertically)))
                (select-window w)
                (switch-to-buffer "*compilation*")
                )
              )))
      (save-selected-window
        (save-excursion
          (ace-window 1)
          (switch-to-buffer "*compilation*")
          ))
      )))
(add-hook 'compilation-mode-hook 'louis-compilation-hook)
;;
;; Kill compilation window
(defun louis-kill-compilation-window ()
  (interactive)
  (let* ((w (get-buffer-window "*compilation*" t)))
    (if w
        (save-selected-window
          (save-excursion
            (select-window w)
            (evil-window-delete)))
      (message "No compilation window.")))
  )
(after! which-key
(map! :leader
      (:prefix-map("p" . "project")
       :desc "kill-compilation-window" "q" #'louis-kill-compilation-window)))

;;
;; Enable ifdef auto commenting based on lsp
(setq lsp-semantic-tokens-enable t)

;;
;; Make underscore as part of word
(defun louis-set-underscore-as-part-of-word ()
  (modify-syntax-entry ?_ "w")
  (modify-syntax-entry ?- "w")
  )
(add-hook 'prog-mode-hook 'louis-set-underscore-as-part-of-word)
