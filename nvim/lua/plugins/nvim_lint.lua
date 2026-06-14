local by_ft = require("by_ft")
return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    lint.linters.rubocop.cmd = vim.fn.expand("~/.rbenv/shims/rubocop")
    lint.linters_by_ft = by_ft
    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufEnter" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end
}
