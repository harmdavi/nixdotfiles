return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      -- Viewer (Zathura)
      vim.g.vimtex_view_method = "zathura"
      -- Compiler (latexmk)
      vim.g.vimtex_compiler_method = "latexmk"
    end,
  },
}
