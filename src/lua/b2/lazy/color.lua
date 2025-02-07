local function change_color_opts(group, opts)
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    for k, v in pairs(opts) do
        hl[k] = v
    end
    vim.api.nvim_set_hl(0, group, hl)
end

function Color(color)
    color = color or "rose-pine-moon"
    vim.cmd.colorscheme(color)

    change_color_opts("Normal", { bg = "none" })
    change_color_opts("Title", { bg = "none" })
    change_color_opts("NormalFloat", { bg = "none" })
    change_color_opts("FloatBorder", { bg = "none" })
    change_color_opts("NormalNC", { bg = "none" })
    change_color_opts("Visual", { blend = 50 })
    change_color_opts("SignColumn", { bg = "none" })
    change_color_opts("FoldColumn", { bg = "none" })
    change_color_opts("WinSeparator", { bg = "none", fg = "gray", blend = 50 })
    -- LSP auto complete
    change_color_opts("Pmenu", { blend = 15, fg = "gray" })
    change_color_opts("PmenuSbar", { bg = "none" })
    change_color_opts("PmenuThumb", { blend = 50 })
    -- nvim tree
    change_color_opts("NvimTreeNormal", { bg = "none" })
    change_color_opts("NvimTreeNormalNC", { bg = "none" })
    change_color_opts("NvimTreeNormalFloat", { bg = "none" })
    change_color_opts("NvimTreeWinSeparator", { bg = "none", fg = "gray", blend = 50 })
    -- telescope
    change_color_opts("TelescopeNormal", { bg = "none" })
    change_color_opts("TelescopeBorder", { bg = "none" })
    change_color_opts("TelescopePromptBorder", { bg = "none" })
    change_color_opts("TelescopePromptTitle", { bg = "none" })
end

return {
    {
        "rose-pine/neovim",
        config = function()
            -- Color('rose-pine-moon')
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            Color('tokyonight-night')
        end,
    },
    {
        "dgox16/oldworld.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- Color('oldworld')
        end,
    },
    {
        'b0o/lavi.nvim',
        dependencies = { 'rktjmp/lush.nvim' },
        lazy = false,
        priority = 1000,
        config = function()
            -- Color('lavi')

            vim.api.nvim_set_hl(0, "Comment", { fg = "#7E7490" })
        end,
    },
}
