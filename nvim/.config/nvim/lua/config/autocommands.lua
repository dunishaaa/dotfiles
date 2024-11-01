local formattingGroup = vim.api.nvim_create_augroup("au_fromatting", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function()
        vim.lsp.buf.format()
    end,
})
