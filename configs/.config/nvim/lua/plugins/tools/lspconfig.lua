return {
  "neovim/nvim-lspconfig",
  cmd = "LspInfo",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      severity_sort = true,
    },
    -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
    -- Be aware that you also will need to properly configure your LSP server to
    -- provide the inlay hints.
    inlay_hints = {
      enabled = true,
    },
    -- add any global capabilities here
    capabilities = {},
    -- options for vim.lsp.buf.format
    -- `bufnr` and `filter` is handled by the LazyVim formatter,
    -- but can be also overridden when specified
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
    setup = {
      ["jdtls"] = require("david.lsp.jdtls").setup,
      ["eslint"] = false,
    },
  },
  config = function(_, opts)
    require "david.lsp.lsp_attach"

    local _border = "rounded"
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = _border,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = _border,
    })

    vim.diagnostic.config {
      float = {
        border = _border,
      },
    }

    require("lspconfig.ui.windows").default_options = {
      border = _border,
    }

    local lspconfig = require "lspconfig"
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local server_configs = require "david.lsp.custom_server_configs"
    local defaults = {
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities),
    }

    local function setup(server)
      if type(opts.setup[server]) == "function" then
        opts.setup[server]()
      elseif opts.setup[server] ~= false then
        local config = vim.tbl_deep_extend("force", defaults, server_configs(server))
        lspconfig[server].setup(config)
      end
    end

    local servers = require "david.lsp.server_list"
    for _, name in ipairs(servers) do
      setup(name)
    end
  end,
  dependencies = {
    { "Hoffs/omnisharp-extended-lsp.nvim" },
    { "b0o/schemastore.nvim" },
    {
      "mfussenegger/nvim-jdtls",
      module = false,
    },
  },
}
