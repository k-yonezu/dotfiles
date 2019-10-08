mkdir -p $HOME/local/src
cd $HOME/local/src
wget 'https://github.com/tmux/tmux/releases/download/2.8/tmux-2.8.tar.gz'
tar xzf tmux-2.8.tar.gz
cd tmux-2.8
./configure --prefix=$HOME/local/
make
make install
