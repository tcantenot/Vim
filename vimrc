"----------------------------------------------------------------------
" Author:
"       Thierry CANTENOT
"
" Version:
"       2.0 - 10/02/2014
"
" Sections:
"       - General
"       - User interface
"       - Colorscheme
"       - Text & Bloc : Indenting, Folding
"       - Moves
"       - Searching
"       - Mapping & Shorcuts
"       - Autocompletion
"       - Syntax
"       - Compilation
"       - Plugins configuration
"
"----------------------------------------------------------------------


"----------------------------------------------------------------------
" #General
"----------------------------------------------------------------------
" Pathogen

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []

" Avoid conflict with vi
set nocompatible

" Sets how many lines of history Vim has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

" Remove Vim's startup message
set shortmess+=I

" Set mapleader (shortcut key) to ","
let mapleader = ","
let g:mapleader = ","

" Turn backup off
set nobackup
set nowb
set noswapfile

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"----------------------------------------------------------------------
" #User interface
"----------------------------------------------------------------------

" Display line numbers
set number

" Show the cursor line
set cursorline

" Show the cursor line
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn
"set cursorline cursorcolumn

" Scroll page when cursor is x lines away from an edge
set scrolloff=5

" Show the cursor position all the time
set ruler

" Display the current mode
set showmode

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" Show matching brackets/parenthesis
set showmatch
set matchpairs+=<:> "add < > to SHIFT+%

" Deactivate mouse
set mouse=
set mousehide

" Display status line
if has('statusline')
    set laststatus=2

    "Broken down into easily includeable segments
    set statusline=%<%f\   " Filename
    "set statusline+=%w%h%m%r " Options
    "set statusline+=\[%{&ff}/%Y]  " Filetype
    set statusline+=\[%{getcwd()}] " Current dir
    set statusline+=%{fugitive#statusline()} " Git Hotness
    " Right aligned file nav info
    set statusline+=%=%-14.(Line:%l/%L\ [%p%%]\ Col:%v\ [%b][0x%B]%)
endif

" Change interface
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar

"----------------------------------------------------------------------
" # Colorscheme
"----------------------------------------------------------------------

" Set color mode to 256
set t_Co=256

" Colorscheme choice

let g:molokai_original=1
colorscheme molokai "obsidian2 gentooish liquidcarbon kellys

"set background=dark
"let g:solarized_termtrans=1
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"
"colorscheme solarized


"----------------------------------------------------------------------
" # Text & Bloc : Indenting, Folding
"----------------------------------------------------------------------

" Set font
set guifont=Inconsolata\ For\ Powerline\ 12
"set guifont=Monospace\ 10

" Activate indenting
filetype indent plugin on

" Replace tabulation with spaces
set expandtab

" Set tabulation indenting width
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Indent mode
set autoindent
set smartindent
set wrap

" Fold settings

" Function auto-folding
function! FoldFunction()
    let line = getline(v:foldstart)
    let sub = substitute(line,'/\*\|\*/\|^\s+', '', 'g')
    let lines = v:foldend - v:foldstart + 1
    return v:folddashes.sub.'...'.lines.' Lines...'.getline(v:foldend)
endfunction

set foldmethod=syntax          " Functions and blocs auto-folding
set foldtext=FoldFunction()    " Use FoldFunction (optionnal)
set nofoldenable               " Do not fold everything
set foldnestmax=10             " Max number of fold levels
set foldlevel=0                " Folding parent levels


"----------------------------------------------------------------------
" # Moves
"----------------------------------------------------------------------

" Remove arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Switch tabs quickly
nmap <C-S-tab> :tabprevious<cr>
nmap <C-tab> :tabnext<cr>

" Useful mappings for managing tabs
nmap <leader>tn :tabnew<cr>
nmap <leader>to :tabonly<cr>
nmap <leader>tc :tabclose<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
nmap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
nmap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Close buffer without closing window
nmap <silent> <leader>bd :bd<cr>

" Return to last edit position when opening files
if has("autocmd")
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
endif

" Move a line of text using ALT+[jk]
nnoremap <M-j> :m .+1<cr>==
nnoremap <M-k> :m .-2<cr>==
inoremap <M-j> <Esc>:m .+1<cr>==gi
inoremap <M-k> <Esc>:m .-2<cr>==gi
vnoremap <M-j> :m '>+1<cr>gv=gv
vnoremap <M-k> :m '<-2<cr>gv=gv


" Show numbering (absolute / relative)
function! ToggleRelativeNumber()
    if &relativenumber
        set norelativenumber
        set number
    else
        set nonumber
        set relativenumber
    endif
endfunc

" Toggle between absolute / relative line numbering
nmap <leader>n :call ToggleRelativeNumber()<cr>
vmap <leader>n :call ToggleRelativeNumber()<cr>gv


"----------------------------------------------------------------------
" # Searching
"----------------------------------------------------------------------

" Highlight search results
set hlsearch

"Show results while typing
set incsearch

"Case sensitive
set ignorecase
set smartcase

" Center screen at cursor
nnoremap n nzz
nnoremap N Nzz
nnoremap } }zz

" Disable highlight when <leader><leader> is pressed
nmap <silent> <leader><leader> :noh<cr>

" Find current word in new window
nmap <leader>sw :let @/=expand("<cword>")<bar>split<bar>normal n<cr>
nmap <leader>sW :let @/='\<'.expand("<cword>").'\>'<bar>split<bar>normal n<cr>

" Quick search-replace
nnoremap <leader>sr :%s/\<<C-r><C-w>\>//g<left><left>


"----------------------------------------------------------------------
" # Mapping & Shorcuts
"----------------------------------------------------------------------

" Remap Vim 0 to first non-blank character
nmap 0 ^

" Map "²" to "~" (quicker), and don't go forward one character
nmap ² ~h

" Resolve inconsistency between "Y" (line) and "D" (til end of line)
nmap Y y$

" Visual block indenting: keep selection after indenting
vmap > >gv
vmap < <gv

" Fast saving
nnoremap <leader>w :w<cr>
nnoremap <leader>wa :wa<cr>

" Close current file
nmap <leader>q :q<cr>

" Remove the ugly Windows "^M"
nmap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Edit / Source configuration
nmap <silent> <leader>co :e $MYVIMRC<cr>
nmap <silent> <leader>so :so $MYVIMRC<cr>

" Show tab
set showtabline=2

"Move between tabs
map <silent> ² :tabn<CR>
map <silent> ~ :tabp<CR>

"Move betwwen splits
map <silent> <Tab> <C-W>w
map <silent> <S-Tab> <C-W>W

"New right empty vertical split
set splitright
map <silent> <leader>v :vnew<CR>
set splitbelow
map <silent> <leader>V :new<CR>

" Close all splits except the current one
map <silent> <leader>o <C-W>o

" Move split
map <silent> <leader>h <C-W>H
map <silent> <leader>j <C-W>J
map <silent> <leader>k <C-W>K
map <silent> <leader>l <C-W>L

" Copy to/Paste from external buffer
map <silent> <leader>eby "+y
map <silent> <leader>ebY "+Y
map <silent> <leader>ebp "+p
map <silent> <leader>ebP "+P

nnoremap <silent> <F5> :e<cr>

"----------------------------------------------------------------------
" # Autocompletion
"----------------------------------------------------------------------

" Default completing function
"set omnifunc=syntaxcomplete#Complete

" Show menu
set wildmenu

" Show all possibilities
set wildmode=list:longest,list:full

" Ignore some filetypes for includes completion
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz,*.pyc,*.gch,*~

"Shorcuts
iab #i #include

"Spell checker

" Toggle spell-checking
nmap <leader>ss :setlocal spell!<cr>

"set  spell
"set spelllang=en,fr
"set spellsuggest=5

" Tags
set tags=./tags/

"----------------------------------------------------------------------
" # Syntax
"----------------------------------------------------------------------

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

if has("autocmd")

    " Makefile
    autocmd FileType make setl noexpandtab

    " Tab
    autocmd Filetype html  setlocal ts=2 sts=2 sw=2
    autocmd Filetype xml   setlocal ts=2 sts=2 sw=2
    autocmd Filetype eruby setlocal ts=2 sts=2 sw=2
    autocmd Filetype ruby  setlocal ts=2 sts=2 sw=2
    autocmd Filetype js    setlocal ts=2 sts=2 sw=2
    autocmd Filetype yaml  setlocal ts=2 sts=2 sw=2

    " C / C++
    autocmd BufNewFile,BufRead,BufEnter *.c setl filetype=c
    autocmd BufNewFile,BufRead,BufEnter *.h,*.cpp,*.hpp,*.inl setl filetype=cpp

    " JSON / JavaScript
    autocmd BufNewFile,BufRead *.json set filetype=javascript

    " Pascal
    autocmd BufNewFile,BufRead *.pas,*.PAS set filetype=pascal

    " Markdown
    autocmd BufNewFile,BufRead *.md set filetype=markdown

    " Python
    "autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()<CR>

    " GLSL
    autocmd BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl,*.vtx,*.frg,*.vs,*.fs,*.gs set filetype=glsl

    " HLSL
    autocmd BufNewFile,BufRead *.fx,*.fxc,*.fxh,*.hlsl set ft=hlsl

    " Prolog
    autocmd BufNewFile,BufRead *.pl set filetype=prolog

    " Rules
    autocmd BufNewFile,BufRead *.rl set filetype=lisp

    " LaTex
    "autocmd FileType tex

endif

nnoremap <silent> <F6> :call <SID>StripTrailingWhitespaces()<CR>

"----------------------------------------------------------------------
" # Compilation
"----------------------------------------------------------------------

" Quick make command
map <F8> :wa<cr> :make<cr> :cw<cr>
map <F9> :wa<cr> :make clear<cr> :make<cr> :cw<cr>

nnoremap <leader>cw :call QuickfixToggle()<cr>

" Toggle quickfix window
let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction


"----------------------------------------------------------------------
" # Plugins configuration
"----------------------------------------------------------------------

filetype plugin on

"----------------------------------------------------------------------
"OmniCppComplete


"Configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/stl
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4
set tags+=~/.vim/tags/sfml

"Build tags of your own project with CTRL+F12
"Map <C-F12> :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>
"noremap <F12> :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .<cr>
"inoremap <F12> <Esc>:!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .<cr>
map <F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<cr>

"Map <C-Space> for Omnicompletion
"inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
            "\ "\<lt>C-n>" :
            "\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
            "\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            "\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
"imap <C-@> <C-Space>

"" OmniCppComplete
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1     "show function parameters
"let OmniCpp_MayCompleteDot = 1          "autocomplete after .
"let OmniCpp_MayCompleteArrow = 1        "autocomplete after ->
"let OmniCpp_MayCompleteScope = 1        "autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

"" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview


"----------------------------------------------------------------------
"SuperTab

"Allow SuperTab to use OmniComplete
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']


"----------------------------------------------------------------------
" Fugitive

nmap <silent> <leader>gs  :Gstatus<cr>
nmap <silent> <leader>gd  :Gdiff<cr>
nmap <silent> <leader>gl  :Glog<cr>
nmap <silent> <leader>gc  :Gcommit<cr>
nmap <silent> <leader>gw  :Gwrite<cr>
nmap <silent> <leader>gpl :Git pull<cr>
nmap <silent> <leader>gps :Git push<cr>
nmap <silent> <leader>gb  :Gblame<cr>
nmap <silent> <leader>gr  :Gread<cr>
if has("autocmd")
    "Each time you leave a fugitive buffer, it will be closed automatically
    autocmd BufReadPost fugitive://* set bufhidden=delete
end

"----------------------------------------------------------------------
" NerdTree

map <silent> <F3> :NERDTreeToggle<cr>
imap <silent> <F3> <C-o><F3><cr>


"----------------------------------------------------------------------
" TagBar

let g:tagbar_usearrows = 0
map <leader><Tab> :TagbarToggle<CR>
map <F4> :TagbarToggle<CR>


"----------------------------------------------------------------------
" FSwitch

map <leader>fsh :FSSplitLeft<CR>
map <leader>fsj :FSSplitBelow<CR>
map <leader>fsk :FSSplitAbove<CR>
map <leader>fsl :FSSplitRight<CR>


"----------------------------------------------------------------------
" CommandT

noremap <leader>t :CommandT<CR>
noremap <leader>T <Esc>:CommandTFlush<CR>
noremap <leader>O <Esc>:CommandTBuffer<CR>

"----------------------------------------------------------------------
" CuteErrorMarker

map <leader>en :cnext<CR>
map <leader>ep :cprevious<CR>

"----------------------------------------------------------------------
" FuzzyFinder

let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400
nnoremap <silent> sj     :FufBuffer<CR>
nnoremap <silent> sk     :FufFileWithCurrentBufferDir<CR>ù
nnoremap <silent> sK     :FufFileWithFullCwd<CR>
nnoremap <silent> s<C-k> :FufFile<CR>
nnoremap <silent> sl     :FufCoverageFileChange<CR>
nnoremap <silent> sL     :FufCoverageFileChange<CR>
nnoremap <silent> s<C-l> :FufCoverageFileRegister<CR>
nnoremap <silent> sd     :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> sD     :FufDirWithFullCwd<CR>
nnoremap <silent> s<C-d> :FufDir<CR>
nnoremap <silent> sn     :FufMruFile<CR>
nnoremap <silent> sN     :FufMruFileInCwd<CR>
nnoremap <silent> sm     :FufMruCmd<CR>
nnoremap <silent> su     :FufBookmarkFile<CR>
nnoremap <silent> s<C-u> :FufBookmarkFileAdd<CR>
vnoremap <silent> s<C-u> :FufBookmarkFileAddAsSelectedText<CR>
nnoremap <silent> si     :FufBookmarkDir<CR>
nnoremap <silent> s<C-i> :FufBookmarkDirAdd<CR>
nnoremap <silent> st     :FufTag<CR>
nnoremap <silent> sT     :FufTag!<CR>
nnoremap <silent> s<C-]> :FufTagWithCursorWord!<CR>
nnoremap <silent> s,     :FufBufferTag<CR>
nnoremap <silent> s<     :FufBufferTag!<CR>
vnoremap <silent> s,     :FufBufferTagWithSelectedText!<CR>
vnoremap <silent> s<     :FufBufferTagWithSelectedText<CR>
nnoremap <silent> s}     :FufBufferTagWithCursorWord!<CR>
nnoremap <silent> s.     :FufBufferTagAll<CR>
nnoremap <silent> s>     :FufBufferTagAll!<CR>
vnoremap <silent> s.     :FufBufferTagAllWithSelectedText!<CR>
vnoremap <silent> s>     :FufBufferTagAllWithSelectedText<CR>
nnoremap <silent> s]     :FufBufferTagAllWithCursorWord!<CR>
nnoremap <silent> sg     :FufTaggedFile<CR>
nnoremap <silent> sG     :FufTaggedFile!<CR>
nnoremap <silent> so     :FufJumpList<CR>
nnoremap <silent> sp     :FufChangeList<CR>
nnoremap <silent> sq     :FufQuickfix<CR>
nnoremap <silent> sy     :FufLine<CR>
nnoremap <silent> sh     :FufHelp<CR>
nnoremap <silent> se     :FufEditDataFile<CR>
nnoremap <silent> sr     :FufRenewCache<CR>
nnoremap          s      <nop>
nnoremap <silent> ss     :FufFileWithCurrentBufferDir **/<CR>

"----------------------------------------------------------------------
" Syntastic
"let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

"----------------------------------------------------------------------
" YouCompleteMe

nnoremap <F2> :YcmForceCompileAndDiagnostics<CR>
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.my_ycm_extra_conf.py'

let g:ycm_filetype_whitelist = { 'c': 1, 'cpp': 1, 'h': 1, 'hpp': 1, 'inl': 1 }

let g:syntastic_c_config_file="vim_syntax"
let g:syntastic_cpp_config_file="vim_syntax"
let g:syntastic_cpp_check_header = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_register_as_syntastic_checker = 1
"let g:SuperTabDefaultCompletionType = '<Tab>'

nnoremap <silent> <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

set completefunc=youcompleteme#Complete
set omnifunc=youcompleteme#OmniComplete

"----------------------------------------------------------------------
" CloseTag

autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/CloseTag/plugin/closetag.vim

"----------------------------------------------------------------------
" Doxygen

"let g:load_doxygen_syntax = 1

" See: http://choorucode.com/2013/07/12/how-to-install-and-use-the-vim-airline-plugin-for-vim/
"----------------------------------------------------------------------
" Airline
let g:airline_theme             = 'powerlineish'
let g:airline_powerline_fonts   = 1
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
