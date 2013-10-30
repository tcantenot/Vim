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
git clone git@github.com:tcantenot/vim.git .

echo -e "\nCreating $BUNDLE_DIR directory\n"
if [ ! -d "$BUNDLE_DIR" ]; then
mkdir $BUNDLE_DIR
fi

# Install plugins from git depositories
echo -e "\nInstall plugins from git depositories\n"

git submodule add git://github.com/docunext/closetag.vim.git $BUNDLE_DIR/CloseTag
git submodule init && git submodule update

git submodule add git://git.wincent.com/command-t.git $BUNDLE_DIR/CommandT
git submodule init && git submodule update

git submodule add git://github.com/Twinside/vim-cuteErrorMarker.git $BUNDLE_DIR/CuteErrorMarker
git submodule init && git submodule update

git submodule add git://github.com/vim-scripts/errormarker.vim.git $BUNDLE_DIR/ErrorMarker
git submodule init && git submodule update

git submodule add git://github.com/derekwyatt/vim-fswitch.git $BUNDLE_DIR/FSwitch
git submodule init && git submodule update

git submodule add git://github.com/tpope/vim-fugitive.git $BUNDLE_DIR/Fugitive
git submodule init && git submodule update

git submodule add git://github.com/vim-scripts/FuzzyFinder.git $BUNDLE_DIR/FuzzyFinder
git submodule init && git submodule update

git submodule add git://github.com/vim-scripts/L9.git $BUNDLE_DIR/L9
git submodule init && git submodule update

git submodule add git://github.com/scrooloose/nerdcommenter.git $BUNDLE_DIR/NerdCommenter
git submodule init && git submodule update

git submodule add git://github.com/scrooloose/nerdtree.git $BUNDLE_DIR/NerdTree
git submodule init && git submodule update

git submodule add https://github.com/adimit/prolog.vim.git $BUNDLE_DIR/Prolog
git submodule init && git submodule update

git submodule add git://github.com/vim-scripts/ScrollColors.git $BUNDLE_DIR/ScrollColors
git submodule init && git submodule update

git submodule add git://github.com/msanders/snipmate.vim.git $BUNDLE_DIR/SnipMate
git submodule init && git submodule update

git submodule add git://github.com/ervandew/supertab.git $BUNDLE_DIR/SuperTab
git submodule init && git submodule update

git submodule add git://github.com/tpope/vim-surround.git $BUNDLE_DIR/Surround
git submodule init && git submodule update

git submodule add git://github.com/scrooloose/syntastic.git $BUNDLE_DIR/Syntastic
git submodule init && git submodule update

git submodule add git://github.com/majutsushi/tagbar.git $BUNDLE_DIR/TagBar
git submodule init && git submodule update

git submodule add git://github.com/bronson/vim-visual-star-search.git $BUNDLE_DIR/VisualStarSearch
git submodule init && git submodule update

git submodule add git://github.com/g3orge/vim-voogle.git $BUNDLE_DIR/Voogle
git submodule init && git submodule update

git submodule add git://github.com/Valloric/YouCompleteMe.git $BUNDLE_DIR/YouCompleteMe
git submodule init && git submodule update

cd $VIM_DIR/$BUNDLE_DIR/YouCompleteMe \
&& git submodule --init --recursive \

echo -e "\n Building YouCompleteMe plugin\n"
mkdir ycm_build && cd ycm_build \
&& cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON $VIM_DIR/$BUNDLE_DIR/YouCompleteMe/cpp \
make \
&& cd .. && rm -rf ./ycm_build

echo -e "\nMoving to $VIM_DIR\n"
cd $VIM_DIR

echo -e "\nUpdating all plugins\n"
git submodule foreach --recursive git pull origin master

echo "Creating symlink $VIM_DIR/vimrc -> ~/.vimrc"
if [ ! -h "./.vimrc" ]; then
    ln -s $VIM_DIR/vimrc ~/.vimrc
fi
