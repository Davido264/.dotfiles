return {
  odoo_lsp = {
    default_config = {
      name = "odoo-lsp",
      cmd = { "odoo-lsp" },
      filetypes = { "javascript", "xml", "python" },
      root_dir = require("lspconfig.util").root_pattern(".odoo_lsp", ".odoo_lsp.json", ".git"),
    },
  },
  termux_language_server = {
    default_config = {
      name = "termux",
      cmd = { "termux-language-server" },
      filetypes = { "sh.termux", "sh.PKGBUILD", "sh.ebuild" },
      single_file_support = true,
    },
  },
}
