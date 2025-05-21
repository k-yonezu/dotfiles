# edit /etc/wsl.conf

```
sudo vim /etc/wsl.conf
```

```
[interop]
appendWindowsPath=false
```

# custumize zsh

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

edit .zshrc
```
ZSH_THEME="powerlevel10k/powerlevel10k"
```

# git clone dot file

```
git clone https://github.com/k-yonezu/dotfiles.git
cp ~/dotfiles/terminal/dot_zshrc ~/.zshrc
cp ~/dotfiles/terminal/dot_p10k.zsh ~/.p10k.zsh
cp ~/dotfiles/vim/dot_vimrc ~/.vimrc
cp ~/dotfiles/dot_gitconfig ~/.gitconfig
```


