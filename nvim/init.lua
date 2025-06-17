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

vim.cmd.colorscheme("clamtheme")
