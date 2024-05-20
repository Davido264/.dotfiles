return {
  ["gopls"] = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },
  ["jsonls"] = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  ["lua_ls"] = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
        format = {
          enable = true,
          -- Put format options here
          -- NOTE: the value should be STRING!!
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
          },
        },
      },
    },
  },
  ["nixd"] = {
    settings = {
      nixd = {
        nixpkgs = {
          expr = "import <nixpkgs> { }",
        },
        formatting = {
          command = { "nixpkgs-fmt" },
        },
        options = {
          -- For option autocomplete. 'options' will have all options defined by modules
          nixos = {
            expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.laptop.options',
          },

          -- For flake-parts opitons.
          -- Firstly read the docs here to enable "debugging", exposing declarations for nixd.
          -- https://flake.parts/debug
          ["flake-parts"] = {
            expr = '(builtins.getFlake "/path/to/your/flake").currentSystem.options',
          },
        },
      },
    },
  },
  ["omnisharp"] = {
    handlers = {
      ["textDocument/definition"] = require("omnisharp_extended").definition_handler,
      ["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
      ["textDocument/references"] = require("omnisharp_extended").references_handler,
      ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
    },
    organize_imports_on_format = true,
  },
  ["prettier"] = {
    autostart = false,
  },
  ["powershell_es"] = {
    -- bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
  },
  ["pyright"] = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
        },
      },
    },
  },
  ["tailwindcss"] = {
    autostart = false,
  },
  ["tsserver"] = {
    init_options = {
      preferences = {
        disableSuggestions = true,
      },
    },
  },
  ["yamlls"] = {
    settings = {
      yaml = {
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
}
