return {
	{
		"christoomey/vim-tmux-navigator",
	},
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		config = function()
			-- Optional, you don't have to run setup.
			require("transparent").setup({
				-- table: default groups
				groups = {
					"Normal",
					"NormalNC",
					"Comment",
					"Constant",
					"Special",
					"Identifier",
					"Statement",
					"PreProc",
					"Type",
					"Underlined",
					"Todo",
					"String",
					"Function",
					"Conditional",
					"Repeat",
					"Operator",
					"Structure",
					"LineNr",
					"NonText",
					"SignColumn",
					"CursorLineNr",
					"StatusLine",
					"StatusLineNC",
					"EndOfBuffer",
				},
				-- table: additional groups that should be cleared
				extra_groups = {},
				-- table: groups you don't want to clear
				exclude_groups = { "CursorLine" },
				-- function: code to be executed after highlight groups are cleared
				-- Also the user event "TransparentClear" will be triggered
				on_clear = function() end,
			})
		end,
	},
	{
		{
			"goolord/alpha-nvim",
			-- dependencies = { 'echasnovski/mini.icons' },
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				local startify = require("alpha.themes.startify")
				-- available: devicons, mini, default is mini
				-- if provider not loaded and enabled is true, it will try to use another provider
				startify.file_icons.provider = "devicons"
				require("alpha").setup(startify.config)
			end,
		},
	},
}
