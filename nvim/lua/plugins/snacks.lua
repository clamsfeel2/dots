return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    terminal = { enabled = true },
  },
  keys = {
    {
      "<C-/>",
      function()
        require("snacks").terminal()
      end,
      desc = "Toggle Snacks Terminal",
      mode = { "n", "t" },
      silent = true,
    },
  },
}
