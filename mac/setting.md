# macOS 開発環境セットアップ手順, 設定手順

## custumize zsh

install powerlevel10k

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

edit .zshrc

```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```

---

## git clone dot file

```bash
git clone https://github.com/k-yonezu/dotfiles.git
cp ~/dotfiles/terminal/dot_zshrc ~/.zshrc
cp ~/dotfiles/terminal/dot_p10k.zsh ~/.p10k.zsh
cp ~/dotfiles/vim/dot_vimrc ~/.vimrc
cp ~/dotfiles/dot_gitconfig ~/.gitconfig
```
