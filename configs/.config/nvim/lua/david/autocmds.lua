vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 100,
    }
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.opt.cursorline = true

    vim.api.nvim_set_hl(0, "CursorLineNR", {
      bold = true,
    })

    if vim.fn.exists "g:neovide" == 0 then
      vim.api.nvim_set_hl(0, "Normal", {
        bg = "none",
        ctermbg = "none",
      })
    end

    vim.api.nvim_set_hl(0, "SpellBad", {
      undercurl = true,
      bold = true,
    })
  end,
})

-- neovim for writting
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "tex", "gitcommit" },
  callback = function()
    require("david.keymaps").bmap("n", "z=", "<Cmd>Telescope spell_suggest<CR>", { silent = true })
    local set = vim.opt_local
    set.spell = true
    set.spelllang = { "en", "es" }
    set.spellfile = {
      vim.fn.stdpath "config" .. "/spell/es.utf-8.add",
      vim.fn.stdpath "config" .. "/spell/en.utf-8.add",
    }
    set.wrap = true
    set.linebreak = true
    set.breakindent = true
    set.listchars = "eol:⏎,tab:▸·,trail:×,nbsp:⎵"
    set.breakindentopt = "shift:2,min:40,sbr"
  end,
})

-- xaml to xml
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufNewFile" }, {
  pattern = { "*.xaml" },
  callback = function()
    vim.opt_local.filetype = "xml"
  end,
})

-- tf to terraform
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufNewFile" }, {
  pattern = { "*.tf" },
  callback = function()
    vim.opt_local.filetype = "terraform"
  end,
})

-- define ft for termux-language-server to terraform
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufNewFile" }, {
  pattern = {
    "build.sh",
    "*.subpackage.sh",
  },
  callback = function()
    vim.opt_local.filetype = "sh.termux"
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufNewFile" }, {
  pattern = {
    "PKGBUILD",
    "*.install",
    "makepkg.conf",
  },
  callback = function()
    vim.opt_local.filetype = "sh.PKGBUILD"
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufNewFile" }, {
  pattern = {
    "*.ebuild",
    "*.eclass",
    "color.map",
    "make.conf",
  },
  callback = function()
    vim.opt_local.filetype = "sh.ebuild"
  end,
})

-- no diagnostics on repl
vim.api.nvim_create_autocmd("BufNewFile", {
  group = vim.api.nvim_create_augroup("conjure_log_disable_lsp", { clear = true }),
  pattern = { "conjure-log-*" },
  callback = function()
    vim.diagnostic.disable(0)
  end,
  desc = "Conjure Log disable LSP diagnostics",
})
