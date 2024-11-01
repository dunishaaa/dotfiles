return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function () 
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "javascript", "cpp", "rust", "bash", "c_sharp", "cmake", "cuda", "glsl", "julia"},
				sync_install = false,
				auto_install = true,
				highlight = { enable = true },
		 		indent = { enable = true },  
				additional_vim_regex_highlighting = false,

			})
		end
	}
}
