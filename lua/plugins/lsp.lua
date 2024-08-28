return
{
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" },
        config = function()
            require("mason-lspconfig").setup()

            local lspconfig = require('lspconfig')
            local configs = require('lspconfig.configs')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities
                    })
                end,
            }

            lspconfig.lua_ls.setup {
                capabilities = capabilities
            }
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')


            luasnip.filetype_extend("blade", {"html"})
            -- function to handle .class expansion
            local function handle_dot_expansion()
                local filetype = vim.bo.filetype
                if filetype ~= 'html' and filetype ~= 'vue' and filetype ~= 'blade' then
                    return false
                end

                local line = vim.api.nvim_get_current_line()
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local before_cursor = line:sub(1, col)
                local after_cursor = line:sub(col + 1)

                local class_name = before_cursor:match("%.([%w-]+)$")
                if class_name then
                    local snippet = string.format('<div class="%s"></div>', class_name)
                    local new_line = before_cursor:sub(1, -(#class_name + 2)) .. snippet .. after_cursor
                    vim.api.nvim_set_current_line(new_line)
                    vim.api.nvim_win_set_cursor(0, {vim.api.nvim_win_get_cursor(0)[1], #new_line - 6})
                    return true
                end
                return false
            end

            local function custom_tab()
                if cmp.visible() then
                    cmp.select_next_item()
                elseif handle_dot_expansion() then
                else
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
                end
            end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(custom_tab, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }
                })
            })
        end,
    },
    { "neovim/nvim-lspconfig" },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {"saadparwaiz1/cmp_luasnip"}
}
