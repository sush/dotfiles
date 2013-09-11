"use Vim settings, rather then Vi settings
set nocompatible

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set nowritebackup
set noswapfile

"show current mode down the bottom
set showmode

"display incomplete commands
set showcmd

"do incremental search
set incsearch

"store lots of :cmdline history
set history=1000

"highlight searches by default
set hlsearch

"switch syntax highlighting on
syntax on

"color scheme
colorscheme railscasts

"font
set guifont=Menlo\ for\ Powerline:h12

"configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1

"mark syntax errors with :signs
let g:syntastic_enable_signs=1

"NERDTree settings
let NERDTreeIgnore=['\.swp$']
autocmd vimenter * if !argc() | NERDTree | endif

" when press { + Enter, the {} block will expand.
imap {<CR> {}<ESC>i<CR><ESC>O

"ctrlp mapping"
let g:ctrlp_map = '<c-f>'

"leader
let mapleader = " "

"jj to escape"
imap jj <Esc>

"key mapping for window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"key mapping for tab navigation
nmap <Tab> gt
nmap <S-Tab> gT

"make Y consistent with C and D
nnoremap Y y$

" vim-rspec mappings
nnoremap <Leader>s :call RunCurrentSpecFile()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

"turn off needless toolbar on gvim/mvim
set guioptions-=T

"turn off the scroll bar
set guioptions-=L
set guioptions-=r

"indent settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

"strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    "preparation: save last search, and cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    "do the business:
    %s/\s\+$//e
    "clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

augroup vimrcEx
  autocmd!

  "when editing a file, always jump to the last known cursor position.
  "don't do it for commit messages, when the position is invalid, or when
  "inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  "enable spellchecking for Markdown
  autocmd BufRead,BufNewFile *.md setlocal spell
augroup END

"use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  "use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  "use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

"exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

"index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

"generate ctags based on Gemfile
map <Leader>rt :!bundle list --paths=true \| xargs ctags --extra=+f --exclude=.git --exclude=log --exclude='*.js' -R *

"let airline use powerline patched fonts
let g:airline_powerline_fonts = 1
