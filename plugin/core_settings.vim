if exists('g:loaded_core_settings')
  finish
else
  let g:loaded_core_settings = 1
endif

filetype plugin indent on     " required!

set shell=/bin/bash
set noexrc                     " don't use local version of .(g)vimrc, .exrc
set autoindent                 " Copy indent from current line when starting a new line
set autowriteall               " Automatically save before commands like :next and :make
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set encoding=utf-8             " Use UTF-8 everywhere.

" ---------------
" Color
" ---------------
set background=dark
colorscheme codeschool
highlight clear SignColumn

" ---------------
" Backups
" ---------------
set backup
set backupskip+=*.tmp,crontab.* " do not make backup for this files
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/tmp

" ---------------
" UI
" ---------------
set ruler                           " show the cursor position all the time
set cursorline                      " Only have cursorline in current window

if has("balloon_eval") && has("unix")
  set ballooneval
endif
set breakindent                         " Every wrapped line will continue visually indented
let &showbreak='↖ '                     " String to put at the start of lines that have been wrapped.
set cmdheight=1                         " command line height
set complete-=i,w,b,u,t                 " Searching includes can be slow
set completeopt=longest,menuone,preview " A comma separated list of options for Insert mode completion
set display=lastline                    " Change the way text is displayed.
set joinspaces                          " Put spaces between lines joined with the > command.
set lazyredraw                          " Do not redraw the screen during macro execution.
set list                                " Useful to see the difference between tabs and spaces and for trailing blanks
set listchars=tab:▸\ ,eol:¬,trail:·,extends:❯,precedes:❮,nbsp:+ " Define how list mode appears, Use the same symbols as TextMate for tabstops and EOLs
" show trailing whitespace when not on insert mode
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:·
    au InsertLeave * :set listchars+=trail:·
augroup END
nmap <leader>l :set list!<CR>       " Shortcut to rapidly toggle `set list`
set modelines=5                     " Debian likes to disable this, The number of lines at the top and bottom to look for modelines.
set cpoptions+=$                    " show $ on the end of selection
set virtualedit=all                 " enable virtualedit, useful for visual block editing
set linespace=2                     " more space between lines
set guicursor+=a:blinkon0           " Disable gui cursor blinking
set ttyfast                         " Indicates a fast terminal connection.

if exists('+colorcolumn')
  set colorcolumn=120
endif

" :w!! saves a file as root
cmap w!! w !sudo tee % >/dev/null<CR>

" -------------
"  lang
" -------------
if exists("+spelllang")
  let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
  set spelllang=en_us,pl
  set spell
endif

" ---------------
" Behaviors
" ---------------
syntax enable

set synmaxcol=300

set hlsearch " When there is a previous search pattern, highlight all its matches.
set incsearch " While typing a search command, show where the pattern, as it was typed so far, matches.
noremap <Leader>/ :set invhls<CR> " toggle highlight

set textwidth=120
set autoread                    " Automatically reload changes if detected
set wildmenu                    " Turn on WiLd menu
set history=768                 " Number of things to remember in history.
set cf                          " Enable error files & error jumping.
set clipboard+=unnamed          " Yanks go on clipboard instead.
set autowrite                   " Writes on make/shell commands
set formatoptions=crql
set nrformats=
set suffixes+=.dvi              " Lower priority in wildcards
set showmatch                   " Show matching brackets.
set ignorecase                  " Ignoring case in a pattern
set smartcase                   " Case insensitive searches become sensitive with capitals
set shiftround                  " Round indent to multiple of 'shiftwidth'
set laststatus=2                " always show status line
set showcmd                     " Show (partial) command in the last line of the screen
set shortmess=aOstT             " shortens messages to avoid 'press a key' prompt
set linebreak                   " If on, Vim will wrap long lines at a character in 'breakat' rather than at the last character that fits on the screen
" Number of lines to keep above or below the cursor.
if !&scrolloff
  set scrolloff=3
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline
set autoread                    " read file from disk when changed in another editor
set autowrite                   " auto write file on several commands
" Keep search pattern at the center of the screen.
" {{
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
" }}
set smarttab                    " sw at the start of the line, sts everywhere else
if v:version >= 700
  set viminfo=!,'20,<50,s10,h
endif
set virtualedit=block
set wildmode=longest:full,full
set wildignore+=*~                                    " temporary files
set wildignore+=/tmp/*,*/tmp/*                        " tmp files
set wildignore+=*.zip,*.tar,*.tar.gz,*.gz,*.rar,*.7z  " archives
set wildignore+=*.md5.*                               " spring md5 files
set wildignore+=.hg,.git,.svn                         " Version control
set wildignore+=*.aux,*.out,*.toc                     " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg        " binary images
set wildignore+=*.o,*.so,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                                 " compiled spelling word lists
set wildignore+=*.sw?                                 " Vim swap files
set wildignore+=*.DS_Store                            " OSX bullshit
set wildignore+=*.orig                                " Merge resolution files

set winaltkeys=no

set splitbelow                  " Split windows at bottom with :split
set splitright                  " Split windows on right with :vsplit

set ts=2 sts=2 sw=2 noexpandtab   " default indentation 2 spaces
set relativenumber                " show lines number
set number                        " show lines number
" set nuw=6                       " column with line numbers is 6 chars width
set ff=unix                       " unix end of line
set cryptmethod=blowfish2         " encryption method :X or -x in command line

augroup vimrc
  autocmd!
augroup END

autocmd vimrc VimResized * :wincmd =         " Resize splits when the window is resized

" ---------------
" folding
" --------------- {{
set foldenable                                   " Turn on folding
set foldmethod=syntax                            " Fold on the marker
set foldlevel=100                                " Don't autofold anything (but I can still fold manually)
set foldlevelstart=99                            " Remove folds
set foldopen=block,hor,mark,percent,quickfix,tag " what movements open fold

" ---------------
" mouse
" --------------- {{
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
" }}

" ---------------
" mouse
" --------------- {{
set mouse=a                     " enable mouse
set mousehide                   " Hide mouse after chars typed
set mousemodel=popup            " the right mouse button causes a small pop-up menu to appear

" ---------------
" Switch between buffers
" --------------- {{
noremap <tab> :bn<CR>
noremap <S-tab> :bp<CR>
nmap <leader>d :bprevious<CR>:bdelete #<CR> " Close buffer
nmap <leader>D :bufdo bd<CR>                " Close all buffers
" }}

" ---------------
" move lines
" --------------- {{

" without that moving lines in console vim not working
if !has('gui_running')
  let c='a'
  while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
  endw
endif

" These two options together determine the behavior when part of a
" mapped key sequence or keyboard code has been received
set notimeout
set ttimeout
set ttimeoutlen=50

nmap <A-j> ]e==
nmap <A-k> [e==
imap <A-j> <Esc>]e==i
imap <A-k> <Esc>[e==i
vmap <A-j> ]egv=gv
vmap <A-k> [egv=gv
" }}

" ---------------
" switch tabs
" --------------- {{
map <A-1> 1gt
map <A-2> 2gt
map <A-3> 3gt
map <A-4> 4gt
map <A-5> 5gt
map <A-6> 6gt
map <A-7> 7gt
map <A-8> 8gt
map <A-9> 9gt
map <A-0> :tablast<CR>
" }}

" ----------------------------------------
" Functions
" ----------------------------------------

" ---------------
" Trailing Whitespaces
" --------------- {{
function! <SID>StripTrailingWhitespaces(manual)
  let current_filetype = &filetype
  if current_filetype != 'markdown'
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
  elseif a:manual
    echoerr "Trailing whitespaces are part of Markdown syntax. Clean them yourself."
  endif
endfunction

nnoremap <silent> <F3> :call <SID>StripTrailingWhitespaces(1)<CR>
autocmd vimrc BufWritePre * :call <SID>StripTrailingWhitespaces(0)
" }}

" ---------------
" Quick spelling fix (first item in z= list)
" --------------- {{
function! QuickSpellingFix()
  if &spell
    normal 1z=
  else
    " Enable spelling mode and do the correction
    set spell
    normal 1z=
    set nospell
  endif
endfunction

command! QuickSpellingFix call QuickSpellingFix()
nmap <silent> <leader>z :QuickSpellingFix<CR>
" }}


" ---------------
" subversion blame
" --------------- {{
vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
" }}


" ---------------
" shifting tabs
" --------------- {{
function! ShiftTab(direction)
     let tab_number = tabpagenr()
     if a:direction == 0
         if tab_number == 1
             exe 'tabm' . tabpagenr('$')
         else
             exe 'tabm' . (tab_number - 2)
         endif
     else
         if tab_number == tabpagenr('$')
             exe 'tabm ' . 0
         else
             exe 'tabm ' . tab_number
         endif
     endif
     return ''
endfunction

inoremap <silent> <C-S-PageUp>  <C-r>=ShiftTab(0)<CR>
inoremap <silent> <C-S-PageDown>  <C-r>=ShiftTab(1)<CR>

noremap <silent> <C-S-PageUp>  :call ShiftTab(0)<CR>
noremap <silent> <C-S-PageDown> :call ShiftTab(1)<CR>
" }}

" ---------------
" File types settings
" --------------- {{
" CSS (tab width 2 chr)
autocmd vimrc FileType css set et
autocmd vimrc FileType css set sw=2
autocmd vimrc FileType css set ts=2
autocmd vimrc FileType css set sts=2
" less (tab width 2 chr)
autocmd vimrc FileType less set et
autocmd vimrc FileType less set sw=2
autocmd vimrc FileType less set ts=2
autocmd vimrc FileType less set sts=2
" JavaScript (tab width 2 chr)
autocmd vimrc FileType javascript set et
autocmd vimrc FileType javascript set sw=2
autocmd vimrc FileType javascript set ts=2
autocmd vimrc FileType javascript set sts=2
" HTML (tab width 2 chr)
autocmd vimrc FileType html set et
autocmd vimrc FileType html set sw=2
autocmd vimrc FileType html set ts=2
autocmd vimrc FileType html set sts=2
"  }}
