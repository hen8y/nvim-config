return {
    {
        "voldikss/vim-floaterm",
        config = function ()
            -- Normal mode mappings
            vim.keymap.set('n', '<leader>tf', ':FloatermNew<CR>', { silent = true, desc = 'Floaterm New' })
            vim.keymap.set('n', '<leader>tp', ':FloatermPrev<CR>', { silent = true, desc = 'Floaterm Prev' })
            vim.keymap.set('n', '<leader>tn', ':FloatermNext<CR>', { silent = true, desc = 'Floaterm Next' })
            vim.keymap.set('n', '<leader>tt', ':FloatermToggle<CR>', { silent = true, desc = 'Floaterm Toggle' })
            vim.keymap.set('n', '<leader>tk', ':FloatermKill<CR>', { silent = true, desc = 'Floaterm Kill' })

            -- Terminal mode mappings
            vim.keymap.set('t', '<leader>tf', '<C-\\><C-n>:FloatermNew<CR>', { silent = true, desc = 'Floaterm New' })
            vim.keymap.set('t', '<leader>tp', '<C-\\><C-n>:FloatermPrev<CR>', { silent = true, desc = 'Floaterm Prev' })
            vim.keymap.set('t', '<leader>tn', '<C-\\><C-n>:FloatermNext<CR>', { silent = true, desc = 'Floaterm Next' })
            vim.keymap.set('t', '<leader>tt', '<C-\\><C-n>:FloatermToggle<CR>', { silent = true, desc = 'Floaterm Toggle' })
            vim.keymap.set('t', '<leader>tk', '<C-\\><C-n>:FloatermKill<CR>', { silent = true, desc = 'Floaterm Kill' })
        end
    }
}
