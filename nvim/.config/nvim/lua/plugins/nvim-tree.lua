return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- иконки для файлов
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 35,
        side = "left",
        preserve_window_proportions = true,
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { "^.git$" },
      },
      git = {
        enable = true,
        ignore = false,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
    })

    -- Автооткрытие дерева при старте, если директория
    local function open_nvim_tree(data)
      local directory = vim.fn.isdirectory(data.file) == 1
      if directory then
        vim.cmd.cd(data.file)
        require("nvim-tree.api").tree.open()
      end
    end
    vim.api.nvim_create_autocmd({ "VimEnter" }, {
      callback = open_nvim_tree,
    })
  end,
}
