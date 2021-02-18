;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Vlad Ganshin"
      user-mail-address "vganshin@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-font (font-spec :font "Monoki Nerd Font Mono" :size 15))
(setq doom-theme 'doom-dracula)

(setq evil-escape-key-sequence "fd")

(smartparens-global-strict-mode)

(global-auto-revert-mode t)

;; (use-package! paredit
;;   :hook ((scheme-mode emacs-lisp-mode clojure-mode) . enable-paredit-mode))

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
         "w" #'sp-wrap-round))))

(map! :leader
      ;;; <leader> TAB --- workspace
      (:when (featurep! :ui workspaces)
       (:prefix-map ("TAB" . "workspace")
        :desc "Move right"  "}"   #'+workspace/swap-right
        :desc "Move left"   "{"   #'+workspace/swap-left)))


;; (map! (:localleader
;;        (:map (clojure-mode-map clojurescript-mode-map)
;;         (:prefix ("e" . "eval")
;;          "f" #'cider-eval-defun-at-point
;;          "F" #'cider-insert-defun-in-repl
;;          ";" #'cider-pprint-eval-last-sexp-to-comment)
;;         (:prefix ("i")
;;          "p" #'cider-inspector-pop)))
;;       (:leader
;;        (:map (clojure-mode-map clojurescript-mode-map emacs-lisp-mode-map)
;;         (:prefix ("k" . "lisp")
;;          "j" #'paredit-join-sexps
;;          "c" #'paredit-split-sexp
;;          "d" #'paredit-kill
;;          "<" #'paredit-backward-slurp-sexp
;;          ">" #'paredit-backward-barf-sexp
;;          "s" #'paredit-forward-slurp-sexp
;;          "b" #'paredit-forward-barf-sexp
;;          "r" #'paredit-raise-sexp
;;          "w" #'paredit-wrap-sexp
;;          "[" #'paredit-wrap-square
;;          "'" #'paredit-meta-doublequote
;;          "{" #'paredit-wrap-curly
;;          "y" #'sp-copy-sexp)))
;;       (:after ivy
;;        :map ivy-minibuffer-map
;;        "C-d" #'ivy-switch-buffer-kill))

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
          ("r" . "reagent.core"))))

;; (map! :leader
;;       :desc "Jump to char" "/ c" #'avy-goto-char)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; (+global-word-wrap-mode 0)

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

(after! cider
  (setq cider-repl-pop-to-buffer-on-connect nil)
  (set-popup-rule! "^\\*cider*" :size 0.45 :side 'right :select t :quit nil))

(setq
 projectile-project-search-path '("~/hs" "~/projects"))

;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
