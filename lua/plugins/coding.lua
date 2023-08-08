return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        after = "mason.nvim",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            require("config/coding").lspSetup()
        end,

    },
    -- snippets
    {
        "L3MON4D3/LuaSnip",
        after = "nvim-cmp",
        event = { "TextChanged" },
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },

    },

    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        config = function()
            require("config/coding").cmpSetup()
        end,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind-nvim"
        },
    },
    {
        'windwp/nvim-autopairs',
        after = "nvim-cmp",
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
}
