return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			notify_on_error = false,
			formatters = {
				prettierd = { require_cwd = true },
				["biome-check"] = { require_cwd = true },
			},
			format_on_save = {
				timeout_ms = 250,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				typescript = { "biome-check", "prettierd", stop_after_first = true },
				typescriptreact = { "biome-check", "prettierd", stop_after_first = true },
				json = { "biome-check", "prettierd", stop_after_first = true },

				lua = { "stylua" },
				css = { "prettierd" },
			},
		},
	},
}
