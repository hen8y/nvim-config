return
{
    {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup ({
                style = 'cool'
            })
            -- require('onedark').load()
        end,
    },
    {
        "cpea2506/one_monokai.nvim",
        config = function()
            -- require('one_monokai').setup {}
        end

    },
    {
        'ribru17/bamboo.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('bamboo').setup {
                style = 'vulgaris',
                toggle_style_key = nil,
                toggle_style_list = { 'vulgaris', 'multiplex', 'light' },
                transparent = false,
                dim_inactive = false,
                term_colors = true,
                ending_tildes = false,
                cmp_itemkind_reverse = false,
            }
            require('bamboo').load()
        end,
    }
}

