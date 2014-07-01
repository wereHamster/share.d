set fdm=marker

" Welcome to the 21st century! {{{
set modelines=0       " Disable modelines due to security concerns.
set nocompatible      " And enable all the modern features of vim.
" }}}
" Vundle {{{
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'airblade/vim-gitgutter'
Bundle 'chriskempson/base16-vim'
Bundle 'digitaltoad/vim-jade'
Bundle 'ervandew/supertab'
Bundle 'gmarik/vundle'
Bundle 'godlygeek/tabular'
Bundle 'groenewege/vim-less'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'leafgarland/typescript-vim'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'rodjek/vim-puppet'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'wavded/vim-stylus'
" }}}

" I want complete filetype detection!
filetype plugin indent on

" Sweet sweet syntax highlighting.
syntax on

" Colorscheme {{{
" Use a pretty color scheme.
set background=dark
colorscheme base16-ocean
" }}}

" Random collection of settings which I don't know what they do. Keep it
" sorted so we can better see if an option is enabled.
set autoindent
set autowrite
set backspace=indent,eol,start
set cpoptions+=J
set cursorline
set encoding=utf-8
set fillchars=diff:\ 
set hidden
set history=1000
set laststatus=2
set lazyredraw
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set matchtime=3
set nonumber
set undofile
set undoreload=10000
set ruler
set norelativenumber
set showbreak=↪
set shiftround
set shell=/bin/bash
set showmode
set showcmd
set splitbelow
set splitright
set notimeout
set nottimeout
set ttyfast
set visualbell
set number
" Whitespace {{{
" Tabs, spaces, wrapping. Four space indentation, expand tabs to spaces.
set colorcolumn=+1
set expandtab
set formatoptions=qrn1
set shiftwidth=4
set softtabstop=4
set tabstop=4
set textwidth=78
set wrap
" }}}
" Statusline {{{
" Status line. No idea what that does. Srsly, I have no clue.
set statusline=%F%m%r%h%w
set statusline+=\ %#warningmsg#
set statusline+=%*
set statusline+=%=(%{&ff}/%Y)
set statusline+=\ (line\ %l\/%L,\ col\ %c)
" }}}

" Backup and swap, I don't need them.
set nobackup
set nowritebackup
set noswapfile

" Keep the undo files in a separat directory.
set undodir=~/.vim/tmp
set wildignore+=*/node_modules/*


" Leader. Specify before you start defining key mappings.
let mapleader = ","
let maplocalleader = "\\"

" vimrc editing. Automatically reload the file after saving it. Because there
" is no point in editing the file and *not* reloading it, right?
nnoremap <leader>ev <C-w>s<C-w>j<C-w>L:e $MYVIMRC<cr>
autocmd! bufwritepost .vimrc source %

" Remove trailing whitespace on write.
autocmd BufWritePre * :%s/\s\+$//e

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase

set incsearch
set showmatch
set hlsearch

set gdefault

set virtualedit+=block
set scrolloff=5

noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Views {{{
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
" }}}

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

" Filetypes {{{
" Markdown {{{
" Use <localleader>1/2/3 to add headings.
au BufNewFile,BufRead *.md setlocal filetype=markdown
au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=
au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-
au Filetype markdown nnoremap <buffer> <localleader>3 I### <ESC>
" }}}
" }}}
" Bundles {{{
" ----------------------------------------------------------------------------
" Here is the configuration of individual addons, plugins, bundles, whatever
" you want to call them.

" Gundo {{{
let g:gundo_width = 40
let g:gundo_preview_height = 20
let g:gundo_preview_bottom = 1
" }}}
" Powerline {{{
" Fancy symbols require a custom font. Make sure to install one from
" https://github.com/Lokaltog/vim-powerline/wiki/Patched-fonts
let g:Powerline_symbols = 'fancy'
" }}}
" NERDTree {{{
" Do not show the '.orig' or '~' files
let NERDTreeIgnore=['\~$', '.*\.orig']
" }}}
" ctrlp {{{
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.*\.o$\|.*\.out$\|.*\.orig$\|.*\~$\|dist$\|build$\|node_modules$\|public$\|tmp$'
" }}}
" Syntastic {{{
" Don't run syntastic on HTML files
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['html'] }
let g:syntastic_check_on_open=1
" }}}
" Gist {{{
let g:gist_post_private = 1
" }}}
" }}}
