return {
	{
		"datsfilipe/vesper.nvim",
		priority = 1000,
		opts = { italics = {} },
		init = function()
			vim.cmd.colorscheme("vesper")
		end,
	},
}
