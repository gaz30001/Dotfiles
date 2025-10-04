vim.api.nvim_create_autocmd("WinClosed", {
	callback = function(args)
		local winid = tonumber(args.match)
		if winid and vim.api.nvim_win_is_valid(winid) then
			vim.api.nvim_win_close(winid, true)
		end
	end,
})
vim.g.mapleader = ","
vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,localoptions"
require("core.lazy")
-- vim.cmd.colorscheme("default")
vim.opt.background = "dark"
vim.cmd("highlight Normal guibg=#171717")
-- Нумерация строк
vim.opt.number = true -- абсолютная нумерация
vim.opt.relativenumber = true -- относительная нумерация (удобно при навигации)

vim.o.tabstop = 2 -- ширина таба визуально
vim.o.shiftwidth = 2 -- сколько пробелов при автоотступе
vim.o.expandtab = true -- использовать пробелы вместо табов

-- Подсветка текущей строки
vim.opt.cursorline = true
vim.opt.scrolloff = 3
