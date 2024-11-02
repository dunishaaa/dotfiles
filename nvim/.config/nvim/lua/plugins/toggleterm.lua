return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                shade_terminals = false,
            })
            vim.keymap.set("n", "<leader>to", vim.cmd.ToggleTerm)
        end,
    },
}
