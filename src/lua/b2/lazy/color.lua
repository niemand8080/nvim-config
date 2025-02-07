function Color(color)
    color = color or "rose-pine-moon"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
end

return {
    {
        "rose-pine/neovim",
        config = function()
            -- Color()
        end
    },
    {
        'b0o/lavi.nvim',
        dependencies = { 'rktjmp/lush.nvim' },
        config = function()
            Color('lavi')

            vim.cmd("highlight Pmenu guibg=NONE")
            vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
            vim.api.nvim_set_hl(0, "Visual", { bg = "#25213B", blend = 50 })
            vim.api.nvim_set_hl(0, "Comment", { fg = "#7E7490" })
        end,
    },
}

