
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)



require("lazy").setup({
 ------- themes

    {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup ({
                style = 'cool'            })
--           require('onedark').load()
        end,
    },
--     {
--         "cpea2506/one_monokai.nvim",
--         config = function()
--             require('one_monokai').setup {}
--         end
--
--     },
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
    },


    change_detection = { notify = false },
    checker = {
        enabled = true,
        notify = false,
    },
    { "wakatime/vim-wakatime", lazy = false },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            parser_config.blade = {
                install_info = {
                    url = "https://github.com/EmranMR/tree-sitter-blade",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "blade",
            }


            require('nvim-treesitter.configs').setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "json", "php", "javascript", "blade" },
                auto_install = true,
                highlight = {
                    enable = true
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<Leader>gs",
                        node_incremental = "<Leader>go",
                        scope_incremental = "<Leader>sc",
                        node_decremental = "<Leader>nod",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                            ["at"] = "@tag.outer",
                            ["it"] = "@tag.inner",
                        },
                        selection_modes = {
                            ['@parameter.outer'] = 'v',
                            ['@function.outer'] = 'V',
                            ['@class.outer'] = '<c-v>',
                        },
                        include_surrounding_whitespace = true,
                    },
                },
            })
        end,
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function ()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require("nvim-tree").setup({
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    width = 40,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
                git = {
                    enable = true,
                    ignore = false,
                    timeout = 500,
                }
            })
        end,
    },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "neovim/nvim-lspconfig" },
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
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }),
            })
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {"mlaursen/vim-react-snippets"},
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
    { "rafamadriz/friendly-snippets" },
    {"saadparwaiz1/cmp_luasnip"},
    -- {"voldikss/vim-floaterm"},
    {'akinsho/toggleterm.nvim', version = "*", config = true,
        config = function ()
            require("toggleterm").setup({
                direction = 'vertical',
                size = 50
            })
        end,
    },
    {"pocco81/auto-save.nvim",
        config = function ()
            require("auto-save").setup ({})
        end
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = {'MunifTanjim/prettier.nvim'},
        config = function()
            local null_ls = require("null-ls")
            local prettier = require("prettier")

            local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
            local event = "BufWritePre"
            local async = event == "BufWritePost"

            null_ls.setup({
                sources = {},
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.keymap.set("n", "<Leader>f", function()
                            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
                        end, { buffer = bufnr, desc = "[lsp] format" })

                        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
                        vim.api.nvim_create_autocmd(event, {
                            buffer = bufnr,
                            group = group,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr, async = async })
                            end,
                            desc = "[lsp] format on save",
                        })
                    end

                    if client.supports_method("textDocument/rangeFormatting") then
                        vim.keymap.set("x", "<Leader>f", function()
                            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
                        end, { buffer = bufnr, desc = "[lsp] format" })
                    end
                end,
            })

            prettier.setup({
                bin = 'prettierd',
                filetypes = {
                    "css",
                    "graphql",
                    "html",
                    "javascript",
                    "javascriptreact",
                    "json",
                    "less",
                    "markdown",
                    "scss",
                    "typescript",
                    "typescriptreact",
                    "yaml",
                },
            })
        end,
    },

    {"stephpy/vim-php-cs-fixer"},
    {"sindrets/diffview.nvim"},
    {'simrat39/rust-tools.nvim'},
    {"honza/vim-snippets"},
    {"numToStr/Comment.nvim"},
    {"voldikss/vim-floaterm",
    config = function ()
        -- Normal mode mappings
        vim.keymap.set('n', '<leader>tf', ':FloatermNew<CR>', { silent = true, desc = 'Floaterm New' })
        vim.keymap.set('n', '<leader>tp', ':FloatermPrev<CR>', { silent = true, desc = 'Floaterm Prev' })
        vim.keymap.set('n', '<leader>tn', ':FloatermNext<CR>', { silent = true, desc = 'Floaterm Next' })
        vim.keymap.set('n', '<leader>tt', ':FloatermToggle<CR>', { silent = true, desc = 'Floaterm Toggle' })
        vim.keymap.set('n', '<leader>tk', ':FloatermKill<CR>', { silent = true, desc = 'Floaterm Kill' })

        -- Terminal mode mappings
        vim.keymap.set('t', '<leader>tf', '<C-\\><C-n>:FloatermNew<CR>', { silent = true, desc = 'Floaterm New' })
        vim.keymap.set('t', '<leader>tp', '<C-\\><C-n>:FloatermPrev<CR>', { silent = true, desc = 'Floaterm Prev' })
        vim.keymap.set('t', '<leader>tn', '<C-\\><C-n>:FloatermNext<CR>', { silent = true, desc = 'Floaterm Next' })
        vim.keymap.set('t', '<leader>tt', '<C-\\><C-n>:FloatermToggle<CR>', { silent = true, desc = 'Floaterm Toggle' })
        vim.keymap.set('t', '<leader>tk', '<C-\\><C-n>:FloatermKill<CR>', { silent = true, desc = 'Floaterm Kill' })
    end
},
{
    'ccaglak/larago.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim"
    }
},
{
    'TobinPalmer/rayso.nvim',
    cmd = { 'Rayso' },
    config = function()
        require('rayso').setup {}
    end
},
{  -- lazy
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

})

