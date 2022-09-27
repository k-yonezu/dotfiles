mkdir -p $HOME/local/src
cd $HOME/local/src
git clone https://github.com/ggreer/the_silver_searcher
cd the_silver_searcher
aclocal && autoconf && autoheader && automake --add-missing
sed -i -e 's/configure/configure --prefix=\$HOME\/local/g' build.sh
./build.sh
make install
