return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        python = { "black" },
        lua = { "stylua" },
        bash = { "shfmt" },
      },
    })

    -- Горячая клавиша для ручного форматирования
    vim.keymap.set("n", "<leader>f", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "Форматировать файл (Conform)" })
  end,
}
-- return {
-- 	"stevearc/conform.nvim",
-- 	event = { "BufWritePre" },
-- 	config = function()
-- 		require("conform").setup({
-- 			format_on_save = {
-- 				lsp_fallback = true, -- если LSP не может — fallback на внешние форматтеры
-- 				timeout_ms = 500,
-- 			},
-- 			formatters_by_ft = {
-- 				lua = { "stylua" },
-- 				python = { "black" },
-- 				bash = { "shfmt" },
-- 				sh = { "shfmt" },
-- 				javascript = { "prettier" },
-- 				typescript = { "prettier" },
-- 				json = { "prettier" },
-- 				html = { "prettier" },
-- 				css = { "prettier" },
-- 				c = { "clang-format" },
-- 				cpp = { "clang-format" },
-- 			},
-- 		})
-- 	end,
-- }{
-- 	"stevearc/conform.nvim",
-- 	event = { "BufWritePre" },
-- 	config = function()
-- 		require("conform").setup({
-- 			-- Автоформатирование при сохранении
-- 			format_on_save = {
-- 				lsp_fallback = true,
-- 				timeout_ms = 1000,
-- 			},
-- 			-- Назначение форматтеров по типу файла
-- 			formatters_by_ft = {
-- 				lua = { "stylua" },
-- 				python = { "black" },
-- 				bash = { "shfmt" },
-- 				sh = { "shfmt" },
-- 				c = { "clang-format" },
-- 				cpp = { "clang-format" },
-- 				html = { "prettier" },
-- 				css = { "prettier" },
-- 				javascript = { "prettier" },
-- 				typescript = { "prettier" },
-- 				json = { "prettier" },
-- 			},
-- 		})
-- 		vim.keymap.set("n", "<leader>f", function()
-- 			require("conform").format({ async = true, lsp_fallback = true })
-- 		end, { desc = "Форматировать текущий файл" })
-- 	end,
-- }
