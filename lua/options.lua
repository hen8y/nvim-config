vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.clipboard = "unnamedplus"
-- vim.opt.scrolloff = 999
vim.opt.shiftwidth = 4
vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.termguicolors = true
vim.g.wakatime_show_message = false
vim.g.mapleader=" "

vim.filetype.add({
  pattern = {
    ['.*%.blade%.php'] = 'blade',
  },
})
