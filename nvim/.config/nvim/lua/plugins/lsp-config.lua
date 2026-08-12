return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "clangd",
                    "ruff",
                    "basedpyright",
                    "jdtls",
                    "biome",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("biome", {
                capabilities = capabilities,
            })

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
            })
            vim.lsp.config("rust_analyzer", {
                capabilities = capabilities,
            })
            vim.lsp.config("basedpyright", {
                capabilities = capabilities,
            })
            vim.lsp.config("clangd", {
                capabilities = capabilities,
            })

            vim.lsp.config("jdtls", {
                capabilities = capabilities,
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}
