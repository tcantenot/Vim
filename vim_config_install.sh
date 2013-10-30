#!/bin/bash

# Prerequisites
echo -e "\nPrerequisites\n"

sudo apt-get install git build-essential cmake python-dev
sudo add-apt-repository ppa:kxstudio-team/builds
sudo apt-get update
sudo apt-get install libclang-dev

VIM_DIR=~/Config/Vim
SYM_LINK_VIM_DIR=~/.vim
BUNDLE_DIR=bundle

if [ ! -d "$VIM_DIR" ]; then
echo -e "\nCreating vim folder ($VIM_DIR)\n"
    mkdir -p $VIM_DIR
fi

if [ ! -h "$SYM_LINK_VIM_DIR" ]; then
    echo -e "\nCreating symlink $SYM_LINK_VIM_DIR -> $VIM_DIR\n"
    ln -s $VIM_DIR $SYM_LINK_VIM_DIR
fi

echo -e "\nMoving into $VIM_DIR\n"
cd $VIM_DIR

echo -e "\nCloning git repository\n"
git clone git@github.com:tcantenot/Vim.git .

if [ ! -d "$BUNDLE_DIR" ]; then
    echo -e "\nCreating $BUNDLE_DIR directory\n"
    mkdir $BUNDLE_DIR
fi

# Install plugins from git depositories
echo -e "\nInstall plugins from git depositories\n"

cd $VIM_DIR/$BUNDLE_DIR

for d in $(find . -mindepth 1 -maxdepth 1 -type d)
do
    echo -e "\nInit and update $d\n"
    cd $d && git submodule update --init && cd ..
done 

# Compile YouCompleteMe plugin
echo -e "\n Building YouCompleteMe plugin\n"

cd $VIM_DIR/$BUNDLE_DIR/YouCompleteMe \
&& mkdir ycm_build && cd ycm_build \
&& cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON $VIM_DIR/$BUNDLE_DIR/YouCompleteMe/cpp \
&& make \
&& cd .. && rm -rf ./ycm_build


# Update recursively all plugins

echo -e "\nMoving to $VIM_DIR\n"
cd $VIM_DIR

echo -e "\nUpdating all plugins\n"
git submodule foreach --recursive git pull origin master

if [ ! -h "./.vimrc" ]; then
    echo "Creating symlink $VIM_DIR/vimrc -> ~/.vimrc"
    ln -s $VIM_DIR/vimrc ~/.vimrc
fi

