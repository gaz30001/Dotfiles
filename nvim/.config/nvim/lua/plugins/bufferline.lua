return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- иконки файлов
  },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        numbers = "none",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        diagnostics = "nvim_lsp",
        separator_style = "slant", -- другие варианты: "thick", "thin", "slope", "padded_slant"
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        always_show_bufferline = true,
        sort_by = "id",
      },
    })

    -- Горячие клавиши для переключения буферов
    vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
  end,
}
