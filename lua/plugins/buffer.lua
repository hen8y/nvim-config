---- buffer related plugins
---
---
---



return
{
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = function()
            require("ibl").setup {
                indent = { char = '┊' },
                whitespace = {
                    remove_blankline_trail = false,
                },
                scope = { enabled = false },
            }
        end,
    },
    {'akinsho/bufferline.nvim', version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function ()
        require("bufferline").setup({})
    end
},
{
    'akinsho/toggleterm.nvim', version = "*", config = true,
    config = function ()
        require("toggleterm").setup({
            direction = 'vertical',
            size = 50
        })
    end,
},
}
