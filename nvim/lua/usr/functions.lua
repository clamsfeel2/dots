-- ==============================
-- Helpful
-- ==============================
_G.DeleteCurrentCell = function()
  local start_col, end_col = vim.fn.searchpos("|", "bn")[2], vim.fn.searchpos("|", "n")[2]
  if start_col * end_col == 0 then
    return print("Not in table cell")
  end
  vim.fn.setline(".", vim.fn.getline("."):sub(1, start_col) .. vim.fn.getline("."):sub(end_col))
  vim.fn.cursor(vim.fn.line("."), start_col + 1)
  vim.cmd("startinsert")
end

_G.OpenKittyDoc = function()
  local line = vim.fn.getline(".")
  local url = ""
  if string.match(line, "https?://") then
    url = string.match(line, "https?://%S+")
  else
    local pat = (vim.bo.filetype == "kitty") and "^%s*%S+" or "https?://%S+[^)]"
    local match = string.match(line, pat)
    if vim.bo.filetype == "kitty" and match ~= nil and match ~= "" then
      url = "https://sw.kovidgoyal.net/kitty/conf/#opt-kitty." .. match
    else
      url = match or ""
    end
  end
  if url == "" then
    print("No valid URL/option found on the current line.")
  else
    vim.fn.system("open " .. vim.fn.shellescape(url))
  end
end

_G.InsertTime = function()
  local time = "@" .. os.date("%H:%M")
  if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
    vim.fn.setline(1, time)
  else
    vim.fn.append(vim.fn.line("$"), { "", time })
  end
  vim.fn.append(vim.fn.line("$"), { "", "" })
  vim.fn.cursor(vim.fn.line("$"), 1)
  vim.cmd("startinsert")
end

-- ==============================
-- Vimwiki HTML Conversion
-- ==============================
_G.RunHTMLVimWikiCmd = function()
  local notify = vim.notify
  local buf_dir = vim.fn.expand("%:p:h"):gsub("/+$", "")
  local paths = {
    vim.fn.expand("$HOME/Documents/Mollusk/Documents/Notes/frontend/html/Personal/Journal"),
    vim.fn.expand("$HOME/Documents/Mollusk/Documents/Notes/frontend/markdown"),
  }
  for _, path in ipairs(paths) do
    if buf_dir:find(vim.fn.fnamemodify(path, ":p"):gsub("/+$", ""), 1, true) then
      vim.cmd("Vimwiki2HTML")
      vim.fn.system('rm "$HOME/Documents/Mollusk/Documents/Notes/frontend/html/style.css"')
      notify("Conversion complete!", "info", { title = "Vimwiki" })
      return
    end
  end
end

_G.RunHTMLVimWikiAllCmd = function()
  local notify = vim.notify
  vim.cmd("VimwikiAll2HTML")
  vim.fn.system('rm "$HOME/Documents/Mollusk/Documents/Notes/frontend/html/style.css"')
  notify("All conversions finished!", "info", { title = "Vimwiki" })
end
