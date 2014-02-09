Vim Plugins
===========

## Installation
    Download vim_config_install.sh

    chmod +x ./vim_config_install.sh
    ./vim_config_install.sh
___

## How To Update
    git submodule foreach --recursive git pull origin master
___


Airline
--------
### Installation
    git submodule add git@github.com:bling/vim-airline.git ./bundle/Airline
    git submodule init && git submodule update

CloseTag
--------
#### Installation
	git submodule add git://github.com/docunext/closetag.vim.git ./bundle/CloseTag
    git submodule init && git submodule update

CommandT
--------
#### Installation
	git submodule add git://git.wincent.com/command-t.git ./bundle/CommandT
    git submodule init && git submodule update

CuteErrorMarker
---------------
#### Installation
	git submodule add git://github.com/Twinside/vim-cuteErrorMarker.git ./bundle/CuteErrorMarker
    git submodule init && git submodule update

ErrorMarker
-----------
#### Installation
	git submodule add git://github.com/vim-scripts/errormarker.vim.git ./bundle/ErrorMarker
    git submodule init && git submodule update

FSwitch
-------
#### Installation
	git submodule add git://github.com/derekwyatt/vim-fswitch.git ./bundle/FSwitch
    git submodule init && git submodule update

Fugitive
--------
#### Installation
	git submodule add git://github.com/tpope/vim-fugitive.git ./bundle/Fugitive
    git submodule init && git submodule update

### Use Fugitive as Git mergetool
    git config --global mergetool.fugitive.cmd 'vim -f -c "Gdiff" "$MERGED"'
    git config --global merge.tool fugitive

FuzzyFinder
-----------
#### Requirements
    FuzzyFinder requires the L9 library
#### Installation
	git submodule add git://github.com/vim-scripts/FuzzyFinder.git ./bundle/FuzzyFinder
    git submodule init && git submodule update

L9
--
#### Installation
	git submodule add git://github.com/vim-scripts/L9.git ./bundle/L9
    git submodule init && git submodule update

Jedi
--
#### Installation
	git submodule add git@github.com:davidhalter/jedi-vim.git ./bundle/Jedi
    git submodule init && git submodule update


NerdCommenter
-------------
#### Installation
	git submodule add git://github.com/scrooloose/nerdcommenter.git ./bundle/NerdCommenter
    git submodule init && git submodule update

NerdTree
--------
#### Installation
	git submodule add git://github.com/scrooloose/nerdtree.git ./bundle/NerdTree
    git submodule init && git submodule update

Prolog
--------
#### Installation
	git submodule add https://github.com/adimit/prolog.vim.git ./bundle/Prolog
    git submodule init && git submodule update

ScrollColors
------------
#### Installation
	git submodule add git://github.com/vim-scripts/ScrollColors.git ./bundle/ScrollColors
    git submodule init && git submodule update

SnipMate
--------
#### Installation
	git submodule add git://github.com/msanders/snipmate.vim.git ./bundle/Snipmate
    git submodule init && git submodule update

SuperTab
--------
#### Installation
	git submodule add git://github.com/ervandew/supertab.git ./bundle/SuperTab
    git submodule init && git submodule update

Surround
--------
#### Installation
	git submodule add git://github.com/tpope/vim-surround.git ./bundle/Surround
    git submodule init && git submodule update

Syntastic
---------
#### Installation
	git submodule add git://github.com/scrooloose/syntastic.git ./bundle/Syntastic
    git submodule init && git submodule update

TagBar
------
#### Installation
	git submodule add git://github.com/majutsushi/tagbar.git ./bundle/TagBar
    git submodule init && git submodule update

Visual Star Search
------------------
#### Installation
	git submodule add git://github.com/bronson/vim-visual-star-search.git ./bundle/VisualStarSearch
    git submodule init && git submodule update

Voogle
------
#### Installation
	git submodule add git://github.com/g3orge/vim-voogle.git ./bundle/Voogle
    git submodule init && git submodule update

YouCompleteMe
-------------
#### Requirements
    sudo add-apt-repository ppa:kxstudio-team/builds
    sudo apt-get update
    sudo apt-get install libclang-dev cmake
#### Installation
    git submodule add git://github.com/Valloric/YouCompleteMe.git ./bundle/YouCompleteMe
    git submodule init && git submodule update
    cd ./bundle/YouCompleteMe \
    && mkdir ycm_build && cd ycm_build \
    && cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON ~/.vim/bundle/YouCompleteMe/cpp \
    && make \
    && cd .. && rm -rf ./ycm_build

