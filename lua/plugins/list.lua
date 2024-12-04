return {
    -- Lazy.nvim itself
    {
        "folke/lazy.nvim",
        lazy = false,
        priority = 1000,
    },

    {
        "morhetz/gruvbox",
        lazy = false,
        config = function()
            vim.cmd("colorscheme gruvbox")
        end
    },

    -- file tree plugin : nvim-tree
    {
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons", -- Optional icons for file types
        },
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 30,
                    side = "left",
                },

                renderer = {
                    icons = {
                        show = { file = true, folder = true, folder_arrow = true, git = true }
                    }
                },
                diagnostics = {
                    enable = true,
                    icons = {
                        hint = "",
                        info = "",
                        warning = "",
                        error = "",
                    },
                },
            })
        end
    },

    -- Bufferline for tab-like buffer management
    {
        "akinsho/bufferline.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                options = {
                    diagnostics = "nvim_lsp",       -- Show LSP diagnostics in buffer tabs
                    show_buffer_icons = true,       -- Show file type icons
                    show_buffer_close_icons = true, -- Show close icon for each buffer
                    separator_style = "slant",      -- Style of the separators between tabs
                    indicator_icon = "|",
                    show_tab_indicators = true,
                    enforce_regular_tabs = true,
                },
            })
        end,
    },
    -- Mason for managing external tools (LSPs, linters, formatters)
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason-LSPconfig for automatic LSP integration
    {
        "williamboman/mason-lspconfig.nvim",
        requires = { "neovim/nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup({
                automatic_installation = true, -- Automatically install configured servers
            })
        end,
    },

    -- lsp plugin : nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- LSP servers setup
            local lspconfig = require("lspconfig")
            -- Example setup for Python (pyright)
            lspconfig.pyright.setup {}

            -- Example setup for Lua (lua_ls)
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            }
        end
    },

    -- Autocompletion setup
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",    -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer",      -- Buffer source
            "hrsh7th/cmp-path",        -- Path source
            "hrsh7th/cmp-cmdline",     -- Command-line source
            "L3MON4D3/LuaSnip",        -- Snippet engine
            "saadparwaiz1/cmp_luasnip" -- Snippet completions
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- LuaSnip for snippet expansion
                    end,
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
                    ["<C-Space>"] = cmp.mapping.complete(),            -- Trigger completion
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
                formatting = {
                    format = function(entry, vim_item)
                        -- Customize icons for better visual feedback
                        -- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "", vim_item.kind)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                experimental = {
                    ghost_text = true, -- Display inline hints
                },
            })
        end,
    },

    -- git integration
    {
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = "+" },
                    change       = { text = "~" },
                    delete       = { text = "_" },
                    topdelete    = { text = "‾" },
                    changedelete = { text = "~" },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Key mappings for Git actions
                    map("n", "<leader>hs", gs.stage_hunk)      -- Stage hunk
                    map("n", "<leader>hr", gs.reset_hunk)      -- Reset hunk
                    map("n", "<leader>hp", gs.preview_hunk)    -- Preview hunk
                    map("n", "<leader>hu", gs.undo_stage_hunk) -- Undo stage
                    map("n", "<leader>hb", function() gs.blame_line({ full = true }) end)
                end
            })
        end,
    },

    -- integrated term
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<S-CR>]], -- Open terminal with Ctrl+\
                shade_terminals = true,
                direction = "float",       -- Use floating terminal window
            })
        end,
    },

    -- formating
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettier,     -- For JavaScript, TypeScript, etc.
                    null_ls.builtins.formatting.clang_format, -- For C/C++
                    -- Add more formatters here if needed
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f",
                            "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { noremap = true, silent = true })
                    end
                end,
            })
        end,
    },

    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true, -- Enable Treesitter integration for better pairing
            })
        end,
    },

    -- markdown preview
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = { "markdown" },
        config = function()
            vim.g.mkdp_auto_start = 1
            vim.g.mkdp_browser = "firefox" -- Use your preferred browser
        end,
    },

    -- plantuml preview
    {
        "weirongxu/plantuml-previewer.vim",
        dependencies = {
            "tyru/open-browser.vim", -- Required for browser preview functionality
        }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "cpp" }, -- Add other languages if needed
                highlight = { enable = true },
                indent = { enable = true },
                folding = { enable = true },
            })
            -- Enable folding based on Treesitter
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
        end,
    }

}
