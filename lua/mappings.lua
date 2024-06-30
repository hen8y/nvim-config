vim.keymap.set({'n'}, '<M-0>', function ()
    vim.cmd('FloatermToggle')
end, { silent = true, desc = 'Toggle Floaterm' })

vim.keymap.set({'n'}, '<M-b>', function ()
    vim.cmd('NvimTreeToggle')
end, { silent = true, desc = 'Toggle NvimTree' })
