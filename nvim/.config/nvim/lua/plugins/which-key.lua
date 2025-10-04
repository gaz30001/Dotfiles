return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		plugins = {
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = false,
				nav = false,
				z = false,
				g = false,
			},
		},
		show_keys = false, -- ⛔ Отключить показ сообщения о загрузке
		win = {
			border = "single",
		},
	},
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Файловый менеджер" },
		{
			"<leader>f",
			function()
				vim.lsp.buf.format({ async = true })
			end,
			desc = "Форматировать",
		},
		{ "<leader>h", "<cmd>nohlsearch<CR>", desc = "Убрать подсветку поиска" },
		{ "<leader>q", "<cmd>q<CR>", desc = "Выйти" },
		{ "<leader>s", "<cmd>w<CR>", desc = "Сохранить файл" },
		{ "<leader>x", "<cmd>bd<CR>", desc = "Закрыть буфер" },

		-- NvimTree actions
		{ "<leader>a", "<cmd>NvimTreeCreate<CR>", desc = "Создать файл/папку" },
		{ "<leader>r", "<cmd>NvimTreeRename<CR>", desc = "Переименовать файл/папку" },

		-- Tab navigation
		{ "<leader>tn", "<cmd>tabnext<CR>", desc = "Следующая вкладка" },
		{ "<leader>tp", "<cmd>tabprevious<CR>", desc = "Предыдущая вкладка" },
	},
}
