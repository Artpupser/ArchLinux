return { "nvim-neo-tree/neo-tree.nvim",
dependencies = {
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
  "nvim-tree/nvim-web-devicons",
},
lazy = false,
config = function ()
  require("neo-tree").setup({
    window = {
      width=28,
      mappings = {
        ["<bs>"] = "noop",
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles=false,
        hide_hidden=false,
      },
    },
  })
end
}
