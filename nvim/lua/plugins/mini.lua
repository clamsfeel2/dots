return {
  "echasnovski/mini.jump",
  version = false,
  lazy = false,
  config = function()
    require("mini.jump").setup()
    vim.api.nvim_set_hl(0, "MiniJump", { fg = "#E5C07B", underline = true, bold = true })
  end,
}
