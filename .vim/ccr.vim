" Taken from https://gist.github.com/romainl/5b2cfb2b81f02d44e1d90b74ef555e31

" Background here: https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
" with help from https://github.com/teoljungberg

function! CCR()
    let cmdline = getcmdline()
    let filter_stub = '\v\C^((filt|filte|filter) .+ )*'
    command! -bar Z silent set more|delcommand Z
    if getcmdtype() !~ ':'
        return "\<CR>"
    endif
    if cmdline =~ filter_stub . '(ls|files|buffers)$'
        " like :ls but prompts for a buffer command
        return "\<CR>:b"
    elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number|l|li|lis|list)$'
        " like :g//# but prompts for a command
        return "\<CR>:"
    elseif cmdline =~ filter_stub . '(\%)*(#|nu|num|numb|numbe|number|l|li|lis|list)$'
        " like :g//# but prompts for a command
        return "\<CR>:"
    elseif cmdline =~ '\v\C^(dli|il)'
        " like :dlist or :ilist but prompts for a count for :djump or :ijump
        return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
    elseif cmdline =~ filter_stub . '(cli)'
        " like :clist or :llist but prompts for an error/location number
        return "\<CR>:sil cc\<Space>"
    elseif cmdline =~ filter_stub . '(lli)'
        " like :clist or :llist but prompts for an error/location number
        return "\<CR>:sil ll\<Space>"
    elseif cmdline =~ filter_stub . 'old'
        " like :oldfiles but prompts for an old file to edit
        set nomore
        return "\<CR>:Z|e #<"
    elseif cmdline =~ filter_stub . 'changes'
        " like :changes but prompts for a change to jump to
        set nomore
        return "\<CR>:Z|norm! g;\<S-Left>"
    elseif cmdline =~ filter_stub . 'ju'
        " like :jumps but prompts for a position to jump to
        set nomore
        return "\<CR>:Z|norm! \<C-o>\<S-Left>"
    elseif cmdline =~ filter_stub . 'marks'
        " like :marks but prompts for a mark to jump to
        return "\<CR>:norm! `"
    elseif cmdline =~ '\v\C^undol'
        " like :undolist but prompts for a change to undo
        return "\<CR>:u "
    elseif cmdline =~ '\v\C^tabs'
        set nomore
        return "\<CR>:Z| tabnext\<S-Left>"
    elseif cmdline =~ '^\k\+$'
        " handle cabbrevs gracefully
        " https://www.reddit.com/r/vim/comments/jgyqhl/nightly_hack_for_vimmers/
        return "\<C-]>\<CR>"
    else
        return "\<CR>"
    endif
endfunction

cnoremap <expr> <CR> CCR()
