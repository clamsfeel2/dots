return {
  "junegunn/goyo.vim",
  init = function()
    vim.g.goyo_width = 80
    vim.g.goyo_height = 100
    vim.g.goyo_linenr = 1
    vim.g.goyo_linenr = 0
  end,
  config = function()
    vim.keymap.set("n", "<leader>g", ":lua ToggleGoyo()<CR>", {
      desc = "Toggle Goyo",
    })
    _G.ToggleGoyo = function()
      local lualine = require("lualine")
      if vim.g.goyo_running ~= nil then
        -- Turn off Goyo
        vim.cmd("Goyo!")
      else
        _G._laststatus = vim.o.laststatus
        require("lualine").hide({ place = { "statusline" }, unhide = false })
        vim.cmd("set laststatus=0")
        vim.cmd("Goyo")
      end
    end
    -- Makes sure Goyo closes buffer on quit
    vim.api.nvim_create_autocmd("User", {
      pattern = "GoyoEnter",
      callback = function(args)
        vim.b.quitting = false
        vim.api.nvim_create_autocmd("QuitPre", {
          buffer = 0,
          once = true,
          callback = function()
            vim.b.quitting = true
          end,
          desc = "Set quitting flag on QuitPre in Goyo",
        })
      end,
      desc = "Setup Goyo buffer quitting flag",
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "GoyoLeave",
      callback = function()
        if vim.b.quitting then
          vim.cmd("qa")
        end
      end,
      desc = "Quit all on Goyo leave if buffer was quitting",
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "GoyoLeave",
      desc = "Restore clamtheme colorscheme and lualine when exiting Goyo",
      callback = function()
        vim.cmd("colorscheme clamtheme")
        if _G._laststatus then
          vim.o.laststatus = _G._laststatus
        end
        local lualine = require("lualine")
        lualine.setup(lualine.get_config())
      end,
    })
  end,
}
