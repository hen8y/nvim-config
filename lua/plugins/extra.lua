----- (named it extra cause they are mostky one line with lil to no configs)
---
---
---


return
{
    "sindrets/diffview.nvim",
    'simrat39/rust-tools.nvim',
    "honza/vim-snippets",
    "numToStr/Comment.nvim",
    "rafamadriz/friendly-snippets",
    { "wakatime/vim-wakatime", lazy = false },
    {
        'TobinPalmer/rayso.nvim',
        cmd = { 'Rayso' },
        config = function()
            require('rayso').setup {}
            map('v', '<leader>rs', require('lib.create').create_snippet)
        end
    },
    {
        'ccaglak/larago.nvim',
        dependencies = {
            "nvim-lua/plenary.nvim"
        }
    },

    {
        'ccaglak/namespace.nvim',
        keys = {
            { "<leader>la", "<cmd>GetClasses<cr>"},
            { "<leader>lc", "<cmd>GetClass<cr>"},
            { "<leader>ls", "<cmd>ClassAs<cr>"},
            { "<leader>ln", "<cmd>Namespace<cr>"},
        },
        dependencies = {
            "nvim-lua/plenary.nvim"
        }
    },
    {
        'MagicDuck/grug-far.nvim',
        config = function()
            require('grug-far').setup({
                engine = 'ripgrep'
            });
        end
    },
    {
        "andrewferrier/wrapping.nvim",
        config = function()
            require("wrapping").setup({
                notify_on_switch = false,
            })
            require('wrapping').soft_wrap_mode()
        end
    },

}
