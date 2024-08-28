local map = vim.keymap.set

map({'n'}, '<M-o>', function ()
    vim.cmd('ToggleTerm')
end, { silent = true, desc = 'Toggle Toggleterm' })

map({'n'}, '<M-l>', function ()
    vim.cmd('FloatermToggle')
end, { silent = true, desc = 'Toggle Toggleterm' })

map({'n'}, '<M-p>', function ()
    vim.cmd('NvimTreeToggle')
end, { silent = true, desc = 'Toggle NvimTree' })

map({'n'}, '<M-f>', function ()
    vim.cmd('GrugFar')
end, { silent = true, desc = 'Display NvimTreeToggle' })

map({'n'}, '<M-g>', function ()
    vim.cmd('DiffviewOpen')
end, { silent = true, desc = 'Open Git Diff View' })

map("n", "<leader>gg", "<cmd>GoBlade<cr>")


vim.api.nvim_create_user_command('Fmt', function()
    local current_file = vim.fn.expand('%:p')
    vim.cmd('!blade-formatter ' .. current_file .. ' --write')
end, {})

