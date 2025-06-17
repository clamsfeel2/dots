vim.g.mapleader = " "
-- mode, lhs, rhs, opts
local keymaps = {
  -- ==============================
  -- GENERAL
  -- ==============================
  { "n", "<leader>o", ":lua OpenKittyDoc()<CR>", {
    desc = "Open Kitty documentation",
  } },
  { "n", "<Esc>", ":nohlsearch<CR>", {
    desc = "Clear search highlight",
  } },
  { "n", "gs", ":%s#<C-r><C-w>##g<Left><Left>", {
    desc = "Substitute word under cursor (# delimiter)",
  } },
  {
    "n",
    "<C-s>",
    ":%s/<C-r><C-w>//g<Left><Left>",
    {
      desc = "Substitute word under cursor (/ delimiter)",
    },
  },
  { { "n", "v" }, "<C-c>", '"+y', { desc = "Yank to system clipboard" } },
  -- ==============================
  -- TAB NAVIGATION
  -- ==============================
  { "n", "<leader>l", "gt", {
    desc = "Go to next tab",
  } },
  { "n", "<leader>h", "gT", {
    desc = "Go to previous tab",
  } },
  { "n", "<leader>1", "1gt", { desc = "Go to tab 1" } },
  { "n", "<leader>2", "2gt", { desc = "Go to tab 2" } },
  { "n", "<leader>3", "3gt", { desc = "Go to tab 3" } },
  { "n", "<leader>4", "4gt", { desc = "Go to tab 4" } },
  { "n", "<leader>5", "5gt", { desc = "Go to tab 5" } },
  { "n", "<leader>6", "6gt", { desc = "Go to tab 6" } },
  { "n", "<leader>7", "7gt", { desc = "Go to tab 7" } },
  { "n", "<leader>8", "8gt", { desc = "Go to tab 8" } },
  { "n", "<leader>9", "9gt", { desc = "Go to tab 9" } },

  -- ==============================
  -- WINDOW RESIZING
  -- ==============================
  { "n", "<leader>a", "<C-w>", {
    desc = "Enter window command mode",
  } },
  { "n", "<S-Left>", "<C-w><", {
    desc = "Decrease window width",
  } },
  { "n", "<S-Right>", "<C-w>>", {
    desc = "Increase window width",
  } },
  { "n", "<S-Up>", "<C-w>+", {
    desc = "Increase window height",
  } },
  { "n", "<S-Down>", "<C-w>-", {
    desc = "Decrease window height",
  } },

  -- ==============================
  -- CURSOR MOVEMENT
  -- ==============================
  { "n", "<C-j>", "gj", {
    desc = "Move down by display line",
  } },
  { "n", "<C-k>", "gk", {
    desc = "Move up by display line",
  } },
  {
    "n",
    "j",
    [[v:count ? "m'" . v:count . 'j' : 'gj']],
    {
      expr = true,
      desc = "Move down with wrap awareness",
    },
  },
  {
    "n",
    "k",
    [[v:count ? "m'" . v:count . 'k' : 'gk']],
    {
      expr = true,
      desc = "Move up with wrap awareness",
    },
  },

  -- ==============================
  -- TEXT MANIPULATION
  -- ==============================
  { "n", "<C-d>", "yyp", {
    desc = "Duplicate current line",
  } },
  { "n", "dae", ":%!pbpaste<CR>", {
    desc = "Replace line with clipboard content",
  } },

  -- ==============================
  -- VISUAL MODE
  -- ==============================
  { "n", "vv", "<Esc><Esc><C-V>", {
    desc = "Enter visual block mode",
  } },
  -- { "x", "<C-c>", 'y<Cmd>call system("pbcopy", @")<CR>', {
  --   desc = "Copy selection to macOS clipboard",
  -- } },

  -- ==============================
  -- MARKDOWN
  -- ==============================
  { "n", "dic", ":lua DeleteCurrentCell()<CR>", {
    desc = "Delete current cell in Markdown table",
  } },
}

for _, m in ipairs(keymaps) do
  local mode, lhs, rhs, opts = m[1], m[2], m[3], m[4]
  vim.keymap.set(mode, lhs, rhs, opts or {})
end
