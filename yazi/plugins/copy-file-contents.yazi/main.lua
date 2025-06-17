local selected_files = ya.sync(function()
  local tab, paths = cx.active, {}
  for _, u in pairs(tab.selected) do
    paths[#paths + 1] = tostring(u)
  end
  if #paths == 0 and tab.current.hovered then
    paths[1] = tostring(tab.current.hovered.url)
  end
  return paths
end)

local function notify(str)
  ya.notify({
    title = "Copy-file-contents",
    content = str,
    timeout = 3,
    level = "info",
  })
end

local state_option = ya.sync(function(state, attr)
  return state[attr]
end)

local function entry()
  -- Copy the contents of selected files into clipboard
  local files = selected_files()
  if #files == 0 then
    return
  end
  -- Get options from setup
  local append_char = state_option("append_char")
  local notification = state_option("notification")
  local show_header = state_option("show_header")
  local header_template = state_option("header_template")
  local show_end_marker = state_option("show_end_marker")
  local end_marker_template = state_option("end_marker_template")

  local text = ""
  for i, file in ipairs(files) do
    local f = io.open(file, "r")
    if f then
      local file_content = f:read("*a")
      file_content = file_content:gsub("%s+$", "")
      local filename = file:match("([^/\\]+)$") or file
      if show_header then
        local header = header_template:gsub("{filename}", filename)
        text = text .. header
      end
      text = text .. file_content
      if show_end_marker then
        local end_marker = end_marker_template:gsub("{filename}", filename)
        text = text .. end_marker
      end
      if i < #files then
        text = text .. append_char
      end
      f:close()
    end
  end

  -- Copy the file contents to clipboard
  ya.clipboard(text)
  -- Notify the user that the file contents have been copied to clipboard
  if notification then
    notify("Copied " .. #files .. " file(s) contents to clipboard")
  end
end

return {
  setup = function(state, options)
    state.append_char = options.append_char or "\n"
    state.notification = options.notification and true
    state.show_header = options.show_header ~= false -- default true
    state.header_template = options.header_template or "===== FILE: {filename} =====\n"
    state.show_end_marker = options.show_end_marker or false
    state.end_marker_template = options.end_marker_template or "\n===== END OF {filename} =====\n"
  end,
  entry = entry,
}
