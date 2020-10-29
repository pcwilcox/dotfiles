" .vimrc / init.vim The following vim/neovim configuration works for both Vim and NeoVim

" ensure vim-plug is installed and then load it
call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')
filetype plugin on

" who the fuck knows if this'll work
Plug 'sheerun/vim-polyglot'
" General {{{ Abbreviations
abbr funciton function
abbr teh the
abbr tempalte template
abbr fitler filter
abbr cosnt const
abbr attribtue attribute
abbr attribuet attribute

set autoread " detect when a file is changed
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime

set history=1000 " change history to 1000
set textwidth=120

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set backspace=indent,eol,start " make backspace behave in a sane manner
" set clipboard=unnamed
set clipboard+=unnamedplus

if has('mouse')
    set mouse=a
endif
" Searching
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch " highlight search results
set incsearch " set incremental search, like modern browsers
set nolazyredraw " don't redraw while executing macros

set magic " Set magic on, for regex

" error bells
set noerrorbells
set visualbell
set t_vb=
set tm=500
" }}}

" Appearance {{{

set number " show line numbers
set wrap " turn on line wrapping
set wrapmargin=8 " wrap lines when coming within n characters from side
set linebreak " set soft wrapping
set showbreak=… " show ellipsis at breaking
set autoindent " automatically set indent of new line
set ttyfast " faster redrawing
set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff
set laststatus=2 " show the status line all the time

set so=7 " set 7 lines to the cursors - when moving vertical
set wildmenu " enhanced command line completion
set hidden " current buffer can be put into background
set showcmd " show incomplete commands
set noshowmode " don't show which mode disabled for PowerLine
set wildmode=list:longest " complete files like a shell
set shell=$SHELL
set cmdheight=1 " command bar height
set title " set terminal title
set showmatch " show matching braces
set mat=2 " how many tenths of a second to blink
set updatetime=300
set signcolumn=yes
set shortmess+=c

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'

" Plugin 'zxqfl/tabnine-vim'
" Plugin 'Chiel92/vim-autoformat'
call vundle#end()
filetype plugin indent on
" code folding settings

set foldmethod=syntax " fold based on indent
set foldlevelstart=99
set foldnestmax=10 " deepest fold is 10 levels

set nofoldenable " don't fold by default
set foldlevel=1

" toggle invisible characters
set list!
set listchars=tab:→\ ,trail:⋅,extends:❯,precedes:❮ ",eol:¬
set showbreak=↪

" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

set tags=tags;/

set cscopetag
set csto=1
set cscopeverbose

function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " suppress 'duplicate connection' error
        exe "cs add " . db . " " . path
        set cscopeverbose
        " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endfunction
au BufEnter /* call LoadCscope()

" General Mappings {{{
" set a map leader for more key combos
let mapleader = ','

" shortcut to save
nmap <leader>, :w<cr>

" clear highlighted search
noremap <space> :set hlsearch! hlsearch?<cr>

" activate spell-checking alternatives
nmap ;s :set invspell spelllang=en<cr>

" markdown to html
nmap <leader>md :%!markdown --html4tags <cr>

" remove extra whitespace
nmap <leader><space> :%s/\s\+$<cr> nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

nmap <leader>l :set list!<cr>

" keep visual selection when indenting/outdenting
vmap < <gv
vmap > >gv

" switch between current and last buffer
nmap <leader>. <c-^>

" enable . command in visual mode
vnoremap . :normal .<cr>

map <silent> <C-h> :call functions#WinMove('h')<cr>
map <silent> <C-j> :call functions#WinMove('j')<cr>
map <silent> <C-k> :call functions#WinMove('k')<cr>
map <silent> <C-l> :call functions#WinMove('l')<cr>

nnoremap <silent> <leader>z :call functions#zoom()<cr>

map <leader>wc :wincmd q<cr>

" inoremap <tab> <c-r>=functions#Smart_TabComplete()<CR>

" move line mappings ∆ is <A-j> on macOS ˚ is <A-k> on macOS
nnoremap ∆ :m .+1<cr>==
nnoremap ˚ :m .-2<cr>==
inoremap ∆ <Esc>:m .+1<cr>==gi
inoremap ˚ <Esc>:m .-2<cr>==gi
vnoremap ∆ :m '>+1<cr>gv=gv
vnoremap ˚ :m '<-2<cr>gv=gv

" vnoremap $( <esc>`>a)<esc>`<i(<esc> vnoremap $[ <esc>`>a]<esc>`<i[<esc> vnoremap ${ <esc>`>a}<esc>`<i{<esc>
" vnoremap $" <esc>`>a"<esc>`<i"<esc> vnoremap $' <esc>`>a'<esc>`<i'<esc> vnoremap $\ <esc>`>o*/<esc>`<O/*<esc>
" vnoremap $< <esc>`>a><esc>`<i<<esc>

" toggle cursor line
nnoremap <leader>i :set cursorline!<cr>

nnoremap <C-N> :bnext<cr>
nnoremap <C-P> :bprev<cr>

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

nnoremap <silent> <leader>u :call functions#HtmlUnEscape()<cr>


command! Rm call functions#Delete()
command! RM call functions#Delete() <Bar> q!

" }}}

" AutoGroups {{{ file type specific settings
augroup configgroup autocmd!

    " automatically resize panes on resize
    autocmd VimResized * exe 'normal! \<c-w>='
    autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
    autocmd BufWritePost .vimrc.local source %
    " save all files on focus lost, ignoring warnings about untitled buffers
    autocmd FocusLost * silent! wa

    " make quickfix windows take all the lower section of the screen when there are multiple windows open
    autocmd FileType qf wincmd J
    autocmd FileType qf nmap <buffer> q :q<cr>
augroup END
" }}}

" NERDTree {{{
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
let g:WebDevIconsOS = 'Darwin'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible
let NERDTreeNodeDelimiter = "\u263a" " smiley face

augroup nerdtree autocmd!
    autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
    autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
augroup END

" Toggle NERDTree
function! ToggleNerdTree()
    if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
        :NERDTreeFind
    else
        :NERDTreeToggle
    endif
endfunction
" toggle nerd tree
nmap <silent> <leader>k :call ToggleNerdTree()<cr>
" find the current file in nerdtree without needing to reload the drawer
nmap <silent> <leader>y :NERDTreeFind<cr>

let NERDTreeShowHidden=1
let NERDTreeDirArrowExpandable = '▷'
let NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ 'Ignored'   : '☒',
            \ "Unknown"   : "?"
            \ }
" }}}

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf.vim'
" Both options are optional. You don't have to install fzf in ~/.fzf
" and you don't have to run the install script if you use fzf only in Vim.

let g:fzf_layout = { 'down': '~25%' }

if isdirectory(".git")
    " if in a git project, use :GFiles
    nmap <silent> <leader>f :GitFiles --cached --others --exclude-standard<cr>
else
    " otherwise, use :FZF
    nmap <silent> <leader>f :FZF<cr>
endif

nmap <silent> <leader>s :GFiles?<cr>

nmap <silent> <leader>r :Buffers<cr>
nmap <silent> <leader>t :Tags<cr>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <silent> <Leader>C :call fzf#run({
            \   'source':
            \     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
            \         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
            \   'sink':    'colo',
            \   'options': '+m',
            \   'left':    30
            \ })<CR>

command! FZFMru call fzf#run({
            \  'source':  v:oldfiles,
            \  'sink':    'e',
            \  'options': '-m -x +s',
            \  'down':    '40%'})

command! -bang -nargs=* Find call fzf#vim#grep(
            \ 'rg --column --line-number --no-heading --follow --color=always '.<q-args>, 1,
            \ <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
command! -bang -nargs=? -complete=dir GitFiles
            \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
" }}}

" vim-fugitive {{{
Plug 'tpope/vim-fugitive'
nmap <silent> <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gb :Gblame<cr>

Plug 'tpope/vim-rhubarb' " hub extension for fugitive
Plug 'junegunn/gv.vim'
Plug 'sodapopcan/vim-twiggy'
" }}}

" Powerline
" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup

" Load colorschemes
" Plug 'chriskempson/base16-vim'
" colorscheme dim
Plug 'phanviet/vim-monokai-pro'
set termguicolors
colorscheme monokai_pro


" LightLine {{{
Plug 'itchyny/lightline.vim'
" Plug 'sainnhe/lightline_foobar.vim'
" Plug 'nicknisi/vim-base16-lightline'

" let g:lightline.active = {
"     \ 'left': [ [ 'mode', 'paste' ],
"     \           [ 'readonly', 'filename', 'modified' ] ],
"     \ 'right': [ [ 'lineinfo' ],
"     \            [ 'percent' ],
"     \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }
" let g:lightline.inactive = {
"     \ 'left': [ [ 'filename' ] ],
"     \ 'right': [ [ 'lineinfo' ],
"     \            [ 'percent' ] ] }
" let g:lightline.tabline = {
"     \ 'left': [ [ 'tabs' ] ],
"     \ 'right': [ [ 'close' ] ] }
"let g:lightline = {
"            \ 'colorscheme': 'seoul256',
"            \ }

function! LightlineFileName() abort
    let filename = winwidth(0) > 70 ? expand('%') : expand('%:t')
    if filename =~ 'NERD_tree'
        return ''
    endif
    let modified = &modified ? ' +' : ''
    return fnamemodify(filename, ":~:.") . modified
endfunction

function! LightlineFileEncoding()
    " only show the file encoding if it's not 'utf-8'
    return &fileencoding == 'utf-8' ? '' : &fileencoding
endfunction

function! LightlineFileFormat()
    " only show the file format if it's not 'unix'
    let format = &fileformat == 'unix' ? '' : &fileformat
    return winwidth(0) > 70 ? format . ' ' . WebDevIconsGetFileFormatSymbol() : ''
endfunction

function! LightlineGitBranch()
    return "\uE725" . (exists('*fugitive#head') ? ' ' . fugitive#head() : '')
endfunction

function! LightlineUpdate()
    if g:goyo_entered == 0
        " do not update lightline if in Goyo mode
        call lightline#update()
    endif
endfunction

function! LightlineGitBlame()
    return winwidth(0) > 100 ? strpart(get(b:, 'coc_git_blame', ''), 0, 20) : ''
endfunction
" }}}

Plug 'benmills/vimux'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

map <Leader>ge :Goyo<CR>
map <Leader>gd :Goyo!<CR>

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Open a pane to run a command
map <Leader>vo :VimuxOpenRunner<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>
" Zoom the tmux runner pane
map <Leader>vz :VimuxZoomRunner<CR>

" syntax highlighting I hope
Plug 'octol/vim-cpp-enhanced-highlight'
let g:cpp_member_variable_highlight = 1


function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

    " UltiSnips {{{
        Plug 'SirVer/ultisnips' " Snippets plugin
        let g:UltiSnipsExpandTrigger="<C-l>"
        let g:UltiSnipsJumpForwardTrigger="<C-j>"
        let g:UltiSnipsJumpBackwardTrigger="<C-k>"
    " }}}

    " coc {{{
        Plug 'neoclide/coc.nvim', {'branch': 'release'}

        " disabled extensions
        "\ 'coc-tsserver',
        " "\ 'coc-eslint',
        " "\ 'coc-tslint-plugin',
        " "\ 'coc-emmet',
        " "\ 'coc-vimlsp',
        "\ 'coc-prettier',
        ""\ 'coc-pairs',
        let g:coc_global_extensions = [
        \ 'coc-css',
        \ 'coc-json',
        \ 'coc-git',
        \ 'coc-sh',
        \ 'coc-ultisnips',
        \ 'coc-diagnostic',
        \ 'coc-clangd',
        \ 'coc-prettier',
        \ 'coc-cmake',
        \ 'coc-go',
        \ 'coc-highlight',
        \ 'coc-jedi',
        \ 'coc-markdownlint',
        \ 'coc-rls',
        \ 'coc-yaml'
        \ ]

        autocmd CursorHold * silent call CocActionAsync('highlight')
" syntastic
Plug 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_python_checkers = ['python3']

Plug 'mhinz/vim-startify'
        " Don't change to directory when selecting a file
        let g:startify_files_number = 5
        let g:startify_change_to_dir = 0
        let g:startify_custom_header = [ ]
        let g:startify_relative_path = 1
        let g:startify_use_env = 1

        " Custom startup list, only show MRU from current directory/project
        let g:startify_lists = [
        \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
        \  { 'type': function('functions#listcommits'), 'header': [ 'Recent Commits' ] },
        \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
        \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
        \  { 'type': 'commands',  'header': [ 'Commands' ]       },
        \ ]

        let g:startify_commands = [
        \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
        \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
        \   { 'uc': [ 'Update CoC Plugins', ':CocUpdate' ] },
        \ ]

        let g:startify_bookmarks = [
            \ { 'c': '~/.config/nvim/init.vim' },
            \ { 'g': '~/.gitconfig' },
            \ { 'b': '~/.bashrc' }
        \ ]

        autocmd User Startified setlocal cursorline
        nmap <leader>st :Startify<cr>

  autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" Allows to toggle the error's window visibility
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

" vim-tex
Plug 'lervag/vimtex'

noremap <silent> <C-p> : call ToggleErrors()<CR>

" Cool line numbering
Plug 'jeffkreeftmeijer/vim-numbertoggle'
set number relativenumber

" Syntastic latex things
let g:syntastic_tex_checkers = ['chktex']

Plug 'editorconfig/editorconfig-vim'

" Rust
Plugin 'rust-lang/rust.vim'

" Go
Plugin 'fatih/vim-go'

" Tab control
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set shiftround

let _curfile =- expand("%:t")
if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
    set noexpandtab
    set tabstop=8
elseif _curfile =~ "*.html"
    set shiftwidth=2
    set softtabstop=2
    set tabstop=2
elseif _curfile =~ "*.go"
    set noexpandtab
    set tabstop=4
elseif _curfile =~ "*.yml"
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
elseif _curfile =~ "*.c" || "*.h"
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set shiftround
    set expandtab
    set autoindent
    set cindent
elseif _curfile =~ ".gitconfig"
    set noexpandtab
elseif _curfile =~ "*.tex"
    set textwidth=80
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set shiftround
    set expandtab
    set autoindent
endif
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"
autocmd FileType vim,tex let b:autoformat_autoindent=0

au BufWrite *.c :Autoformat
au BufWrite *.cpp :Autoformat
au BufWrite *.cc :Autoformat
au BufWrite *.h :Autoformat
au BufWrite *.js :Autoformat

let g:syntastic_go_checkers = ['gofmt']
let g:go_list_type = "quickfix"
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>n :cnext<CR>
autocmd FileType go nmap <leader>p :cprevious<CR>
autocmd FileType go nnoremap <leader>a :cclose<CR>

highlight Comment cterm=italic

"autocmd FileType go autocmd BufWritePre <buffer> silent GoFmt
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

let g:tex_flavor = 'latex'

let g:lightline = {
      \ 'colorscheme': 'monokai_pro',
      \ }
call plug#end()

