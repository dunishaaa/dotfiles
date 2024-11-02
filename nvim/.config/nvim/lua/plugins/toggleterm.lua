return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				shade_terminals = false,
				open_mapping = [[<C-`>]],
			})
		end,
	},
}
