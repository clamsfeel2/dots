return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    "folke/snacks.nvim",
  },
  keys = {
    {
      "<leader>y",
      "<cmd>Yazi<CR>",
      desc = "Open Yazi",
    },
  },
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = "<f1>",
      open_file_in_vertical_split = "<C-v>",
      open_file_in_horizontal_split = "<C-x>",
      open_file_in_tab = "<C-t>",
      grep_in_directory = "<C-s>",
      replace_in_directory = "<C-g>",
      cycle_open_buffers = "<TAB>",
      copy_relative_path_to_selected_files = "<C-y>",
      send_to_quickfix_list = "<C-q>",
      change_working_directory = "<C-\\>",
      open_and_pick_window = "<C-o>",
    },
  },
  -- if using open_for_directories=true keep this init func
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
}
