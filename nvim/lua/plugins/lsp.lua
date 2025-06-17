return {
  -- =============================================================================
  -- Mason + mason-lspconfig: install & automatically configure all servers
  -- =============================================================================
  {
    "williamboman/mason.nvim",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "pyright", -- switch to jedi_language_server when you can
        "eslint",
        "html",
        "cssls",
        "emmet_ls",
        "clangd",
        "rust_analyzer",
        "gopls",
        "jsonls",
        "yamlls",
        "lua_ls",
        "bashls",
      },
      automatic_enable = true,
      automatic_installation = true,
    },
    config = function(_, opts)
      -- Set up diagnostic ui before any servers attach
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 3, source = "if_many", prefix = "●" },
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        signs = true,
      })

      -- Call mason-lspconfig with the opts table above
      require("mason-lspconfig").setup(opts)
      -- Get rid of undefined global vim
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = {
                "vim", -- The global vim API object for Neovim
                "Status", -- Yazi status line/table global
                "ya", -- Yazi main plugin API (notifications, clipboard, ...)
                "ui", -- Yazi user interface helpers (Span, Line, Icon, ...)
                "cx", -- Yazi context (current tab, selected, hovered, ...)
                "Tab", -- Yazi represents the current tab (panel) context (files, selection, navigation, etc.)
              },
            },
          },
        },
      })

      -- Create LspAttach autocmd for keymaps + inlay hints
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          opts = { buffer = bufnr, silent = true }

          -- Toggle hover or close floating if open
          vim.keymap.set("n", "<leader>ch", function()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local cfg = vim.api.nvim_win_get_config(win)
              if cfg.relative and cfg.relative ~= "" then
                vim.api.nvim_win_close(win, true)
                return
              end
            end
            vim.lsp.buf.hover()
          end, {
            desc = "Toggle lsp hover for symbol under cursor",
            buffer = bufnr,
          })
          vim.keymap.set("n", "<leader>cd", function()
            vim.diagnostic.open_float(nil, { focus = false })
          end, {
            desc = "Show all diagnostics for symbol under cursor",
          })
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {
            buffer = bufnr,
            silent = true,
            desc = "Rename symbol",
          })

          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
            buffer = bufnr,
            silent = true,
            desc = "Perform code action",
          })

          vim.keymap.set("n", "<leader>cs", vim.lsp.buf.signature_help, {
            buffer = bufnr,
            silent = true,
            desc = "Show signature help",
          })

          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
            buffer = bufnr,
            silent = true,
            desc = "Go to previous diagnostic",
          })

          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
            buffer = bufnr,
            silent = true,
            desc = "Go to next diagnostic",
          })

          if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable and args.data and args.data.client_id then
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client:supports_method("textDocument/inlayHint") then
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
          end
        end,
      })
    end,
  },

  -- =============================================================================
  -- Formatter: conform.nvim
  -- =============================================================================
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "black" },
          lua = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          markdown = { "prettier" },
          bash = { "shfmt" },
          zsh = { "shfmt" },
          yaml = { "prettier" },
          toml = { "taplo" },
        },
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end,
  },

  -- =============================================================================
  -- Autocomplete: blink.cmp
  -- =============================================================================
  {
    "Saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    opts = {
      snippets = { preset = "luasnip" },
      keymap = {
        preset = "none",
        ["<Down>"] = {
          function(cmp)
            return cmp.select_next()
          end,
          "fallback",
        },
        ["<Tab>"] = {
          function(cmp)
            return cmp.select_next()
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            return cmp.select_prev()
          end,
          "fallback",
        },
        ["<Up>"] = {
          function(cmp)
            return cmp.select_prev()
          end,
          "fallback",
        },
        ["<C-Space>"] = {
          function(cmp)
            return cmp.select_and_accept()
          end,
          "fallback",
        },
      },
      appearance = { nerd_font_variant = "mono" },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
    },
  },
}
