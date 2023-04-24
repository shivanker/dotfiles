""""""""""" Vundle """""""""""""""
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
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'ludovicchabant/vim-lawrencium'
Bundle 'scrooloose/nerdtree'
Bundle 'phleet/vim-arcanist'
Plugin 'chriskempson/base16-vim'
Plugin 'tpope/vim-repeat'
Plugin 'svermeulen/vim-easyclip'
Plugin 'YouCompleteMe', {'pinned': 1}
Plugin 'mbbill/undotree'

" Plugin 'edkolev/tmuxline.vim'

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
""""""""""""""""""""""""""""""""""

" EasyClip options
" See https://github.com/svermeulen/vim-easyclip
let g:EasyClipShareYanks=1
let g:EasyClipUseSubstituteDefaults=1
imap <c-v> <plug>EasyClipInsertModePaste
set clipboard=unnamed
let g:EasyClipAutoFormat=1
nmap <leader>cf <plug>EasyClipToggleFormattedPaste
let g:EasyClipUseCutDefaults = 0
let g:EasyClipEnableBlackHoleRedirect = 0

let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme railscasts
highlight Search ctermbg=yellow
" colorscheme solarized

" quick shortcut for NERDTree
nmap <leader>nt :NERDTree<cr>

" quick shortcut for Undotree
nmap <leader>u :UndotreeToggle<cr>

" quick turn off highlight
nmap <leader>h :noh<cr>

" nicer colors in iTerm 2
set t_Co=256

set nu
"set tw=80   " break lines after 80 characters
"set cindent
set autoindent
set smartindent
noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>
"set nowrap
set so=3    " start scrolling when 3 rows away from edge
set ruler   " show cursor position on bottom-right
set backspace=eol,start,indent
set softtabstop=2 shiftwidth=2 expandtab

" use \p for toggling paste mode
set pastetoggle=<leader>p

" defaults for new splits
set splitright
set splitbelow

" Better moving around long lines
map k gk
map j gj

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Zoom into a window 
map <C-w>z <C-w>_ <C-w>\|

" Always show the status line
set laststatus=2

" Use Mouse!
if has("mouse")
  set mouse=a
endif
" Fix 220th column mouse bug
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" fucking highlight stuff!
set hlsearch

" 80 char column
set colorcolumn=81,101 " absolute columns to highlight "
"set colorcolumn=+1,+21 " relative (to textwidth) columns to highlight "
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
nnoremap <space> za
vnoremap <space> zf

" search for selected text using //
vnoremap // y/<C-R>"<CR>

" Include - (ASCII 45) and : (ASCII 58) as part of word for tag searches
set iskeyword=@,45,48-57,_,192-255,#

if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

"" " Switch between tabs using Shift-Left/Right
"" if exists('$TMUX')
""   function! TmuxOrTabSwitch(wincmd, tmuxdir)
""     let numtabs = tabpagenr('$')
""     let curtab = tabpagenr()
""     echo numtabs
""     if (curtab == 1 && a:wincmd == "previous") || (curtab == numtabs && a:wincmd == "next")
""       call system("tmux select-window -" . a:tmuxdir)
""       redraw!
""     else
""       execute "tab" . a:wincmd
""     endif
""   endfunction
"" 
""   map <S-Left> :call TmuxOrTabSwitch('previous', 'p')<cr>
""   map <S-Right> :call TmuxOrTabSwitch('next', 'n')<cr>
"" endif


" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_error_symbol = 'x'
let g:ycm_warning_symbol = '!'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
nnoremap <leader>pg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>
let g:ycm_global_ycm_extra_conf="~/.vim/bundle/YouCompleteMe/ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0

" Airline options
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_#extensions#branch#enabled = 1
let g:airline_symbols.space = "\ua0"
let g:airline_theme = 'behelit'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" show a summary of changed hunks under source control
let g:airline#extensions#hunks#enabled = 1
" show only non-zero hunks
let g:airline#extensions#hunks#non_zero_only = 1
" set hunk count symbols
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']

" Tmuxline
let g:tmuxline_powerline_separators = 0

" Put plugins and dictionaries in this dir (also on Windows)
let localVimDir = '$HOME/.vim'
let vimDir = '$HOME/.vim'
let &runtimepath.=','.localVimDir.','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  let myUndoDir = expand(localVimDir . '/undodir')
  " Create dirs
  call system('mkdir -p ' . myUndoDir)
  let &undodir = myUndoDir
  set undofile
endif

