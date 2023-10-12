return {
	{
		"williamboman/mason.nvim",
		config = true,
		lay = false,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "clangd" },
			automatic_installation = true,
		},
		config = true,
		lay = false,
	},
}
