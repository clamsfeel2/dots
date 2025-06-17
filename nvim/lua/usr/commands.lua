-- USER COMMANDS
local user_cmds = {
  { "HTML", "lua RunHTMLVimWikiCmd()", opts = { desc = "Convert current Vimwiki to HTML" } },
  { "HTMLALL", "lua RunHTMLVimWikiAllCmd()", opts = { desc = "Convert all Vimwiki to HTML" } },
  { "TOC", "VimwikiTOC", opts = { desc = "Show table of contents" } },
  { "x", "wq", opts = { desc = "Save and quit currnt buffer safer" } },
  { "X", "wqa", opts = { desc = "Save and quit current buffer safer" } },
  { "XA", "wqa!", opts = { desc = "Force save and quit all open buffers" } },
  { "Q", "q!", opts = { desc = "Force quit current buffer without saving" } },
  { "Qa", "qa!", opts = { desc = "Force quit all open buffers without saving" } },
  { "QA", "qa!", opts = { desc = "Force quit all open buffers without saving" } },
  { "QQ", "qa!", opts = { desc = "Force quit all open buffers without saving" } },
  {
    "H",
    "tab help <args> | lua ToggleGoyo()",
    opts = {
      nargs = "+",
      complete = "help",
      desc = "Open help and toggle Goyo",
    },
  },
}

for _, entry in ipairs(user_cmds) do
  local name, rhs, opts = entry[1], entry[2], entry.opts or {}
  if name:match("^[A-Z]") then
    vim.api.nvim_create_user_command(name, rhs, opts)
  else
    -- Abbreviations must be set in command mode, not with create_user_command
    vim.cmd(string.format("cnoreabbrev %s %s", name, rhs))
  end
end

-- AUTO COMMANDS
local augroup = vim.api.nvim_create_augroup("autocmds", { clear = true })
local autocmds = {
  {
    { "BufEnter", "BufNewFile", "BufRead" },
    { "*.txt", "*.md", "*.tex" },
    {
      callback = function()
        vim.opt_local.spell = true
      end,
      desc = "Enable spellcheck in text files",
    },
  },
  {
    "FileType",
    "help",
    {
      callback = function()
        vim.opt_local.spell = false
      end,
      desc = "Disable spellcheck in help",
    },
  },
  { { "BufRead", "BufNewFile" }, "alifn", { command = "set filetype=zsh", desc = "Treat alifn as zsh" } },
  {
    "BufReadPost",
    "*",
    {
      callback = function()
        local pos = vim.api.nvim_buf_get_mark(0, '"')
        if pos[1] > 0 and pos[1] <= vim.api.nvim_buf_line_count(0) then
          pcall(vim.api.nvim_win_set_cursor, 0, pos)
        end
        vim.cmd("normal! zz")
      end,
      desc = "Restore last cursor position",
    },
  },
  {
    "InsertEnter",
    "*",
    {
      command = "match none",
      desc = "Disable trailing whitespace highlight in insert mode",
    },
  },
  {
    "InsertLeave",
    "*",
    { command = "match ExtraWhitespace /\\s\\+$/", desc = "Highlight trailing whitespace in normal mode" },
  },
  {
    "TextYankPost",
    "*",
    {
      callback = function()
        vim.hl.on_yank({ higroup = "YankHighlight" })
      end,
      desc = "Highlight on yank",
    },
  },
}

for _, a in ipairs(autocmds) do
  local event, pattern, opts = a[1], a[2], a[3]
  opts = vim.tbl_extend("force", { group = augroup, pattern = pattern }, opts)
  vim.api.nvim_create_autocmd(event, opts)
end
