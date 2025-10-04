return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
      "windwp/nvim-ts-autotag", -- автозакрытие HTML/JSX тегов
    },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "bash", "python", "json", "html", "css",
        "javascript", "typescript", "tsx", "c", "cpp", "markdown", "markdown_inline"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      autotag = {
        enable = true,
      },
    })
  end,
}
