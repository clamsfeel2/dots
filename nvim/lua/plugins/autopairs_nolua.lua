return {
  "jiangmiao/auto-pairs",
  init = function()
    vim.g.AutoPairsMapBS = 1
    vim.g.AutoPairsMapCR = 1
  end,
  config = function()
    vim.keymap.set("i", "<Right>", "<C-R>=AutoPairsFastWrap()<CR>", {
      silent = true,
      desc = "Fast wrap surrounding pair",
    })
    vim.keymap.set("i", "<C-g>", "<C-R>=AutoPairsJump()<CR>", {
      silent = true,
      desc = "Jump to next matching pair",
    })
  end,
}
