# install vim

```
sudo apt update
sudo apt install -y vim
echo export EDITOR=vim >> ~/.zprofile
echo export SUDO_EDITOR=vim >> ~/.zprofile
sudo update-alternatives --config editor
```

# install zsh

```
echo $SHELL
sudo apt install -y zsh
cat /etc/shells
chsh -s /bin/zsh
echo $SHELL
```

# install git

```
sudo apt install -y git
```

# install eza

```
sudo apt install -y eza
```

# install fzf

```
sudo apt install -y fzf
```


