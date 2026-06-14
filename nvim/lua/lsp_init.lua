local servers = require("lsp_servers")

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("solargraph", {
  cmd = { vim.fn.exepath("solargraph"), "stdio" },

  root_markers = {
    "Gemfile",
    ".git",
    ".solargraph.yml",
  },

  settings = {
    solargraph = {
      diagnostics = true,
      completion = true,
      formatting = true,
    },
  },

  init_options = {
    formatting = true,
  },
})

vim.lsp.enable("solargraph")

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end


local lsp_signature = require("lsp_signature")

lsp_signature.setup({
  hint_enable = true,
  hint_prefix = "💡",
  hi_parameter = "LspSignatureActiveParameter",
  floating_window = true,
  bind = true,
  handler_opts = { border = "rounded", },
  max_height = 30,
  max_width = 80,
})



vim.filetype.add({
  extension = {
    ["xaml"] = "xml",
    ["rb"] = "ruby",
    ["cs"] = "cs",
  }
})
