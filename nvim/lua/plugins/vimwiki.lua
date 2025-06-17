return {
  "vimwiki/vimwiki",
  init = function()
    vim.g.vimwiki_list = {
      {
        path = "$HOME/Documents/Mollusk/Documents/Notes/frontend/markdown/Personal/Journal",
        auto_diary_index = 1,
        syntax = "markdown",
        ext = ".md",
        path_html = "$HOME/Documents/Mollusk/Documents/Notes/frontend/html/Personal/Journal",
        custom_wiki2html = "$HOME/Documents/Mollusk/Documents/Notes/scripts/vimwiki_markdown.sh",
        html_filename_parameterization = 1,
        template_path = "$HOME/Documents/Mollusk/Documents/Notes/frontend/assets/pages/partials",
        template_default = "default",
        template_ext = ".html",
        auto_export = 1,
      },
      {
        path = "$HOME/Documents/Mollusk/Documents/Notes/frontend/markdown/",
        auto_toc = 1,
        listsyms = " wx",
        syntax = "markdown",
        ext = ".md",
        path_html = "$HOME/Documents/Mollusk/Documents/Notes/frontend/html",
        custom_wiki2html = "$HOME/Documents/Mollusk/Documents/Notes/scripts/vimwiki_markdown.sh",
        html_filename_parameterization = 1,
        template_path = "$HOME/Documents/Mollusk/Documents/Notes/frontend/assets/pages/partials",
        template_default = "default",
        template_ext = ".html",
        auto_export = 1,
      },
    }
    vim.g.vimwiki_ext2syntax = {
      [".md"] = "markdown",
      [".markdown"] = "markdown",
      [".mdown"] = "markdown",
    }
    vim.g.vimwiki_listsyms_propagate = 0
    vim.g.vimwiki_global_ext = 1
    vim.g.vimwiki_markdown_link_ext = 1
    vim.keymap.set("n", "<leader>wi", ":VimwikiDiaryIndex 1<CR>", {
      desc = "Open diary index",
    })
    vim.keymap.set("n", "<leader>n", ":VimwikiMakeDiaryNote 1<CR>:lua InsertTime()<CR>", {
      desc = "Create new journal entry",
    })
  end,
  config = function()
    local api = vim.api
    local vimwiki_aucmds = api.nvim_create_augroup("VimwikiExtras", { clear = true })
    local wiki_patterns = { "*.md", "*.mkd", "*.mdown", "*.wiki" }

    -- Conceal rules + tab indent mapping for bullet points
    api.nvim_create_autocmd({ "BufEnter", "BufRead", "BufReadPost" }, {
      group = vimwiki_aucmds,
      pattern = wiki_patterns,
      callback = function()
        local ft = vim.bo.filetype
        if ft == "vimwiki" or ft == "markdown" then
          vim.cmd([[
            syn match CustomConceal '<details closed><summary>' conceal
            syn match CustomConceal '</summary>' conceal
            syn match CustomConceal '</details>\n'   conceal cchar=.
            syn match CustomConceal '&nbsp;'         conceal cchar=.
            ]])
          local rptc = vim.api.nvim_replace_termcodes
          -- indent bullet or fall back to real Tab
          vim.keymap.set("i", "<Tab>", function()
            local line = vim.fn.getline(".")
            if line:match("^%s*[-*+]%s") then
              return rptc("<Esc>^>>A", true, false, true)
            else
              return rptc("<Tab>", true, false, true)
            end
          end, {
            expr = true,
            buffer = true,
            silent = true,
            desc = "Indent bullet in list or insert tab",
          })
          -- unindent bullet or fall back to real S-Tab
          vim.keymap.set("i", "<S-Tab>", function()
            local line = vim.fn.getline(".")
            if line:match("^%s*[-*+]%s") then
              return rptc("<Esc>^<<a", true, false, true)
            else
              return rptc("<S-Tab>", true, false, true)
            end
          end, {
            expr = true,
            buffer = true,
            silent = true,
            desc = "Unindent bullet in list or insert shift-tab",
          })
        end
      end,
      desc = "Set up Vimwiki Conceal + Tab/S-Tab to indent and unindent bullet points",
    })
    api.nvim_create_autocmd("BufWritePost", {
      group = vimwiki_aucmds,
      pattern = wiki_patterns,
      callback = function()
        if vim.bo.filetype == "vimwiki" then
          vim.schedule(function()
            pcall(vim.cmd, "silent! lua RunHTMLVimWikiCmd()")
          end)
        end
      end,
      desc = "Run HTML command on save",
    })
  end,
}
