#!/bin/bash
# InstallVIMRC.sh
# June 1st 2013
# By Chu Shao
# 
# This script was intended to install a simple vimrc file 
# The vimRC is a modification of Lisa McCutcheon's file
# http://lmccutch.org/configs/ieng9/.vimrc

clear
echo "Installing vimrc..."

cd ~/
curl https://gist.github.com/chushao/5689568/raw/20a4c4ec96fed5e054644201dc0ed01a4c971141/gistfile1.txt -o "vimrc"
mv .vimrc .vimrc.bak
mv vimrc .vimrc
chmod 755 .vimrc
echo "Done Installing vimrc! Open up your vim/gvim to check!"
