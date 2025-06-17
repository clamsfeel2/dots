return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<RightMouse>"] = actions.close,
            ["<LeftMouse>"] = actions.select_default,
            ["<ScrollWheelDown>"] = actions.move_selection_next,
            ["<ScrollWheelUp>"] = actions.move_selection_previous,
          },
        },
      },
    })
    vim.keymap.set("n", "<leader>m", ":Telescope marks<CR>", {
      desc = "List all marks",
    })
    vim.keymap.set("n", "<leader>v", ":Telescope commands<CR>", {
      desc = "List available commands",
    })
    vim.keymap.set("n", "<leader>b", ":Telescope buffers<CR>", {
      desc = "List open buffers",
    })
    vim.keymap.set("n", "<leader>?", ":Telescope help_tags<CR>", {
      desc = "Search help tags",
    })
    vim.keymap.set("n", "<leader>f", ":Telescope filetypes<CR>", {
      desc = "Set filetype",
    })
    vim.keymap.set("n", "<leader>t", ":Telescope current_buffer_tags<CR>", {
      desc = "Search tags in current buffer",
    })
    vim.keymap.set("n", "<leader>s", ":Telescope spell_suggest<CR>", {
      desc = "Suggest previous spelling corrections",
    })
    vim.keymap.set("n", "<leader>S", ":Telescope spell_suggest<CR>", {
      desc = "Suggest next spelling corrections",
    })
    vim.keymap.set("n", "z=", ":Telescope spell_suggest<CR>", {
      desc = "Suggest spelling corrections",
    })
    vim.keymap.set("n", "<leader>tt", function()
      require("telescope.builtin").tags({
        ctags_file = vim.fn.expand("~/.cache/nvim/ctags/" .. vim.fn.getcwd():gsub("/", "-"):sub(2) .. "-tags"),
      })
    end, {
      desc = "List project tags",
    })

    vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#3a3a3a", fg = "#ffffff" })
  end,
}
