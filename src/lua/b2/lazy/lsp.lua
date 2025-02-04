return {
    'neovim/nvim-lspconfig',
    dependencis = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/nvim-cmp',
        { 'williamboman/mason.nvim', build = ":MasonUpdate" },
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        -- Reserve a space in the gutter
        vim.opt.signcolumn = 'yes'

        -- Add cmp_nvim_lsp capabilities settings to lspconfig
        -- This should be executed before you configure any language server
        local lspconfig_defaults = require('lspconfig').util.default_config
        lspconfig_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

        -- Mason setup to install and manage LSP servers
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "html", "cssls", "jsonls", "ts_ls", "lua_ls" }, -- Add more as needed
            automatic_installation = true,                                       -- Automatically install if not present
            handlers = {
                function(server_name)                                            -- Default handler for most servers
                    require("lspconfig")[server_name].setup({
                        capabilities = lspconfig_defaults.capabilities
                    })
                end,

                -- Custom config for Lua LSP
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        capabilities = lspconfig_defaults.capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim" },
                                },
                            },
                        },
                    })
                end,
            },
        })

        -- Autocommands: LSP actions when a server attaches to a buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf }

                vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
                vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
                vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format() end, opts)

                vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
                vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
            end,
        })

        -- nvim-cmp setup for autocompletion
        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Insert }
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body) -- Requires Neovim v0.10+
                end,
            },
            mapping = {
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),

                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'buffer' },
            },
        })
    end
}
