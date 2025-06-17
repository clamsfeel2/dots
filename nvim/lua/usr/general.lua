vim.opt.rtp:append("/opt/homebrew/opt/fzf")
local home = os.getenv("HOME")
vim.opt.runtimepath:append(home .. "/.config/nvim")
vim.opt.shada = [[!,'100,<50,@50,s10]]
vim.opt.shadafile = home .. "/.local/share/nvim/shada/main.shada"
vim.opt.directory = home .. "/.local/state/nvim/swap//"
vim.fn.setenv("ZSH_ENV", vim.fn.expand("$HOME/.config/zsh/alifn"))
vim.cmd("filetype plugin indent on")

local opts = {
  encoding = "utf-8",
  compatible = false,
  backspace = { "indent", "eol", "start" },
  number = true,
  relativenumber = true,
  title = true,
  ruler = true,
  showmatch = true,
  wrap = true,
  linebreak = true,
  mouse = "a",
  modeline = true,
  cursorline = true,
  termguicolors = true,
  background = "dark",
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  autoindent = true,
  shiftround = true,
  textwidth = 0,
  wildmenu = true,
  timeoutlen = 200,
  updatetime = 100,
  guicursor = "n-v:block,i-c:ver25,r-cr:hor20",
}

for k, v in pairs(opts) do
  vim.opt[k] = v
end

vim.opt.display:append("lastline")
vim.opt.matchpairs:append({ "(:)", "{:}", "[:]", "<:>" })
vim.opt.completeopt:remove("preview")
vim.opt.path:append("**")
vim.g.netrw_banner = 0
