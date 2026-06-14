return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.config").setup({
      ensure_installed = {
        "lua",
        "xml",
        "ruby",
        "rust",
        "json",
        "yaml",
        "python",
        "javascript",
        "c_sharp",
        "markdown"
      },
      highlight = { enable = true },
      indent = { enable = true }
    })
    end,
  }
