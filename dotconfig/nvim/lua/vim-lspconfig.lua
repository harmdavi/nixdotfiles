vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },

  settings = {
    Lua = {
      completion = {
        enable = true,
        keywordSnippet = "Both",
      },

      runtime = {
        version = "LuaJIT",
      },

      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

--vim.lsp.config("texlab")
