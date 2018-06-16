(setq nim-packages
      '(company
        flycheck
        flycheck-nim
        nim-mode))

(defun nim/post-init-company ()
  (spacemacs|add-company-hook nim-mode)
  (spacemacs|add-company-hook nimscript-mode))

(defun nim/post-init-flycheck ()
  (spacemacs/add-flycheck-hook 'nim-mode))

(defun nim/init-flycheck-nim ()
  (use-package flycheck-nim
    :if (configuration-layer/package-usedp 'flycheck)))

(defun nim/init-nim-mode ()
  (use-package nim-mode
    :defer t
    :init
    (progn
      (when (configuration-layer/package-usedp 'company)
        (push 'company-capf company-backends-nim-mode))
      (add-hook 'nim-mode-hook 'nimsuggest-mode)
      (push 'nimsuggest-find-definition spacemacs-jump-handlers-nim-mode))
    :config
    (progn
      (defun spacemacs/nim-compile-run ()
        (interactive)
        (shell-command "nim compile --run main.nim"))

      (spacemacs/declare-prefix-for-mode 'nim-mode "mc" "compile")
      (spacemacs/declare-prefix-for-mode 'nim-mode "mg" "goto")
      (spacemacs/declare-prefix-for-mode 'nim-mode "mgf" "function")
      (spacemacs/declare-prefix-for-mode 'nim-mode "mgb" "block")
      (spacemacs/declare-prefix-for-mode 'nim-mode "mgl" "line")
      ;; (spacemacs/declare-prefix-for-mode 'nim-mode "mh" "help")
      (spacemacs/declare-prefix-for-mode 'nim-mode "ms" "search")
      (spacemacs/set-leader-keys-for-major-mode 'nim-mode
        "cr" 'spacemacs/nim-compile-run
        "cb" 'nim-compile
        ; functions
        "gfe" 'nim-nav-end-of-defun
        "gfa" 'nim-nav-beginning-of-defun
        "gfp" 'nim-nav-backward-defun
        "gfn" 'nim-nav-forward-defun
        ;; statements
        "gla" 'nim-nav-beginning-of-statement
        "gle" 'nim-nav-end-of-statement
        "glb" 'nim-nav-backward-statement
        "glf" 'nim-nav-forward-statement
        "gle" 'nim-nav-end-of-statement
        ; blocks
        "gba" 'nim-nav-beginning-of-block
        "gbe" 'nim-nav-end-of-block
        "gbp" 'nim-nav-backward-block
        "gbf" 'nim-nav-forward-block
        "g]" 'nim-nav-up-list
        "g[" 'nim-nav-backward-up-list
        ;; search
        "sd" 'xref-find-definitions
        "sD" 'xref-find-definitions-other-window
        "sr" 'xref-find-references
        "sb" 'pop-tag-mark))))
