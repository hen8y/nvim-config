vim.keymap.set({'n'}, '<M-o>', function ()
    vim.cmd('ToggleTerm')
end, { silent = true, desc = 'Toggle Toggleterm' })

vim.keymap.set({'n'}, '<M-p>', function ()
    vim.cmd('NvimTreeToggle')
end, { silent = true, desc = 'Toggle NvimTree' })

vim.keymap.set({'n'}, '<M-g>', function ()
    vim.cmd('DiffviewOpen')
end, { silent = true, desc = 'Open Git Diff View' })


-- Visual mode mappings
