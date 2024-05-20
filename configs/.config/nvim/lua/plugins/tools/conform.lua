return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>vfm",
      function()
        require("conform").format { async = true, lsp_fallback = true }
      end,
      mode = "n",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters = {
      alejandra = {
        command = "alejandra",
        args = { "-qq" },
      },
      yml = {
        env = {
          YAMLFIX_SEQUENCE_STYLE = "block_style",
        },
      },
    },
    formatters_by_ft = {
      sh = { "shfmt" },
      bash = { "shfmt" },
      lua = { "stylua" },
      python = { "black" },
      javascript = { { "prettier", "prettierd" } },
      typescript = { { "prettier", "prettierd" } },
    },
  },
}
