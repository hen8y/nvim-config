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

vim.api.nvim_create_user_command(
    'NewFile',
    function(opts)
        -- Extract the directory and file name from the argument
        local full_path = opts.args
        local dir, file = full_path:match("(.-)([^\\/]-%.?([^%.\\/]*))$")

        -- Ensure the directory exists
        vim.fn.mkdir(dir, "p")

        -- Open the file in a new buffer
        vim.cmd('edit ' .. full_path)
    end,
    { nargs = 1, complete = 'file' }
)
  vim.g.neovide_input_macos_alt_is_meta = true
