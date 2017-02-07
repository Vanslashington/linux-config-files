" Main
syntax on
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent

" Other
set colorcolumn=101
set viminfo='100,f1,<500
let mapleader = "-"

highlight ColorColumn ctermbg=DarkCyan guibg=#2c2d27
hi MatchParen cterm=bold ctermbg=none ctermfg=white

" File extensions
"filetype on
au BufNewFile,BufRead *.tpp set filetype=cpp
autocmd Filetype pl set syntax=prolog

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=green guibg=green
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Maps
inoremap jk <ESC>
nnoremap <c-l> O
inoremap <c-l> <esc>O
inoremap <leader>w <esc>:w<cr>
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>w :w<cr>
nnoremap <F2> :mapclear<CR>:imapclear<CR>:source $MYVIMRC<CR>

" Relative line numbers in current tab, absolute in other tabs
set number
if has('autocmd')
augroup vimrc_linenumbering
    autocmd!
    autocmd WinLeave *
                \ if &number |
                \   set norelativenumber |
                \ endif
    autocmd WinEnter *
                \ if &number |
                \   set relativenumber |
                \ endif
    autocmd VimEnter *
                \ if &number |
                \   set relativenumber |
                \ endif
augroup END
endif


" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952
"           /whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
endif

" Automatically toggle 'set paste' when pasting
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" wildmenu
set wildmenu

" Pathogen
execute pathogen#infect()
