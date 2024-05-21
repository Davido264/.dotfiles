return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  build = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "MasonToolsStartingInstall",
      callback = function()
        local treesitter_finished = false
        -- Note to myself.
        -- This registers a callback on the event MasonToolsUpdateCompleted. Which raises when all mason
        -- tools defined in `ensure_installed` are installed.
        -- The callback checks for the message "[nvim-treesitter] [%i/%i]..." which is a message that treesitter
        -- logs during the process of installing a new parser, when the process finishes, the log message starts
        -- with "[nvim-treesitter] [%i/%i]..." and ends with "installed", So, if the last parser was installed
        -- correctly, the regex will capture both "%i" (asuming "%i" is an integer) and compare them. If they are
        -- the same, it quits as this means all parsers of treesitter are installed. 
        -- HOWEVER
        -- If the las parser fails, it will be stuck on an infinite loop. The solution to this is:
        --    1. More regexes
        --    2. Capture the last word to take in count "installed" and whatever term nvim-treesiteer uses to tell
        --       things went wrong
        --    3. Not check at all, leading to race conditions, because this event will quit neovim
        --    4. Contribute to nvim-treesitter to include this event and have a less hacky solution using vim variables
        -- 
        -- TODO: When I have the time, go for the option 4, https://github.com/nvim-treesitter/nvim-treesitter/issues/2900 had
        -- the same problem almost 2 years ago
        --
        vim.api.nvim_create_autocmd("User", {
          pattern = "MasonToolsUpdateCompleted",
          callback = function()
            vim.schedule(function()
              while true do
                local messages = vim.split(vim.fn.execute("messages", "silent"), "\n")
                for _, val in ipairs(messages) do
                  local g1, g2 = string.match(val, "%[nvim%-treesitter%]%s+%[(%d+)%/(%d+).*%].*installed")
                  if g1 ~= nil then
                    if g1 == g2 then
                      treesitter_finished = true
                      vim.uv.sleep(10)
                    end
                  end
                end

                if treesitter_finished then
                  break
                end

                -- Sleep for 2 min
                vim.uv.sleep(60000)
              end

              vim.cmd [[:qa]]
            end)
          end,
        })
      end,
    })
    require("mason-tool-installer").check_install(false)
  end,
  config = true,
  dependencies = {
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = {
        ensure_installed = {
          -- Ansible
          "ansible-language-server",
          "ansible-lint",

          -- Bash/sh
          "bash-language-server",
          "shellcheck",
          "shfmt",

          -- C/C++
          "clangd",
          "cmake-language-server",

          -- Clojure/babashka
          "clj-kondo",
          "clojure-lsp",

          -- Go
          "gopls",
          "golangci-lint",
          "delve",

          -- Java
          "jdtls",

          -- Kotlin
          "kotlin-language-server",

          -- Lua
          "lua-language-server",
          "selene",
          "stylua",

          -- C#
          "omnisharp",
          "netcoredbg",

          -- Python
          "pyright",
          "pylint",
          "black",
          "debugpy",

          -- LaTeX
          "texlab",

          -- Javascript/Typescript
          "typescript-language-server",
          "eslint_d",
          "prettier",
          "node-debug2-adapter",
          "firefox-debug-adapter",

          -- HTML/CSS/JSON/YAML/Commit
          "css-lsp",
          "html-lsp",
          "json-lsp",
          "yaml-language-server",
          "commitlint",

          -- Rust
          "rust-analyzer",

          ---- Rarely using ----
          -- Dart (Included with dart)
          --
          -- F#
          -- "fsautocomplete",
          --
          -- Tailwindcss
          -- "tailwindcss-language-server",
          --
          -- Powershell
          -- "powershell-editor-services",
          --
          -- Prisma.js
          -- "prisma-language-server",
          --
          -- Minecraft mcfunction
          -- "spyglassmc-language-server",
        },
        integrations = {
          ["mason-lspconfig"] = true,
          ["mason-null-ls"] = true,
          ["mason-nvim-dap"] = true,
        },
        run_on_start = false,
      },
      config = true,
    },
  },
}
