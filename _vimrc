"Enable Syntax Highlighting
:syntax enable
":colorscheme torte

"Set Font
set guifont=Courier_New:h10:cANSI:qDRAFT

"set HOME=C:\Program\ Files\ (x86)\Vim

"Setup GVIM
set guioptions-=m
set guioptions-=T
set guioptions-=r

"Enable Line Numbers
:set number
:set rnu

"Highlight Search Parameter
:set hlsearch

"Display currernt cursor position
:set ruler

"Display the current command
:set showcmd

"Show the current mode
:set showmode

"Set Tab Size
:set tabstop=5
:set shiftwidth=5
:set softtabstop=5
:set expandtab
:set smarttab
":set autoindent

"No Word Wrap
:set nowrap

"Backspace always work
set backspace=indent,eol,start

"filetype plugin on
filetype indent on

" C Indent Options
:set cino=>5

:map "Ay "ay

"""""""""""""""""
"
" Replace Macros
"
"""""""""""""""""

" Include Guard
inoremap #i <esc>:call Ig()<cr>

" Title Comment
inoremap // <esc>:call C_com()<cr>

"Create Comment
inoremap /* /*  */<Esc>hhi

"Multi Line Comment Rule
":set comments=sr:/*,mb:**,ex:*/

"After Case in switch, do not indent braces
":set cino==0

"auto close braces
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

"auto close brackets
inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     []

"auto close brackets
inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap ()     ()

inoremap "Ay    "ay

inoremap @g <esc>:call Grep_select()<esc>

function! Grep_select()
    execute "gr -r --include=*.{c,h,mk} " .  " . "
endfunction

" Remove all trailing whitespace by pressing F5
nnoremap <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>


"""""""""""""
"
" Open Files
"
"""""""""""""
":tabedit $MYVIMRC


" Color Scheme
:colorscheme morning
:hi Statement       ctermfg=Blue
:hi LineNr          ctermfg=Blue
:hi CursorLineNr    ctermfg=96
:hi Type            ctermfg=Blue
:hi Identifier      ctermfg=Blue

""""""""""""
"
" Functions
"
""""""""""""
function! Cd_5x5_mach(x)
    let str=a:x
    execute 'cd' "/cygdrive/" . str . "/app_wtl32/machine/build/5x5_t4f"
    call Add_path()
endfunction

function! Add_tab(x)
     let str=a:x
     execute 'norm 0|'
     execute 'norm dw'
     execute 'norm ' . str . "i     "
endfunction

" Add path function for 'find' feature
function! Add_path()
    "set path=.,,**
    set path=.
    set path+=./include/
    set path+=./include/trans/
    set path+=./include/subsystem/
    set path+=./include/tpms//
    set path+=./release/
    set path+=./src/
    set path+=./src/trans/
    set path+=./src/tpms/
    set path+=./src/subsystem/
endfunction


function! Grep(x)
    let str=a:x
    execute "gr -r --include=*.{c,h,mk} " . str . " . "
endfunction

"Set Date
function! Date()
    execute 'norm mz'
    execute 'norm3G'
    execute 'norm f2llll'
    if getline(".")[col(".")-1] == ' '
        execute 'norm i-2016'
    else
        execute 'norm 4l'
        execute 'norm r6'
    endif
    execute 'norm `z'
endfunction

"Create Include Guard
function! Ig()
    call inputsave()
    let h_file_name = input('Enter include file (no .h): ')
    call inputrestore()

    execute 'norm i# i'
    execute 'norm dh'
    execute 'norm Afndef   ' . h_file_name . '_H_'
    execute 'norm vBUE'
    execute 'norm o'
    execute 'norm i# i'
    execute 'norm dh'
    execute 'norm Anclude <' . h_file_name . '.h>'
    execute 'norm vBuE'
    execute 's/packd/PackD/e'
endfunction

"Find files with matching string
function! Find_files(x)
    let str=a:x
    execute "set find_files=!find . -name \'*" . str . "*.c' -o -name '*" .str . "*.h' "

endfunction


"
" Leader
"
:map <Leader>y "*y
:map <Leader>p "*p



" Create Comment
function! C_com()

     call inputsave()
     let str = input('Enter comment:')
     call inputrestore()

     let com_length = strlen(str)

     " Temp Remove Mappings
     inoremap /* /*

     execute "normal! i\/*****\<esc>"
     execute "normal! " . com_length . "i*\<esc>i \<esc>"
     execute "normal! hhDi** " . str . " \<esc>"
     execute "normal! " . com_length . "i*\<esc>A***\/ \<esc>"

     " Add Mappings Back In
     inoremap /* /*  */<Esc>hhi

endfunction


function! Get_fn()
     let @* = expand("%:t")
endfunction




" Assign Vim Notes Path to Variable
:let $VIMNOTES = '/cygdrive/c/Users/dodgenc/Desktop/Desktop/vim_notes.txt'

" PLUGINS
execute pathogen#infect()

" CTRLP
" Ignore These files
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn)$',
\ 'file': '\v\.(exe|so|dll|o)$',
\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
\ }


