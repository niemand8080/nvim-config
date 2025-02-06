return {
    -- For telescope
    { "nvim-lua/plenary.nvim" },
    { 'nvim-telescope/telescope-fzf-native.nvim' },
    {
        "niemand8080/remote-ssh.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        pin = true,
        config = function()
            require("remote-ssh").setup({
                log = {
                    enable = true
                }
            })
        end
    },
    -- VimBeGood
    { 'ThePrimeagen/vim-be-good' },
    -- For LSP
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { "williamboman/mason-lspconfig.nvim" },
}

