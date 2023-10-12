return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
		{ "lukas-reineke/lsp-format.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local builtin = require("telescope.builtin")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "<leader>i", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>rr", builtin.lsp_references, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>0", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
			end,
		})

		-- Server setup here
		-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		lspconfig.emmet_language_server.setup({})
		lspconfig.tsserver.setup({})

		lspconfig.millet.setup({
			filetype = { "sml" },
		})

		lspconfig.racket_langserver.setup({
			on_attach = require("lsp-format").on_attach,
		})

		lspconfig.clangd.setup({
			on_attach = require("lsp-format").on_attach,
			cmd = {
				"/usr/bin/clangd-17",
				"--all-scopes-completion",
				"--background-index",
				"--cross-file-rename",
				"--header-insertion=never",
			},
		})
		-- end

		lspconfig.lua_ls.setup({
			on_init = function(client)
				local path = client.workspace_folders[1].name
				if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
					client.config.settings = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							version = "LuaJIT",
						},
						workspace = {
							library = { vim.env.VIMRUNTIME },
						},
					})
					client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
				end
				return true
			end,
		})
	end,
}
