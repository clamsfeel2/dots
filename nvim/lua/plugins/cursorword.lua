return {
  "itchyny/vim-cursorword",
  init = function()
    vim.g.cursorword_delay = 0
  end,
  config = function()
    local group = vim.api.nvim_create_augroup("CursorWordControl", { clear = true })
    vim.api.nvim_create_autocmd("InsertEnter", {
      pattern = "*",
      group = group,
      callback = function()
        vim.b.cursorword = 0
      end,
    })
    vim.api.nvim_create_autocmd("InsertLeave", {
      pattern = "*",
      group = group,
      callback = function()
        vim.b.cursorword = 1
      end,
    })
  end,
}
