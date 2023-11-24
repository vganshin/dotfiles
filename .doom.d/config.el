;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Vlad Ganshin"
      user-mail-address "vganshin@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

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

(setq evil-escape-key-sequence "fd")
(smartparens-global-strict-mode)
(global-auto-revert-mode t)

(map! (:localleader
      (:map (clojure-mode-map clojurescript-mode-map)
       (:prefix ("e" . "eval")
        "f" #'cider-eval-defun-at-point
        ";" #'cider-pprint-eval-last-sexp-to-comment)))
      (:leader
       (:map (clojure-mode-map clojurescript-mode-map emacs-lisp-mode-map)
        (:prefix ("s" . "cider")
         "a" #'cider-switch-to-repl-buffer)
        (:prefix ("k" . "lisp")
         (:prefix ("d" . "kill")
          "x" #'sp-kill-sexp
          "X" #'sp-backward-kill-sexp)
         "s" #'sp-forward-slurp-sexp
         "S" #'sp-backward-slurp-sexp
         "b" #'sp-forward-barf-sexp
         "B" #'sp-backward-barf-sexp
         "w" #'sp-wrap-round
         "r" #'paredit-raise-sexp))))

(map! :leader
      ;;; <leader> TAB --- workspace
      ("ESC" #'evil-switch-to-windows-last-buffer)
      (:when (featurep! :ui workspaces)
       (:prefix-map ("TAB" . "workspace")
        :desc "Move right"  "}"   #'+workspace/swap-right
        :desc "Move left"   "{"   #'+workspace/swap-left)))

(after! clojure-mode
  (setq cljr-magic-require-namespaces
        '(("io" . "clojure.java.io")
          ("sh" . "clojure.java.shell")
          ("jdbc" . "clojure.java.jdbc")
          ("set" . "clojure.set")
          ("time" . "java-time")
          ("str" . "clojure.string")
          ("zen" . "zen.core")
          ("path" . "pathetic.core")
          ("walk" . "clojure.walk")
          ("zip" . "clojure.zip")
          ("async" . "clojure.core.async")
          ("http" . "clj-http.client")
          ("url" . "cemerick.url")
          ("csv" . "clojure.data.csv")
          ("json" . "cheshire.core")
          ("cp" . "com.climate.claypoole")
          ("rf" . "re-frame.core")
          ("rf.db" . "re-frame.db")
          ("zf" . "zf")
          ("r" . "reagent.core"))))

(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil))

(add-hook! '(clojure-mode-local-vars-hook
             clojurec-mode-local-vars-hook
             clojurescript-mode-local-vars-hook)
  (defun lsp-cl-params ()
    (setq-local lsp-enable-symbol-highlighting nil)
    (setq-local lsp-diagnostic-package :none))
  (defun my-flycheck-setup ()
    (setq-local flycheck-disabled-checkers '(lsp))
    (setq-local flycheck-checkers '(clj-kondo-clj clj-kondo-cljs clj-kondo-cljc clj-kondo-edn))))

(defun nothing () nil)

(after! cider
  (setq cider-repl-pop-to-buffer-on-connect nil)

  ;;(setq cider-repl-pop-to-buffer-on-connect 'display-only)

  (set-popup-rule! "^\\*cider*" :size 0.45 :side 'right :select t :quit nil)

  ;; (setq cider-show-error-buffer 'only-in-repl)

  )

(setq projectile-project-search-path '("~/hs" "~/projects"))





(defun run-sql ()
  (interactive)
  (save-excursion
    ;; Take SQL
    (search-backward "----")
    (setq p1 (point))
    (search-forward  "----")
    (search-forward  "----")
    (setq sql (buffer-substring p1 (point)) )
    ;; Take psql connection string
    (search-backward "---- db:")
    (setq conn (substring (buffer-substring (point) (line-end-position)) 8 ))

    (setq cmd (format "echo \"\n%s\" | psql %s" sql conn))
    (with-output-to-temp-buffer "*SQL Result*"
      (set-buffer "*SQL Result*")
      (funcall (intern "sql-mode"))
      (insert (shell-command-to-string cmd)))))

(define-key evil-normal-state-map (kbd "RET") 'run-sql)

