return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  config = function()
    local luasnip = require("luasnip")
    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, {
      silent = true,
      desc = "Expand or jump forward in snippet",
    })

    vim.keymap.set({ "i", "s" }, "<C-k>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, {
      silent = true,
      desc = "Jump backward in snippet",
    })

    local snippet, n_text, n_insert = luasnip.snippet, luasnip.text_node, luasnip.insert_node
    luasnip.add_snippets("vimwiki", {
      snippet("details", {
        n_text("<details closed><summary>"),
        n_insert(1),
        n_text({ "</summary>", "", "" }),
        n_insert(0),
        n_text({ "", "</details>" }),
      }),
    })
  end,
}
