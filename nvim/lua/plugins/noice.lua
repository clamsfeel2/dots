return {
  "folke/noice.nvim",
  event = "VeryLazy",
  init = function()
    -- COLORING
    vim.api.nvim_set_hl(0, "MyNotifyBackground", { bg = "NONE", fg = "#cdd6f4" })
    vim.api.nvim_set_hl(0, "MyNotifyBorder", { fg = "#89b4fa", bg = "#ffffff" })
    vim.api.nvim_set_hl(0, "NoiceMini", { bg = "NONE", fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", fg = "#cdd6f4" }) -- for hover
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#89b4fa", bg = "NONE" })
    -- KEYMAPS
    vim.keymap.set("n", "<leader>m", ":messages<CR>", {
      desc = "Show noice message history",
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    routes = {
      {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      },
    },
    notify = {
      enabled = true,
      view = "notify",
      opts = {
        timeout = 5000,
      },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      progress = {
        enabled = true,
        view = "mini",
      },
      hover = {
        enabled = true,
      },
      signature = {
        auto_open = {
          enabled = false,
        },
        enabled = true,
      },
      message = {
        enabled = true,
        view = "notify",
      },
      documentation = {
        view = "notify",
        opts = {
          lang = "markdown",
          render = "plain",
          format = {
            "{message}",
          },
          win_options = {
            concealcursor = "n",
            conceallevel = 3,
          },
        },
      },
    },
    presets = {
      bottom_search = false,
      command_palette = false,
      long_message_to_split = false,
      inc_rename = false,
      lsp_doc_border = false,
    },
    cmdline = {
      enabled = true,
      view = "cmdline",
    },
    messages = {
      enabled = true,
      view = "notify",
      view_error = "notify",
      view_warn = "notify",
      view_history = "messages",
      view_search = "virtualtext",
    },
    popupmenu = {
      enabled = true,
      backend = "nui",
    },
    redirect = {
      view = "popup",
      filter = {
        event = "msg_show",
      },
    },
    health = {
      checker = true,
    },
    throttle = 1000 / 30,
    views = {
      cmdline_popup = {
        style = "none",
        border = {
          style = "none",
          padding = { 1, 1 },
        },
        filter_options = {},
        win_options = {
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
      },
      mini = {
        timeout = 5000,
        position = {
          row = -2,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
      },
      notify = {
        timeout = 5000,
        win_opts = {
          winhighlight = {
            Normal = "MyNotifyBackground",
            FloatBorder = "MyNotifyBorder",
          },
        },
      },
    },
  },
}
