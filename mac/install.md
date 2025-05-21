# macOS 開発環境セットアップ, install手順

## Homebrew のインストール（最初に実行）

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 環境設定の追加

#### Apple Silicon (M1/M2/M3 など)

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

#### Intel Mac

```bash
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/usr/local/bin/brew shellenv)"
```

---

## Vim のインストールと設定

```bash
brew install vim
echo 'export EDITOR=vim' >> ~/.zprofile
echo 'export SUDO_EDITOR=vim' >> ~/.zprofile
```

---

## Zsh のインストールとデフォルト設定

macOS には Zsh が標準搭載されていますが、最新バージョンが必要な場合は以下を使用します：

```bash
brew install zsh
```

Zsh をログインシェルとして設定：

```bash
which zsh | sudo tee -a /etc/shells
chsh -s "$(which zsh)"
```

シェルの確認：

```bash
echo $SHELL
```

---

## Git のインストール

```bash
brew install git
```

---

## eza のインストール（`ls` の代替）

```bash
brew install eza
```

---

## fzf のインストール（インタラクティブ検索）

```bash
brew install fzf
$(brew --prefix)/opt/fzf/install
```

---
