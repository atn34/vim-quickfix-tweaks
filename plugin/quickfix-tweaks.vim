if exists('g:loaded_quickfix_tweaks') || &compatible
  finish
else
  let g:loaded_quickfix_tweaks = 1
endif

command -nargs=1 -complete=file SaveQuickFixList call SaveQuickFixList(<f-args>)
command -nargs=0 AddLineToQuickFix call AddLineToQuickFix()

function SaveQuickFixList(fname)
  let qflist = getqflist()
  let result = []
  for entry in qflist
    let entry.filename = fnamemodify(bufname(entry.bufnr), ':p')
    unlet entry.bufnr
    call add(result, entry.filename . ':' . entry.lnum . ':' . entry.col . ': ' . entry.text)
  endfor
  call writefile(result, a:fname)
endfunction

function AddLineToQuickFix()
  caddexpr expand('%') . ':' . line('.') .  ': ' . getline('.')
endfunction
