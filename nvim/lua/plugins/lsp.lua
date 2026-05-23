return {

  -- Mason : installe les binaires LSP
  {
    "williamboman/mason.nvim",
    cmd  = "Mason",
    opts = {
      ui = {
        border = "rounded",
        icons  = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Pont Mason <-> lspconfig (gère ensure_installed)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "bashls",
        "pyright",
        "yamlls",
        "terraformls",
        "ansiblels",
        "helm_ls",
        "dockerls",
        "docker_compose_language_service",
      },
      automatic_installation = true,
    },
  },

  -- nvim-lspconfig : fournit les configs par défaut des serveurs
  -- On ne l'appelle plus directement, il est chargé automatiquement
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
  },

  -- Configuration LSP avec la nouvelle API 0.11
  {
    "hrsh7th/cmp-nvim-lsp",  -- doit être chargé avant qu'on configure les LSP
    event = "BufReadPre",
    config = function()

      -- Capacités étendues pour la complétion
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Keymaps au moment où un LSP s'attache
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
          end

          map("gd",         vim.lsp.buf.definition,     "Goto définition")
          map("gD",         vim.lsp.buf.declaration,    "Goto déclaration")
          map("gr",         vim.lsp.buf.references,     "Goto références")
          map("gi",         vim.lsp.buf.implementation, "Goto implémentation")
          map("K",          vim.lsp.buf.hover,          "Doc hover")
          map("<leader>rn", vim.lsp.buf.rename,         "Renommer symbole")
          map("<leader>ca", vim.lsp.buf.code_action,    "Code action")
          map("<leader>d",  vim.diagnostic.open_float,  "Diagnostics ligne")
          map("[d",         vim.diagnostic.goto_prev,   "Diagnostic précédent")
          map("]d",         vim.diagnostic.goto_next,   "Diagnostic suivant")
        end,
      })

      -- Apparence des diagnostics
      vim.diagnostic.config({
        virtual_text        = true,
        signs               = true,
        underline           = true,
        update_in_insert    = false,
        severity_sort       = true,
        float               = { border = "rounded" },
      })

      -- Configs serveurs avec vim.lsp.config (API 0.11)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace   = { checkThirdParty = false },
            telemetry   = { enable = false },
          },
        },
      })

      vim.lsp.config("bashls", {
        capabilities = capabilities,
      })

      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = { typeCheckingMode = "basic" },
          },
        },
      })

      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        settings = {
          yaml = {
            keyOrdering = false,
            schemas = {
              kubernetes = {
                "k8s/**/*.yaml",
                "manifests/**/*.yaml",
                "kubernetes/**/*.yaml",
              },
              ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yml",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
                "docker-compose*.yml",
                "docker-compose*.yaml",
              },
            },
          },
        },
      })

      vim.lsp.config("terraformls", {
        capabilities = capabilities,
      })

      vim.lsp.config("ansiblels", {
        capabilities = capabilities,
        settings = {
          ansible = {
            ansible    = { path = "ansible" },
            validation = { enabled = true, lint = { enabled = true } },
          },
        },
      })

      vim.lsp.config("helm_ls", {
        capabilities = capabilities,
      })

      vim.lsp.config("dockerls", {
        capabilities = capabilities,
      })

      vim.lsp.config("docker_compose_language_service", {
        capabilities = capabilities,
      })

      -- Active tous les serveurs configurés
      vim.lsp.enable({
        "lua_ls",
        "bashls",
        "pyright",
        "yamlls",
        "terraformls",
        "ansiblels",
        "helm_ls",
        "dockerls",
        "docker_compose_language_service",
      })

    end,
  },

  -- Moteur d'autocomplétion (inchangé)
  {
    "hrsh7th/nvim-cmp",
    event        = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"]     = cmp.mapping.select_next_item(),
          ["<C-p>"]     = cmp.mapping.select_prev_item(),
          ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<CR>"]      = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip",  priority = 750  },
          { name = "buffer",   priority = 500  },
          { name = "path",     priority = 250  },
        }),
        formatting = {
          format = function(entry, item)
            local labels = {
              nvim_lsp = "[LSP]",
              luasnip  = "[Snip]",
              buffer   = "[Buf]",
              path     = "[Path]",
            }
            item.menu = labels[entry.source.name] or ""
            return item
          end,
        },
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = "path" } },
          { { name = "cmdline" } }
        ),
      })
    end,
  },
}
