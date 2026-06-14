local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lsp" },
  },
  --snippet = {
  -- expand = function (args)
  -- require("luasnip").lsp_expand(args.body)
  --end
  --}
})

require("nvim-autopairs").setup()

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done()
)
