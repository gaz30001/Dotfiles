return {
  "brenoprata10/nvim-highlight-colors",
  event = "BufReadPre",
  config = function()
    require("nvim-highlight-colors").setup({
      render = "background", -- попробуй "foreground", если фон не виден
      enable_named_colors = true,
      enable_tailwind = true,
    })
  end,
}
