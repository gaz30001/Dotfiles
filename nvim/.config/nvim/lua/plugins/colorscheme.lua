return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			vim.o.background = "dark"
			require("gruvbox").setup({
				contrast = "hard",
			})
			vim.cmd("colorscheme gruvbox") -- Вот она активная
		end,
	},
}
-- return {
--   {
--     "folke/tokyonight.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       vim.cmd([[colorscheme tokyonight-night]])
--     end,
--   },
-- }
