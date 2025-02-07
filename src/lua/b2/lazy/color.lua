return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        dependencies = {
            "famiu/feline.nvim"
        },
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                }
            })
            vim.cmd.colorscheme("catppuccin")

            -- Now configure feline
            require("feline").setup({
                components = require("catppuccin.groups.integrations.feline").get(),
            })
        end,
    },
}
