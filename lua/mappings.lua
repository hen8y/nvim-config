vim.keymap.set({'n'}, '<M-o>', function ()
    vim.cmd('ToggleTerm')
end, { silent = true, desc = 'Toggle Toggleterm' })

vim.keymap.set({'n'}, '<M-l>', function ()
    vim.cmd('FloatermToggle')
end, { silent = true, desc = 'Toggle Toggleterm' })

vim.keymap.set({'n'}, '<M-p>', function ()
    vim.cmd('NvimTreeToggle')
end, { silent = true, desc = 'Toggle NvimTree' })

vim.keymap.set({'n'}, '<M-g>', function ()
    vim.cmd('DiffviewOpen')
end, { silent = true, desc = 'Open Git Diff View' })
vim.keymap.set("n", "<leader>gg", "<cmd>GoBlade<cr>")
 vim.keymap.set('v', '<leader>rs', require('lib.create').create_snippet)
