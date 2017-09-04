set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

Plugin 'elzr/vim-json'
Plugin 'rodjek/vim-puppet'
Plugin 'pangloss/vim-javascript'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'wincent/ferret'
Plugin 'airblade/vim-gitgutter'
Plugin 'neomake/neomake'
Plugin 'dojoteef/neomake-autolint'
Plugin 'jacoborus/tender.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
  set termguicolors
endif

if !exists('g:syntax_on')
  syntax enable
endif

set background=dark
colorscheme tender
set clipboard=unnamed
set backspace=indent,eol,start
set number
set relativenumber
set wildmenu " turn on wild menu
set wildmode=list:longest " turn on wild menu in special format (long format)
set mouse=a " use mouse everywhere
noremap <Space> :
let mapleader = ","

" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !

" indent related
set ai " autoindent (filetype indenting instead)
set nosi " smartindent (filetype indenting instead)

" vim-airline settings
set laststatus=2
let g:airline_theme='tender'

" switch modes easier
:imap jk <Esc>
" add new line with <Enter>
map <Enter> o<ESC>

" ctrlp file/dir exclusions
let g:ctrlp_custom_ignore = '\v[\/](bower_components|node_modules|tmp)|(\.(swp|ico|git|svn))$'
