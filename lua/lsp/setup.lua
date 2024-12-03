local mason_lspconfig = require("mason-lspconfig")

-- Set up mason with LSP servers to automatically install
mason_lspconfig.setup({
    ensure_installed = { "lua_ls", "pyright", "ts_ls", "jdtls", "clangd", "rust_analyzer", "marksman"}, -- Add more servers as needed
})

-- Use mason-lspconfig to set up LSP servers automatically
mason_lspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({})
    end,
    ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })
    end,
    ["rust_analyzer"] = function()
        require("lspconfig").rust_analyzer.setup({
            -- Add any custom settings for rust_analyzer here
        })
    end,
    ["clangd"] = function()
        require("lspconfig").clangd.setup({
            -- Add any custom settings for clangd here
        })
    end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").clangd.setup({
    capabilities = capabilities,
})
