return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
        "nosduco/remote-sshfs.nvim",
    },
    default = {
        file_ignore_patterns = {
            "node_modules",
            "Library",
        }
    },
    config = function()
        require('telescope').setup({
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",
                }
            },
        })

        require("telescope").load_extension('fzf')
        require('telescope').load_extension('remote-sshfs')

        -- Remote SSHFS 
        local api = require('remote-sshfs.api')
        vim.keymap.set('n', '<leader>rc', api.connect, {})
        vim.keymap.set('n', '<leader>rd', api.disconnect, {})
        vim.keymap.set('n', '<leader>re', api.edit, {})

        local builtin = require("telescope.builtin")
        local connections = require("remote-sshfs.connections")
        vim.keymap.set("n", "<leader>ff", function()
            if connections.is_connected then
                api.find_files()
            else
                print("Not connncted")
                -- builtin.find_files()
            end
        end, {})
        vim.keymap.set("n", "<leader>fg", function()
            if connections.is_connected then
                api.live_grep()
            else
                print("Not connncted")
                -- builtin.live_grep()
            end
        end, {})

        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
    end
}

