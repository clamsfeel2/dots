local api = vim.api
local set = api.nvim_set_hl

-- Highlight group definitions
local highlights = {
  editor = {
    Normal = { fg = "#D8DEE9", bg = "NONE" },
    CursorLineNr = { bold = true, fg = "#8FAEAE", bg = "NONE" },
    LineNr = { fg = "#4C566A", bg = "NONE" },
    CursorLine = { bg = "#3B4252" },
    CursorColumn = { fg = "#D8DEE9", bg = "#4C566A", reverse = true },
    ColorColumn = { bg = "#3B4252", reverse = true },
    SignColumn = { bg = "NONE" },
    VertSplit = { fg = "#4C566A" },
  },
  ui = {
    TabLine = { fg = "#D8DEE9", bg = "#3B4252", underline = false },
    TabLineSel = { fg = "#A3BE8C", bold = true },
    TabLineFill = { fg = "#434C5E", bold = true },
    Folded = { fg = "#D8DEE9", bg = "NONE", bold = true },
    FoldColumn = { fg = "#88C0D0", bg = "#3B4252" },
    StatusLine = { bold = true, reverse = true },
    StatusLineNC = { reverse = true },
    NormalFloat = { bg = "#454C5C" },
    -- NormalFloat = { bg = "NONE", fg = "#cdd6f4" },
    PmenuSbar = { bg = "#3B4252" },
    PmenuThumb = { bg = "#CA8A65" },
    PmenuSel = { fg = "#2E3440", bg = "#CA8A65" },
    ExtraWhitespace = { bg = "#BF616A" },
    Visual = { fg = "#2E3440", bg = "#EBCB8B" },
    YankHighlight = { fg = "#EBCB8B" },
    WordUnderCursor = { fg = "#EBCB8B" },
    CursorWord = { fg = "#EBCB8B" },
  },
  search = {
    IncSearch = { bold = true, fg = "#88A1BB", bg = "NONE" },
    Search = { bold = true, fg = "#88A1BB", bg = "NONE" },
    CurSearch = { bold = true, fg = "#88A1BB", bg = "NONE" },
    MatchParen = { bold = true, fg = "#2E3440", bg = "#EBCB8B" },
  },
  spell = {
    SpellBad = { underline = true, fg = "#BF616A" },
    SpellCap = { underline = true, fg = "#5E81AC" },
    SpellRare = { fg = "#D8DEE9", bg = "#B48EAD", reverse = true },
    SpellLocal = { fg = "#D8DEE9", bg = "#88C0D0", underline = false },
  },
  plugins = {
    -- vimwiki
    VimwikiTodo = { fg = "#EBCB8B" },
    VimwikiList = { fg = "#ffffff" },
    VimwikiLink = { fg = "#81A1C1" },
    -- gitgutter
    GitGutterAdd = { fg = "#A3BE8C" },
    GitGutterChange = { fg = "#EBCB8B" },
    GitGutterDelete = { fg = "#BF616A" },
    DiffAdd = { bg = "#5E81AC", bold = true },
    DiffChange = { bg = "#B48EAD", bold = true },
    DiffDelete = { fg = "#5E81AC", bg = "#434C5E", bold = true },
    DiffText = { bg = "#BF616A", bold = true, reverse = true },
    -- vim-sneak
    Sneak = { fg = "#ECEFF4", bg = "#5E81AC" },
    SneakScope = { fg = "#ECEFF4", bg = "#5E81AC" },
    SneakLabel = { fg = "#ECEFF4", bg = "#5E81AC" },
    -- noice
    NoiceMini = { bg = "NONE", fg = "#ffffff" },
    -- coc
    CocInlayHint = { fg = "#808080" },
    CocMenuSel = { fg = "#2E3440", bg = "#CA8A65" },
    CocUnusedHighlight = { undercurl = true, fg = "#A1C5E4" },
  },
  notify = {
    NotifyBackground = { fg = "#ffffff", bg = "#414141" },
    NotifyBorder = { bg = "#000000" },
    NotifyERRORBorder = { fg = "#BF616A" },
    NotifyWARNBorder = { fg = "#CC8B66" },
    NotifyINFOBorder = { fg = "#4F6752" },
    NotifyDEBUGBorder = { fg = "#8B8B8B" },
    NotifyTRACEBorder = { fg = "#4F3552" },
    NotifyERRORIcon = { fg = "#BF616A" },
    NotifyWARNIcon = { fg = "#F79000" },
    NotifyINFOIcon = { fg = "#A3BE8C" },
    NotifyDEBUGIcon = { fg = "#8B8B8B" },
    NotifyTRACEIcon = { fg = "#D484FF" },
    NotifyERRORTitle = { fg = "#BF616A" },
    NotifyWARNTitle = { fg = "#F79000" },
    NotifyINFOTitle = { fg = "#A3BE8C" },
    NotifyDEBUGTitle = { fg = "#8B8B8B" },
    NotifyTRACETitle = { fg = "#D484FF" },
    NotifyERRORBody = { link = "Normal" },
    NotifyWARNBody = { link = "Normal" },
    NotifyINFOBody = { link = "Normal" },
    NotifyDEBUGBody = { link = "Normal" },
    NotifyTRACEBody = { link = "Normal" },
    MyNotifyBorder = { fg = "#89b4fa", bg = "#ffffff" },
  },
  language = {
    Comment = { fg = "#87A0BE", bold = true },
    Constant = { fg = "#CC8B66", underline = false },
    String = { fg = "#A3BE8C" },
    Identifier = { fg = "#88C0D0", underline = false },
    Statement = { fg = "#CC8B66", bold = true },
    PreProc = { fg = "#B48EAD", underline = false },
    Type = { fg = "#A3BE8C", underline = false },
    Underlined = { fg = "#B48EAD", underline = false },
    Special = { fg = "#B48EAD", bold = true },
    Error = { fg = "#ECEFF4", bg = "#BF616A", reverse = true },
    Function = { fg = "#88C0D0" },
    Number = { fg = "#CC8B66" },
    Boolean = { fg = "#CC8B66" },
    Float = { fg = "#CC8B66" },
    SpecialKey = { fg = "#5E81AC" },
    NonText = { fg = "#5E81AC", bold = true },
    Directory = { fg = "#A3BE8C", bold = true },
    ErrorMsg = { fg = "#ECEFF4", bg = "#3B4252" },
    MoreMsg = { fg = "#A3BE8C", bold = true },
    ModeMsg = { bold = true },
    Question = { fg = "#A3BE8C" },
    Title = { fg = "#B48EAD", bold = true },
    VisualNOS = { bold = true, underline = false },
    WarningMsg = { fg = "#BF616A" },
    WildMenu = { fg = "#2E3440", bg = "#EBCB8B" },
    Ignore = { fg = "#ffffff" },
    Added = { fg = "#A3BE8C" },
    Changed = { fg = "#5E81AC" },
    Removed = { fg = "#BF616A" },
    Conditional = { fg = "#CC8B66" },
    Repeat = { fg = "#CC8B66" },
    Label = { fg = "#CC8B66" },
    Operator = { fg = "#CC8B66" },
    Keyword = { fg = "#CC8B66" },
    Exception = { fg = "#CC8B66" },
    Include = { fg = "#B48EAD" },
    Define = { fg = "#B48EAD" },
    Macro = { fg = "#B48EAD" },
    PreCondit = { fg = "#B48EAD" },
    StorageClass = { fg = "#A3BE8C" },
    Structure = { fg = "#A3BE8C" },
    Typedef = { fg = "#A3BE8C" },
    Tag = { fg = "#B48EAD" },
    Delimiter = { fg = "#B48EAD" },
    SpecialComment = { fg = "#B48EAD" },
    Debug = { fg = "#B48EAD" },
    todo = { fg = "#EBCB8B", bold = true },
    fix = { fg = "#E5C07B", bold = true },
    TaskKeyword = { fg = "#EBCB8B" },
  },
}

local skip = {} -- [grp] = true
for grp, defs in pairs(highlights) do
  if not skip[grp] then
    for name, opts in pairs(defs) do
      set(0, name, opts)
    end
  end
end

-- Diff namespace than 0 + unneded?
set(1, "MyNotifyBackground", { bg = "NONE", fg = "#cdd6f4" })
-- set(0, "MyNotifyBorder", { fg = "#89b4fa", bg = "#ffffff" })
-- set(0, "MyNotifyBackground", { bg = "#282c34" })
-- set(0, "MyNotifyBorder",     { fg = "#61afef", bg = "#282c34" })
-- set(0, "NormalFloat", { bg = "NONE", fg = "#cdd6f4" })
-- set(0, "TaskKeyword", { fg = "#EBCB8B" })

-- Syntax Matching
vim.fn.matchadd("TaskKeyword", [[\v(TODO|FIXME|NOTE|HACK)]])

-- VIMWIKI/MARKDOWN HEADER COLORING SETUP IN ONE TABLE --
local vimwiki_cfg = {
  header_colors = { "#EBCB8B", "#CC8B66", "#A3BE8C", "#B48EAD", "#88C0D0", "#81A1C1" },
}
function vimwiki_cfg:apply_headers()
  for lvl, col in ipairs(self.header_colors) do
    api.nvim_set_hl(0, "VimwikiHeader" .. lvl, { fg = col })
    api.nvim_set_hl(0, "VimwikiHeader" .. lvl .. "Delimiter", { fg = col })
  end
end
function vimwiki_cfg:match_headers()
  vim.fn.clearmatches()
  for lvl in ipairs(self.header_colors) do
    vim.fn.matchadd("VimwikiHeader" .. lvl, "^" .. string.rep("#", lvl) .. " .*", 100)
  end
end
function vimwiki_cfg:setup()
  self:apply_headers()
  local aug = api.nvim_create_augroup("ClamsVimwiki", { clear = true })
  api.nvim_create_autocmd("ColorScheme", {
    group = aug,
    pattern = "*",
    callback = function()
      self:apply_headers()
    end,
  })
  api.nvim_create_autocmd("FileType", {
    group = aug,
    pattern = "vimwiki",
    callback = function()
      self:match_headers()
    end,
  })
  api.nvim_create_autocmd("User", {
    group = aug,
    pattern = "GoyoEnter",
    callback = function()
      self:match_headers()
    end,
  })
end
vimwiki_cfg:setup()
-- END VIMWIKI SETUP --
