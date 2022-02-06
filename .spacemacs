;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     yaml
     csv
     sql
     ruby
     markdown
     python
     html
     vimscript
     php
     javascript
     c-c++
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     auto-completion
     (latex :variables
            latex-build-command "LatexMk"
            latex-enable-auto-fill nil)
     better-defaults
     emacs-lisp
     git
     markdown
     org
     (org :variables
          ;; org-projectile-file "TODOs.org"
          org-enable-github-support t
          org-enable-reveal-js-support t
          )
     shell
     (shell :variables
            shell-default-position 'top)
     ;; spell-checking
     syntax-checking
     (syntax-checking :variables syntax-checking-enable-tooltips nil)
     (python :variables
             python-enable-yapf-format-on-save nil
             python-sort-imports-on-save nil)
     version-control
     (version-control :variables
                      ;; version-control-diff-tool 'diff-hl
                      version-control-diff-tool 'git-gutter
                      version-control-diff-side 'left
                      version-control-global-margin t)
     games
     search-engine
     ipython-notebook
     fzf
     japanese
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(
                                      yasnippet-snippets
                                      org-projectile
                                      org-re-reveal
                                      writeroom-mode
                                      jedi
                                      simplenote2


                                      bind-key
                                      quickrun
                                      migemo
                                      impatient-mode
                                      ox-gfm
                                      codic
                                      all-the-icons
                                      all-the-icons-dired
                                      auth-source
                                      )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(
                                    git-gutter+
                                    git-gutter-fringe
                                    git-gutter-fringe+
                                    pangu-spacing

                                    )
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Han Code JP"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server t
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 this function is mostly useful for variables that need to be set
before packages are loaded. if you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  (setq spacemacs-evil-cursors '(("normal" "chartreuse3" box)
                                 ("insert" "skyblue" (bar . 2))
                                 ("emacs" "skyblue2" box)
                                 ("hybrid" "darkgoldenrod2" box)
                                 ("replace" "chocolate" (hbar . 2))
                                 ("evilified" "lightgoldenrod3" box)
                                 ("visual" "orange" (hbar . 2))
                                 ("motion" "plum3" box)
                                 ("lisp" "hotpink1" box)
                                 ("iedit" "firebrick1" box)
                                 ("iedit-insert" "firebrick1" (bar . 2))))

  ;; 初期モードを text モードにする
  ;; (setq initial-major-mode 'text-mode)

  ;; ウィンドウを半透明にする
  (if window-system
      (progn
        (set-frame-parameter nil 'alpha 95)
        ))

  ;; Magit(Git クライアント)をフルスクリーンで表示する
  ;; https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Bsource-control/git#magit-status-fullscreen
  (setq-default git-magit-status-fullscreen t)


  ;; gls
  (let ((gls "/usr/local/bin/gls"))
    (if (file-exists-p gls) (setq insert-directory-program gls)))

  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;; key-bind
  (define-key evil-motion-state-map "H" 'evil-first-non-blank)
  (define-key evil-normal-state-map "L" 'evil-end-of-line)
  (define-key evil-visual-state-map "L" "$h")
  (define-key evil-motion-state-map "}" 'evil-join)
  (define-key evil-normal-state-map "J" "10j")
  (define-key evil-visual-state-map "J" "10j")
  (define-key evil-normal-state-map "K" "10k")
  (define-key evil-visual-state-map "K" "10k")
  (define-key evil-motion-state-map (kbd ";") #'evil-ex)
  (define-key evil-normal-state-map (kbd ":") 'evil-repeat-find-char)

  ;; tab
  (setq-default tab-width 2 indent-tabs-mode nil)

  ;; js mode
  (add-hook 'js-mode-hook (lambda ()
                            (setq js2-cleanup-whitespace nil
                                  js2-mirror-mode nil
                                  js2-bounce-indent-flag nil
                                  js2-basic-offset 2
                                  js2-strict-inconsistent-return-warning nil
                                  js2-strict-missing-semi-warning nil
                                  js2-missing-semi-one-line-override nil)
                            (setq tab-width 2)
                            (setq indent-tabs-mode nil)))

  ;; php mode
  (add-hook 'php-mode-hook (lambda ()
                             (setq c-basic-offset 4)
                             (setq tab-width 4)
                             (setq indent-tabs-mode t)
                             (c-set-offset 'case-label' 4)
                             (c-set-offset 'arglist-intro' 4)
                             (c-set-offset 'arglist-cont-nonempty' 4)
                             (c-set-offset 'arglist-close' 0)))

  ;; web-mode の設定
  (require 'web-mode)
  (add-to-list 'auto-mode-alist '("\\.ctp\\'"   . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-hook 'web-mode-hook (lambda ()
                             (setq indent-tabs-mode t)
                             (setq web-mode-markup-indent-offset 2)
                             (setq web-mode-css-indent-offset 2)
                             (setq web-mode-code-indent-offset 2)
                             (setq web-mode-comment-style 2)
                             (setq web-mode-indent-style 2)
                             (setq web-mode-enable-comment-interpolation t)
                             (setq web-mode-enable-current-element-highlight t)
                             (setq web-mode-enable-current-column-highlight t)
                             ;; (setq web-mode-enable-auto-pairing t)
                             ;; (setq web-mode-enable-auto-closing t)
                             (setq web-mode-engines-alist
                                   '(("php"    . "\\.ctp\\'"))
                                   )
                             ))

  ;; 色の設定
  (custom-set-faces
   '(web-mode-doctype-face
     ((t (:foreground "#82AE46"))))                          ; doctype
   '(web-mode-html-tag-face
     ((t (:foreground "#E6B422" :weight bold))))             ; 要素名
   '(web-mode-html-attr-name-face
     ((t (:foreground "#C97586"))))                          ; 属性名など
   '(web-mode-html-attr-value-face
     ((t (:foreground "#82AE46"))))                          ; 属性値
   '(web-mode-comment-face
     ((t (:foreground "#D9333F"))))                          ; コメント
   '(web-mode-server-comment-face
     ((t (:foreground "#D9333F"))))                          ; コメント
   '(web-mode-css-rule-face
     ((t (:foreground "#A0D8EF"))))                          ; css のタグ
   '(web-mode-css-pseudo-class-face
     ((t (:foreground "#FF7F00"))))                          ; css 疑似クラス
   '(web-mode-css-at-rule-face
     ((t (:foreground "#FF7F00"))))                          ; css のタグ
   )

  ;; indent
  (setq indent-guide-recursive t)

  ;; 可視化
  (global-whitespace-mode 1)
  (setq whitespace-style '(face spaces space-mark tab-mark tabs))
  (setq whitespace-action '(auto-cleanup))
  (setq whitespace-space-regexp "\\(\u3000+\\)")

  (setq whitespace-display-mappings '((space-mark ?\u3000 [?\u25a1]) (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

  ;; multiple-cursors
  (defun user-custom/evil-mc-make-and-goto-next-match ()
    (interactive)
    (turn-on-evil-mc-mode)
    (evil-mc-make-and-goto-next-match))
  (defun user-custom//evil-mc-make-vertical-cursors (beginning end)
    (turn-on-evil-mc-mode)
    (evil-mc-pause-cursors)
    (evil-apply-on-rectangle
      #'(lambda (startcol endcol real-line-number)
          (move-to-column startcol)
          (unless (= (line-number-at-pos) real-line-number)
            (evil-mc-make-cursor-here)))
      beginning
      end
      (line-number-at-pos))
    (evil-mc-resume-cursors)
    (evil-normal-state)
    (move-to-column (min (evil-mc-column-number beginning)
                          (evil-mc-column-number end))))
  (require 'evil-core)
  (evil-global-set-key 'normal
                        (kbd "C-n")
                        #'user-custom/evil-mc-make-and-goto-next-match)
  (evil-global-set-key 'visual
                        (kbd "C-n")
                        #'(lambda (beginning end)
                            (interactive (list (region-beginning) (region-end)))
                            (if (eq (evil-visual-type) 'inclusive)
                                (user-custom/evil-mc-make-and-goto-next-match)
                              (user-custom//evil-mc-make-vertical-cursors beginning end))))
  (with-eval-after-load 'evil-mc
    (evil-define-key 'normal evil-mc-key-map
      (kbd "C-n") #'evil-mc-make-and-goto-next-match
      (kbd "C-m") #'evil-mc-make-and-goto-prev-match
      (kbd "C-x") #'evil-mc-skip-and-goto-next-match
      (kbd "C-p") nil
      (kbd "C-t") nil
      (kbd "<escape>") #'(lambda ()
                            (interactive)
                            (evil-mc-undo-all-cursors)
                            (turn-off-evil-mc-mode)))
    (evil-define-key 'visual evil-mc-key-map
      (kbd "C-n") nil
      (kbd "C-p") nil
      (kbd "C-t") nil)
    ;; evil-escape don't work in evil-mc-mode
    (add-hook 'evil-mc-mode-hook
              #'(lambda ()
                  (add-to-list 'evil-mc-incompatible-minor-modes
                                'evil-escape-mode))))

  ;; helm
  (setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
  (setq helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match    t)
  (setq helm-ff-fuzzy-matching t)


  ;; dumb-jump
  (setq dumb-jump-mode t)
  (setq dumb-jump-force-searcher 'ag)
  (setf dumb-jump-selector 'helm)
  (global-set-key (kbd "C-M-w") 'dumb-jump-go-other-window)

  ;; my function
  (defun toggle-camelcase-underscores ()
    "Toggle between camelcase and underscore notation for the symbol at point."
    (interactive)
    (save-excursion
      (let* ((bounds (bounds-of-thing-at-point 'symbol))
             (start (car bounds))
             (end (cdr bounds))
             (currently-using-underscores-p (progn (goto-char start)
                                                   (re-search-forward "_" end t))))
        (if currently-using-underscores-p
            (progn
              (upcase-initials-region start end)
              (replace-string "_" "" nil start end)
              (downcase-region start (1+ start)))
          (replace-regexp "\\([A-Z]\\)" "_\\1" nil (1+ start) end)
          (downcase-region start (cdr (bounds-of-thing-at-point 'symbol)))))))

  (defun php-class-validation-from-string()
    (interactive)
    (let ((str (buffer-substring-no-properties (point-at-bol) (point-at-eol))))
      (insert (concat "$this->validate['" str "'] = $this->__ValidationRule->get" (s-upper-camel-case str) "ValidationRule();" "\n"))
      (kill-line)))

  (defun php-class-getter-function-from-string (str)
    (concat "public function get" (s-upper-camel-case str) "(){" "\n"
            "	return isset($this->" str ") ? $this->" str ": false;\n"
            "}" "\n"))

  (defun php-class-setter-function-from-string (str)
    (concat "public function set" (s-upper-camel-case str) "($val){" "\n"
            "	$this->" str " = $val;" "\n"
            "	return $this;" "\n"
            "}" "\n"))

  (defun php-class-function-from-string ()
    (interactive)
    (let ((str (buffer-substring-no-properties (point-at-bol) (point-at-eol))))
      (delete-region (point-at-bol) (point-at-eol))
      (insert (php-class-getter-function-from-string str))
      (insert (php-class-setter-function-from-string str))
      (kill-line)))

  ;; org
  (setq org-capture-templates
        '(("t" "Todo" entry (file "~/org/todo.org")
           "* TODO %?\n    %i\n   %a\n    %T")
          ("n" "note" entry (file "~/org/note.org")
           "* %?\n   %a\n    %T")
          ("c" "Code" entry (file "~/org/code.org")
           "* %?\n   %a\n    %T\n    %F")
          ("m" "memo" entry (file+headline "~/org/memo.org" "Memo")
           "* %?\nEntered on %T\n")
          ))

  (defun show-org-buffer (file)
    "Show an org-file FILE on the current buffer."
    (interactive)
    (if (get-buffer file)
        (let ((buffer (get-buffer file)))
          (switch-to-buffer buffer)
          (message "%s" file))
      (find-file (concat "~/org/" file))))
  (spacemacs/set-leader-keys "aov" '(lambda () (interactive) (show-org-buffer "memo.org")))

  ;; (with-eval-after-load 'org-agenda
  ;;   (require 'org-projectile)
  ;;   (push (org-projectile:todo-files) org-agenda-files))

  (setq org-bullets-bullet-list '("■" "◆" "▲" "▶"))


  ;; java
  (setq
   eclim-eclipse-dirs '("/Applications/Eclipse\\ Java.app/Contents/Eclipse")
   eclim-executable "/Applications/Eclipse\\ Java.app/Contents/Eclipse/plugins/org.eclim_2.8.0/bin/eclim"
   ;; Use another eclimd executable
   eclimd-executable "/Applications/Eclipse\\ Java.app/Contents/Eclipse/eclimd"
   ;; Specify the workspace to use by default
   eclimd-default-workspace "~/workspace/pentas/eclipse/"
   ;; Whether or not to block emacs until eclimd is ready
   eclimd-wait-for-process t)

  ;; japanese
  (setenv "LANG" "ja_JP.UTF-8")

  ;; align
  (if (not (fboundp 'defun-if-undefined))
      (defmacro defun-if-undefined (name &rest rest)
        `(unless (fboundp (quote ,name))
           (defun ,name ,@rest))))

  (defun-if-undefined inside-string-or-comment-p ()
    (let ((state (parse-partial-sexp (point-min) (point))))
      (or (nth 3 state) (nth 4 state))))

  (defun-if-undefined re-search-forward-without-string-and-comments (&rest args)
    (let ((value (apply #'re-search-forward args)))
      (if (and value (inside-string-or-comment-p))
          (apply #'re-search-forward-without-string-and-comments args)
        value)))

  (defun my-buffer-indent-tabs-code-p (&optional buffer)
    "Check first indent char."
    (let ((buffer (or buffer (current-buffer))))
      (with-current-buffer buffer
        (save-excursion
          (save-restriction
            (widen)
            (goto-char (point-min))
            (and (re-search-forward-without-string-and-comments "^[ \t]"
                                                                (point-max) t)
                 (string= (match-string 0) "\t")))))))

  (defun my-set-indent-tabs-mode ()
    (setq indent-tabs-mode (my-buffer-indent-tabs-code-p)))

  (defadvice align-regexp (around advise-align-regexp activate)
    "Let align-regexp indent by spaces."
    (when indent-tabs-mode (setq indent-tabs-mode nil))
    ad-do-it
    (my-set-indent-tabs-mode))

  ;; latex
  (add-hook 'doc-view-mode-hook 'auto-revert-mode)
  (add-hook 'LaTeX-mode-hook
            (function (lambda ()
                        (add-to-list 'TeX-command-list
                                    '("LatexMk" ; ここの名前を変更
                                      "latexmk -pvc %t"
                                      TeX-run-TeX nil (latex-mode) :help "Run Latexmk")))))

  (add-hook 'LaTeX-mode-hook '(lambda ()
                               (cond (let ((prefer-coding-system 'shift_jis-unix))
                                        (revert-buffer t t)))))

  ;; ファイル読み込み 文字コード
  ;; (add-hook 'find-file-hook '(lambda ()
  ;;                              (cond ((string-match "undecided-?.*" (format "%s" buffer-file-coding-system))
  ;;                                     (let ((coding-system-for-read 'utf-8))
  ;;                                       (revert-buffer t t))))))
  ;;(prefer-coding-system 'utf-8-dos)
  ;;(prefer-coding-system 'shift_jis-unix)

  ;; org-re-reveal
  (use-package org-re-reveal :after org)

  ;; ;; write mode
  (require 'writeroom-mode)
  ;; 有効にするメジャーモード
  (setq writeroom-major-modes '(text-mode org-mode))
  ;; 横幅を 80 桁に設定
  (setq writeroom-width 80)
  ;; ;; 上のマージンを 100 に設定
  ;; (setq writeroom-border-width 100)
  ;; ;; その際以下の設定が必要
  ;; (push 'writeroom-toggle-internal-border-width
  ;;       writeroom-global-effects)
  (setq writeroom-toggle-mode-line t)

 ;; python-mode で jedi による自動補完
  (add-hook 'python-mode-hook '(lambda ()
                                 (jedi:setup)
                                 (setq flycheck-checker 'python-pylint)))

  ;; git-gutter
  (setq git-gutter:added-sign "|")
  (setq git-gutter:deleted-sign "|")
  (setq git-gutter:modified-sign "|")
  (set-face-foreground 'git-gutter:added  "green")
  (set-face-foreground 'git-gutter:deleted  "red")
  (set-face-foreground 'git-gutter:modified "DeepSkyBlue")

  ;; auth-source
  ;; simple note
  (require 'simplenote2)
  (setq simplenote2-email nil)
  (setq simplenote2-password nil)
  (add-hook 'simplenote2-create-note-hook
            (lambda ()
              (simplenote2-set-markdown)
              ;; (simplenote2-add-tag "note")
              ))
  (simplenote2-setup)

  ;; open junk file
  (use-package open-junk-file :ensure t
    :init (setq open-junk-file-format "~/.tmp/junk/%Y/%m/%Y-%m-%d-%H%M%S.")
    :bind ("C-x j" . open-junk-file))

  ;; ediff
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq ediff-split-window-function 'split-window-horizontally)

  (setq pangu-spacing-real-insert-separtor nil)



  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   '(anaphora quickrun impatient-mode codic all-the-icons-dired all-the-icons memoize ace-isearch unicode-escape request-deferred names simplenote2 olivetti tabula-rasa jedi jedi-core python-environment epc ctable concurrent visual-fill-column writeroom-mode org-re-reveal csv-mode company-auctex auctex-latexmk auctex pangu-spacing japanese-holidays evil-tutor-ja ddskk cdb ccc avy-migemo migemo ein polymode deferred websocket reveal-in-osx-finder ox-reveal company-emacs-eclim eclim pdf-tools tablist lv ox-gfm sql-indent engine-mode typit mmt sudoku pacmacs 2048-game yasnippet-snippets org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download htmlize gnuplot unfill mwim rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv rake minitest chruby bundler inf-ruby mmm-mode markdown-toc markdown-mode gh-md git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter diff-hl yapfify pyvenv pytest pyenv-mode py-isort pip-requirements live-py-mode hy-mode helm-pydoc cython-mode company-anaconda anaconda-mode pythonic web-mode tagedit slim-mode scss-mode sass-mode pug-mode less-css-mode helm-css-scss haml-mode emmet-mode company-web web-completion-data vimrc-mode dactyl-mode xterm-color smeargle shell-pop orgit multi-term magit-gitflow magit-popup helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link evil-magit magit transient git-commit with-editor eshell-z eshell-prompt-extras esh-help phpunit phpcbf php-extras php-auto-yasnippets drupal-mode php-mode helm-company helm-c-yasnippet fzf fuzzy flyspell-correct-helm flyspell-correct flycheck-pos-tip pos-tip flycheck company-tern dash-functional tern company-statistics company auto-yasnippet auto-dictionary ac-ispell auto-complete web-beautify livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor yasnippet multiple-cursors js2-mode js-doc coffee-mode helm-ext ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-projectile projectile pkg-info epl helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist highlight evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu elisp-slime-nav dumb-jump f dash s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(web-mode-comment-face ((t (:foreground "#D9333F"))))
 '(web-mode-css-at-rule-face ((t (:foreground "#FF7F00"))))
 '(web-mode-css-pseudo-class-face ((t (:foreground "#FF7F00"))))
 '(web-mode-css-rule-face ((t (:foreground "#A0D8EF"))))
 '(web-mode-doctype-face ((t (:foreground "#82AE46"))))
 '(web-mode-html-attr-name-face ((t (:foreground "#C97586"))))
 '(web-mode-html-attr-value-face ((t (:foreground "#82AE46"))))
 '(web-mode-html-tag-face ((t (:foreground "#E6B422" :weight bold))))
 '(web-mode-server-comment-face ((t (:foreground "#D9333F")))))
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yaml-mode anaphora quickrun impatient-mode codic all-the-icons-dired all-the-icons memoize ace-isearch unicode-escape request-deferred names simplenote2 olivetti tabula-rasa jedi jedi-core python-environment epc ctable concurrent visual-fill-column writeroom-mode org-re-reveal csv-mode company-auctex auctex-latexmk auctex pangu-spacing japanese-holidays evil-tutor-ja ddskk cdb ccc avy-migemo migemo ein polymode deferred websocket reveal-in-osx-finder ox-reveal company-emacs-eclim eclim pdf-tools tablist lv ox-gfm sql-indent engine-mode typit mmt sudoku pacmacs 2048-game yasnippet-snippets org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download htmlize gnuplot unfill mwim rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv rake minitest chruby bundler inf-ruby mmm-mode markdown-toc markdown-mode gh-md git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter diff-hl yapfify pyvenv pytest pyenv-mode py-isort pip-requirements live-py-mode hy-mode helm-pydoc cython-mode company-anaconda anaconda-mode pythonic web-mode tagedit slim-mode scss-mode sass-mode pug-mode less-css-mode helm-css-scss haml-mode emmet-mode company-web web-completion-data vimrc-mode dactyl-mode xterm-color smeargle shell-pop orgit multi-term magit-gitflow magit-popup helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link evil-magit magit transient git-commit with-editor eshell-z eshell-prompt-extras esh-help phpunit phpcbf php-extras php-auto-yasnippets drupal-mode php-mode helm-company helm-c-yasnippet fzf fuzzy flyspell-correct-helm flyspell-correct flycheck-pos-tip pos-tip flycheck company-tern dash-functional tern company-statistics company auto-yasnippet auto-dictionary ac-ispell auto-complete web-beautify livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor yasnippet multiple-cursors js2-mode js-doc coffee-mode helm-ext ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-projectile projectile pkg-info epl helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist highlight evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu elisp-slime-nav dumb-jump f dash s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(web-mode-comment-face ((t (:foreground "#D9333F"))))
 '(web-mode-css-at-rule-face ((t (:foreground "#FF7F00"))))
 '(web-mode-css-pseudo-class-face ((t (:foreground "#FF7F00"))))
 '(web-mode-css-rule-face ((t (:foreground "#A0D8EF"))))
 '(web-mode-doctype-face ((t (:foreground "#82AE46"))))
 '(web-mode-html-attr-name-face ((t (:foreground "#C97586"))))
 '(web-mode-html-attr-value-face ((t (:foreground "#82AE46"))))
 '(web-mode-html-tag-face ((t (:foreground "#E6B422" :weight bold))))
 '(web-mode-server-comment-face ((t (:foreground "#D9333F")))))
)
