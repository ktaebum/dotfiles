set encoding=utf-8
set nocompatible
set splitbelow

let g:python3_host_prog = '/Users/taebum/Program/anaconda3/bin/python3'

set cb=unnamed

filetype off
call plug#begin('$HOME/.vim/plugged')
""" color schemes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'sheerun/vim-polyglot'
Plug 'sonph/onehalf', {'rtp': 'vim'}
Plug 'sickill/vim-monokai'
Plug 'ktaebum/vim-monokai-pro'
Plug 'patstockwell/vim-monokai-tasty'

"""""" python plugin 
Plug 'hdima/python-syntax'                      " python syntax

"""""" powerline plugins
Plug 'vim-airline/vim-airline'                  " airline (powerline)
Plug 'vim-airline/vim-airline-themes'           " vim-airline themes

"""""" snippets plugins
Plug 'SirVer/ultisnips'                         " snippets
Plug 'honza/vim-snippets'                       " snippets

"""""" auto completers
Plug 'ycm-core/YouCompleteMe'                   " ycm

""""" deoplete familiy
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi-vim'                     " auto-completer for python/latex
Plug 'Shougo/deoplete-clangx'
Plug 'deoplete-plugins/deoplete-go'
Plug 'sebastianmarkow/deoplete-rust'
"
" """""" searcher and file/tag navigators
Plug 'scrooloose/nerdtree'                      " file navigator
Plug 'majutsushi/tagbar'                        " displays tags in a window
"
" """""" git plugins
Plug 'tpope/vim-fugitive'                       " git integration
Plug 'airblade/vim-gitgutter'                   " git diff line by line
Plug 'gisphm/vim-gitignore'                     " git ignore
"
" """""" commenters
Plug 'scrooloose/nerdcommenter'                 " easy-commenting
"
" """""" formatter
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
"
" """""" syntax checker
Plug 'dense-analysis/ale'

" """""" React related
Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
"Plugin 'pangloss/vim-javascript'
Plug 'gavocanov/vim-js-indent'

" """"" ocaml
Plug 'ocaml/vim-ocaml'

" """"" markdown
Plug 'JamshedVesuna/vim-markdown-preview'

call plug#end()
filetype plugin indent on


"""" basic editor setting """"


set mouse=a
set ruler
set hlsearch
set incsearch
set showmatch
"set completeopt-=preview
set backspace=indent,eol,start
set nu
set relativenumber
set noshowmode
set autowrite
highlight Comment cterm=italic
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set smarttab
set expandtab
set colorcolumn=80

"""" paper color scheme """"
set t_Co=256
"set termguicolors
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"set t_8b=^[[48;2;%lu;%lu;%lum
"set t_8f=^[[38;2;%lu;%lu;%lum
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
"\       'override': {
"\         'color00': ['#e0e0e0', '224'],
"\         'linenumber_bg': ['#e0e0e0', '224']
let g:python_highlight_all = 1
let g:PaperColor_Theme_Options = {
  \ 'language': {
  \   'python': {
  \     'highlight_builtins' : 1
  \   },
  \   'cpp': {
  \     'highlight_standard_library': 1
  \   }
  \ }
  \}
set background=dark
"color jellybeans
"color OceanicNext
"color afterglow
"color PaperColor
"color one
"color gruvbox
"color seoul256
"color onehalfdark
"color flattened_light
"color monokai
color monokai_pro
"color nord
let g:molokai_original = 1
let g:seoul256_background=235

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
"color onedark
syntax on
let g:onedark_terminal_italics = 0
let g:onedark_termcolors = 16

"set background=dark

let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_contrast_light = 'hard'

"""" python language set """"
au FileType python setl sw=2 sts=2 et

"""" different cursor for different mode """"
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"""" airline setting """"
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_theme='oceanicnext'
let g:airline_theme='afterglow'
let g:airline_theme='onedark'
let g:airline_theme='jellybeans'
let g:airline_theme='one'
let g:airline_theme='gruvbox'
let g:airline_theme='papercolor'
let g:airline_theme='solarized'
let g:airline_theme='dracula'
let g:airline_theme='onehalfdark'
let g:airline_theme='molokai'
let g:airline_theme='nord'
let g:airline_theme='zenburn'
let g:airline_theme='monokai_tasty'

"""" YCM setting """"
set completeopt-=preview
let g:loaded_youcompleteme = 1  " disable ycm for mac
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<C-j>' ]
let g:ycm_key_list_previous_completion = ['<C-k>']
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_python_binary_path='/Users/taebum/Program/anaconda3/bin/python3'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '--'
let g:ycm_show_diagnostics_ui = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1

"turn off ycm syntax check for cuda
au Bufread,BufNewFile *.cu,*.c,*.cc let g:ycm_show_diagnostics_ui = 0


nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>gg :YcmCompleter GoToImprecise<CR>
nnoremap <leader>d :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>dd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>p :YcmCompleter GetParent<CR>
noremap <silent> <F6> /^\(<<<<<<<\\|=======\\|>>>>>>>\)<cr>

"""" ale """"
let g:ale_linters = {
\   'python': ['pylint'],
\   'c': ['gcc'],
\   'cpp': ['gcc'],
\   'cuda': ['nvcc'],
\   'javascript': ['eslint'],
\}
"let g:ale_sign_error = '<>'
"let g:ale_sign_warning = '-'
"let g:ale_sign_error = '💣'
"let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1
let g:ale_cpp_gcc_options = '-std=c++11 -I/usr/local/opt/llvm/include/ -I/Users/taebum/Workspace/iccv/tensorflow/'
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"
let g:ale_set_highlights = 0
"highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#C30500 guibg=#423f42
"highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#ED6237 guibg=#423f42
"highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#C30500 guibg=#2e3440
"highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#ED6237 guibg=#2e3440
highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#C30500 guibg=#3F3F3F
highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#ED6237 guibg=#3F3F3F

"highlight clear ALEErrorSign
"highlight clear ALEWarningSign

"hi link ALEErrorSign    Error
"hi link ALEWarningSign  Warning

"""" google codefmt """"
""" Google CodeFMT
augroup autoformat_settings
    "autocmd FileType c,cpp,java,javascript,typescript AutoFormatBuffer clang-format
    "autocmd FileType python AutoFormatBuffer yapf
    "autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType json AutoFormatBuffer js-beautify
augroup END

""" key mapping
" nmap <C-n><C-n> :tabnew<CR>
" nmap <C-w> <C-w><C-w>
nmap <Tab> :bn<CR>
nmap <C-y> :vertical resize +10<CR>
nmap <C-t> :vertical resize -10<CR>
nmap <C-W>y :resize +10<CR>
nmap <C-W>t :resize -10<CR>
nmap <leader>t :NERDTreeToggle<CR>
nmap <leader> :TagbarToggle<CR>
" nmap <C-W>M <C-W>\| <C-W>_
" nmap <C-W>m <C-W>=
nmap <C-m> <C-W>\| <C-W>_
nmap <C-n> <C-W>1\|
nmap <C-e> <C-W>=
nmap <C-v> :vs<CR>
nmap <C-s> :sp<CR>
nmap <C-p> :bp<CR>
nmap <leader><space> :noh<CR>
nnoremap <silent> <C-h> <C-W>h
nnoremap <silent> <C-l> <C-W>l
nnoremap <silent> <C-k> <C-W>k
nnoremap <silent> <C-j> <C-W>j

" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<C-j>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<C-k>" : "\<s-tab>"

"""" jedi vim """"
let g:jedi#show_call_signatures_delay = 0
let g:jedi#auto_vim_configuration = 1
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#completions_enabled = 1
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "2"
let g:jedi#max_doc_height = 20
let g:jedi#auto_close_doc = 0

au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css

""""" ocaml
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

""""" rust
set hidden
let g:racer_cmd = "$HOME/.cargo/bin/racer"
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1

""""" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#rust#racer_binary='$HOME/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='$HOME/Workspace/kecc-public/src'

""""" markdown
let g:vim_markdown_preview_toggle=1
let g:vim_markdown_preview_hotkey='<C-m>'
let g:vim_markdown_preview_browser='Google Chrome'
let g:vim_markdown_preview_github=1
let g:vim_markdown_preview_temp_file=1
