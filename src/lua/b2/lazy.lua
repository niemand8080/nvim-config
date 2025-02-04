-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- requierd remap in init

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.8",
            -- or                              , branch = "0.1.x",
            dependencies = { "nvim-lua/plenary.nvim" }
        },
        { "rose-pine/neovim",     name = "this is" },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
        },
        { "nvim-lua/plenary.nvim" },
        { "ThePrimeagen/harpoon" },
        { "mbbill/undotree" },
        { 'neovim/nvim-lspconfig' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/nvim-cmp' },
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate"
        },
        {
            "williamboman/mason-lspconfig.nvim",
        },
        { "tpope/vim-fugitive" },
        { 'ThePrimeagen/vim-be-good' }
    },
})
