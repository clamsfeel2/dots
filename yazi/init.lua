--- @sync entry
-- To show symlink path in status bar
function Status:name()
  local h = cx.active.current.hovered
  if not h then
    return ui.Span("")
  end
  local linked = h.link_to and (" -> " .. tostring(h.link_to)) or ""
  return ui.Span(" " .. h.name .. linked)
end

require("copy-file-contents"):setup({
  append_char = "\n\n",
  notification = true,
  show_header = true,
  header_template = "===== FILE: {filename} =====\n",
  show_end_marker = true,
  end_marker_template = "\n===== END OF {filename} =====\n",
})
