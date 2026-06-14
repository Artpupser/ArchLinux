vim.opt.number = true
--vim.opt.relativeNumber = true
vim.o.guifont = "JetBrainsMono Nerd Font:h18"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.wrap = true
vim.opt.cursorlineopt = "line"
vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 6
vim.opt.showmode = true

vim.diagnostic.config({
  float = {
    border = "rounded",
    source = true,
    max_width = 80,
    header = "",
    prefix = "●",
  },
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.INFO]  = "",
      [vim.diagnostic.severity.HINT]  = "",
    },
  },
  severity_sort = true,
  update_in_insert = true,
  virtual_text = {
    current_lien = true,
    spacing = 0,
    source = true,
  }
})

vim.lsp.config("ruby_lsp", {
  cmd = { vim.fn.expand("~/.local/share/gem/ruby/3.4.0/bin/ruby-lsp") },
})

vim.lsp.buf.hover({
  border = "rounded",
  max_width = 80,
})

vim.lsp.handlers["textDocument/signatureHelp"] = function() end
