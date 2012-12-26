#Scala Syntax Support for Vim
#Chu Shao
#Fixes a small problem of carriage return that original plugin had a problme with
#Original Plugin at https://github.com/derekwyatt/vim-scala
clear
echo "Installing scala syntax for vim"

cd ~/
mkdir .vim
cd .vim
mkdir syntax
mkdir indent
mkdir ftdetect
curl -O https://dl.dropbox.com/u/7370140/scala/syntax-scala.vim
curl -O https://dl.dropbox.com/u/7370140/scala/indent-scala.vim
curl -O https://dl.dropbox.com/u/7370140/scala/ftdetect-scala.vim
mv syntax-scala.vim ./syntax/scala.vim
mv indent-scala.vim ./indent/scala.vim
mv ftdetect-scala.vim ./ftdetect/scala.vim

echo "Installation Successful"
