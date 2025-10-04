return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- обязательная библиотека
    "nvim-telescope/telescope-fzf-native.nvim", -- ускорение поиска
    build = "make",
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Grep (ripgrep)" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help Tags" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = { preview_width = 0.6 },
        },
        sorting_strategy = "descending",
        file_ignore_patterns = { "node_modules", "%.git/", "%.cache" },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    })

    -- Подключение ускорения
    pcall(telescope.load_extension, "fzf")
  end,
}
