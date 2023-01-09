vim.cmd [[
  augroup highlight_yank
      autocmd!
      au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=500 }
  augroup END

  autocmd BufNewFile,BufRead *.md setlocal linebreak wrap
]]
