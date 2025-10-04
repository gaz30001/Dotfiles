return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    indent = {
      char = "│", -- символ для линии (можно заменить на "┊", "|", "¦", "⎸" и т.д.)
    },
    scope = {
      enabled = false, -- отключаем подсветку области отступов (если не нравится)
    },
    exclude = {
      filetypes = { "help", "lazy", "dashboard", "alpha" },
    },
  },
}
