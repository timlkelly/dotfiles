" Colors
  set background=dark
  set termguicolors " Use true colors
  " colorscheme badwolf
  colorscheme molokai
  " colorscheme solarized

" Spaces & Tabs
  set autoindent    " New lines inherit parent's indentation
  set expandtab     " Turn tabs into spaces
  set shiftwidth=2  " Sets size of an indent
  set softtabstop=2 " Sets the number of columns for a tab
  set tabstop=2     " Width of the tab

" UI
  set cursorline
  set fillchars+=diff:⣿
  set fillchars+=vert:│
  set fillchars+=fold:\
  set laststatus=2   " Always display status bar
  set lazyredraw
  set mouse=a        " Enable mouse
  " set noerrorbells " disable beep on errors
  " set visualbell   " Flash screen instead of beeping
  set number
  " set relativenumber
  set ruler
  set showcmd
  set showmatch
  set title
  set wildmenu
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip
  syntax enable

" set fillchars=stl:―,stlnc:—,vert:│,fold:۰,diff:·

" highlight folded       cterm=bold ctermbg=none ctermfg=5
" highlight vertsplit    cterm=none ctermbg=none ctermfg=9
" highlight statusline   cterm=none ctermbg=none ctermfg=9
" highlight statuslinenc cterm=none ctermbg=none ctermfg=9
" highlight specialkey   cterm=none ctermbg=none ctermfg=1
" highlight matchparen   cterm=none ctermbg=none ctermfg=5
" highlight wildmenu     cterm=bold ctermbg=none ctermfg=3
" highlight visual       cterm=bold ctermbg=7    ctermfg=none
" highlight user1        cterm=none ctermbg=none ctermfg=3

" Text rendering
  set display+=lastline " Always try to show paragraphs last line
  set encoding=utf-8
  set linebreak         " Avoid wrapping a line in the middle of a word
  set listchars+=eol:¬
  set listchars+=extends:❯
  set listchars+=precedes:❮
  set listchars+=trail:⋅
  set listchars+=nbsp:⋅
  set listchars+=tab:\|\
  set scrolloff=1       " The number of screen lines to keep abv and blw cursor
  set sidescrolloff=5   " The number of screen columns to keep to the left/right of cursor
  set showbreak=↪       " Visual cue for line-wrapping

  " Search
  set hlsearch
  set ignorecase
  set incsearch
  set smartcase
  nnoremap <leader><space> :nohlsearch<CR>
  map <esc> :noh<cr>

" Folding
  set foldenable
  set foldlevelstart=10
  set foldmethod=indent
  set foldnestmax=10
  nnoremap <space> za

  " Prereq for vimwiki
  set nocompatible
  filetype plugin on

  " Movement
  nnoremap j gj
  nnoremap k gk
  noremap J 5j
  noremap K 5k
  noremap <C-k> 10k
  noremap <C-j> 10j

  " Misc
  set autoread           " re-read files if unmodified inside vim
  set backspace=indent,eol,start
  set confirm            " prompt dialog when closing unsaved file
  " set formatoptions+=j " delete comment characters when joining lines
  set history=1000       " Increase the undo limit
  set spell              " Enable spellcheck

  inoremap jk <esc>

" Unmap
  map q <Nop>      " Disable recording mode
  nnoremap Q <nop> " Disable ex mode
  vnoremap // y/<C-R>"<CR>
  noremap <Up> <Nop>
  noremap <Down> <Nop>
  noremap <Left> <Nop>
  noremap <Right> <Nop>

" Trial
  nnoremap gV `[v`] " Highlight last inserted text
  nnoremap H ^      " Highlight code
  noremap L g_      " Highlight code
  nnoremap ; :

" Plugins
  call plug#begin('~/.config/nvim/plugged')
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'vimwiki/vimwiki'

    " Themes / Colors
    Plug 'tomasr/molokai'
    Plug 'sjl/badwolf'
    Plug 'altercation/Vim-colors-solarized'
  call plug#end()

" Plugin Settings
  " CtrlP
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_match_window  = 'bottom,order:ttb'
    let g:ctrlp_switch_buffer = 0
    let g:ctrlp_working_path  = 0
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/]\.(git|hd|svn)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

  " NERDTree
    map <C-n> :NERDTreeToggle<CR>
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  " VimWiki
    let g:vimwiki_list = [{ 'path': '~/development/notes',
                          \ 'path_html': '~/development/notes/',
                          \ 'diary_index': 'archive_index',
                          \ 'diary_rel_path': 'archive'
                          \ }]
    let g:vimwiki_folding = 'expr'
    let g:vimwiki_hl_cb_checked = 1
    let g:vimwiki_listsyms = ' .oOX'

