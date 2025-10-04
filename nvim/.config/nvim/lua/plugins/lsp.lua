return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")

		local on_attach = function(client, bufnr)
			if client.server_capabilities.documentFormattingProvider then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ async = false })
					end,
				})
			end
		end

		-- Настройка Lua (для Neovim)
		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = { checkThirdParty = false },
				},
			},
		})

		-- Настройка Bash
		lspconfig.bashls.setup({
			on_attach = on_attach,
		})

		-- Настройка Python
		lspconfig.pyright.setup({
			on_attach = on_attach,
		})

		-- Настройка C/C++
		lspconfig.clangd.setup({
			on_attach = on_attach,
		})

		-- 📌 Минималистичная настройка отображения диагностик
		vim.diagnostic.config({
			virtual_text = false, -- отключаем inline-ошибки
			signs = true, -- включаем иконки слева
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		-- Иконки для ошибок и подсказок
		local signs = {
			Error = " ",
			Warn = " ",
			Hint = " ",
			Info = " ",
		}

		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
	end,
}
