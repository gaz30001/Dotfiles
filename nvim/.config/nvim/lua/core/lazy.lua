local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Клонируем lazy.nvim, если он ещё не установлен
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Настройка lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" }, -- Подключает все файлы из lua/plugins/*.lua
	},
}, {
	-- Отключаем luarocks
	rocks = {
		enabled = false,
		hererocks = false,
	},

	-- Отключаем уведомление об изменении конфигурации
	change_detection = {
		enabled = true,
		notify = false,
	},
})
