local by_ft = require("by_ft")
return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = by_ft,
      format_on_save = {
        timeout_ms = 3000,
        lsp_fallback = true,
      },
    })
  end,
}
