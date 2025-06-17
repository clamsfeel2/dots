return {
  "rcarriga/nvim-notify",
  lazy = false,
  config = function()
    local notify = require("notify")
    vim.notify = notify
    notify.setup({
      merge_duplicates = true,
      background_colour = "NotifyBackground",
      fps = 30,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
      level = 2,
      minimum_width = 50,
      render = "minimal",
      stages = "fade",
      timeout = 5000,
      top_down = true,
      time_formats = {
        notification = "%I:%M:%S %p",
        notification_history = "%FT%T%p",
      },
    })
    vim.keymap.set("n", "K", function()
      local hist = notify.history()
      if #hist > 0 then
        notify.dismiss(hist[#hist], { silent = true })
      end
    end, { desc = "Dismiss last nvim-notify message" })
  end,
}
