return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        {
            'b0o/nvim-tree-preview.lua',
            dependencies = {
                'nvim-lua/plenary.nvim',
                '3rd/image.nvim', -- Optional, for previewing images
            },
        },
    },
    config = function()
        require('nvim-tree').setup()

        local api = require('nvim-tree.api')
        vim.keymap.set('n', '<leader>pt', api.tree.open)
    end
}
