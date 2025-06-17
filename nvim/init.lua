-- vim.g.mason_lspconfig_setup_handlers = 0

vim.g.mapleader = " "

local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load("usr.general")
load("usr.plugins")
load("usr.commands")
load("usr.functions")
load("usr.keybinds")

-- Set runtimepath if needed (rare for most users)
if vim.fn.isdirectory("/opt/homebrew/share/vim/vim91/syntax") == 1 then
  vim.opt.runtimepath:prepend("/opt/homebrew/share/vim/vim91/syntax")
end

vim.cmd.colorscheme("clamtheme") -- If you converted your .vim to .lua theme via :h lua-colorschemes

-- require("autocmds") -- Loads your Lua autocommands
