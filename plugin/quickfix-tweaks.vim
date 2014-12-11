if exists('g:loaded_quickfix_tweaks') || &compatible
  finish
else
  let g:loaded_quickfix_tweaks = 1
endif

command -nargs=1 SaveQuickFixList call SaveQuickFixList(<f-args>)

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

