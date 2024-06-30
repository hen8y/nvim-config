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
    {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup ({
                style = 'cool'            })
            -- require('onedark').load()
        end,
    },
    {
        "cpea2506/one_monokai.nvim",
        config = function()
            require('one_monokai').setup {}
        end

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

            vim.filetype.add({
                pattern = {
                    ['.*%.blade%.php'] = 'blade',
                }
            })

            require('nvim-treesitter.configs').setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "json", "php", "javascript", "blade" },
                auto_install = true,
                highlight = {
                    enable = true
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<Leader>ss",
                        node_incremental = "<Leader>no",
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
            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            }
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require("lspconfig").lua_ls.setup {
                capabilities = capabilities
            }
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        "mlaursen/vim-react-snippets",
    },
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
    {"voldikss/vim-floaterm"},
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
    {'yaegassy/coc-blade', run = 'yarn install --frozen-lockfile'},
    {"sindrets/diffview.nvim"}
})

