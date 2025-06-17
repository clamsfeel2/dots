return {
  "tpope/vim-eunuch",
  "tpope/vim-endwise",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  {
    "tpope/vim-commentary",
    config = function()
      vim.keymap.set("n", "<C-p>", "yy<Plug>CommentaryLine p", {
        desc = "Comment current line and paste un-commented copy below",
        silent = true,
      })
    end,
  },
}
