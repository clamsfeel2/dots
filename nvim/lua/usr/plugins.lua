local lazy = {}

function lazy.install(path)
  -- If the directory does not exist, create its parent and clone into it
  local uv = vim.uv
  if not uv.fs_stat(path) then
    print("Installing lazy plugins manager...")
    vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      path,
    })
    print("Installed lazy.nvim to " .. path)
  end
end

lazy.path = table.concat({
  vim.fn.stdpath("data"),
  "lazy",
  "lazy.nvim",
}, "/")
lazy.opts = {
  ui = { border = "rounded" },
  install = { missing = true },
  change_detection = { enabled = false, notify = false },
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
}

function lazy.setup(plugins)
  lazy.install(lazy.path)
  vim.opt.rtp:prepend(lazy.path)
  require("lazy").setup(plugins, lazy.opts)
end

local plugins = { { import = "plugins" } }
lazy.setup(plugins)
