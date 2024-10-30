return {
	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		init = function()
			vim.g.netrw_nogx = 1 -- disable netrw gx
		end,
		dependencies = { "nvim-lua/plenary.nvim" }, -- Required for Neovim < 0.10.0
		config = true, -- default settings
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
				natural_order = true,
				win_options = { wrap = true },
				is_always_hidden = function(name, _)
					return name == ".." or name == ".git"
				end,
			},
		},
	},
}
