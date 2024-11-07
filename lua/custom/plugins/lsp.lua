return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      { "j-hui/fidget.nvim", opts = {} },
      --{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

      "b0o/SchemaStore.nvim",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local builtin = require "telescope.builtin"
          vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = event.buf })
          vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = event.buf })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = event.buf })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf })
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local servers = {
        yamlls = {
          settings = {
            yaml = {
              format = { enable = true },
              schemaStore = { enable = false, url = "" },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        vtsls = {
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                  --entriesLimit = 12,
                },
              },
            },
            typescript = {
              preferences = { importModuleSpecifier = "non-relative" },
              updateImportsOnFileMove = { enabled = "always" },
            },
          },
        },

        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      }

      require("mason").setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, { "stylua" })
      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      require("mason-lspconfig").setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }

      --require("lsp_lines").setup()
      --vim.diagnostic.config { virtual_text = true, virtual_lines = false }
      --vim.keymap.set("", "<leader>l", function()
      --  local config = vim.diagnostic.config() or {}
      --  if config.virtual_text then
      --    vim.diagnostic.config { virtual_text = false, virtual_lines = true }
      --  else
      --    vim.diagnostic.config { virtual_text = true, virtual_lines = false }
      --  end
      --end)
    end,
  },
}
