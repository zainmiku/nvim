local G = require('G')
local M = {}

function M.config()

end

function M.lspSetup()
    require("mason-lspconfig").setup()
    local util = require "lspconfig/util"
    require("lspconfig").lua_ls.setup {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    }
    require("lspconfig").gopls.setup {
        cmd = { "gopls", "serve" },
        filetypes = { "go", "gomod" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
    }
    require 'lspconfig'.clangd.setup {
        cmd = { "clangd" },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        root_dir = util.root_pattern(
            '.clangd',
            '.clang-tidy',
            '.clang-format',
            'compile_commands.json',
            'compile_flags.txt',
            'configure.ac',
            '.git'
        )

    }
    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    G.keymap.set('n', '<space>e', G.diagnostic.open_float)
    G.keymap.set('n', '[d', G.diagnostic.goto_prev)
    G.keymap.set('n', ']d', G.diagnostic.goto_next)
    G.keymap.set('n', '<space>q', G.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    G.api.nvim_create_autocmd('LspAttach', {
        group = G.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            G.keymap.set('n', 'gD', G.lsp.buf.declaration, opts)
            G.keymap.set('n', 'gd', G.lsp.buf.definition, opts)
            G.keymap.set('n', 'K', G.lsp.buf.hover, opts)
            G.keymap.set('n', 'gi', G.lsp.buf.implementation, opts)
            G.keymap.set('n', '<C-k>', G.lsp.buf.signature_help, opts)
            G.keymap.set('n', '<space>wa', G.lsp.buf.add_workspace_folder, opts)
            G.keymap.set('n', '<space>wr', G.lsp.buf.remove_workspace_folder, opts)
            G.keymap.set('n', '<space>wl', function()
                print(G.inspect(G.lsp.buf.list_workspace_folders()))
            end, opts)
            G.keymap.set('n', '<space>D', G.lsp.buf.type_definition, opts)
            G.keymap.set('n', '<F2>', G.lsp.buf.rename, opts)
            G.keymap.set({ 'n', 'v' }, '<space>ca', G.lsp.buf.code_action, opts)
            G.keymap.set('n', 'gr', G.lsp.buf.references, opts)
            -- 格式化
            G.keymap.set('n', '<C-L>', function()
                G.lsp.buf.format { async = true }
            end, opts)
        end,
    })
end

function M.cmpSetup()
    local luasnip = require("luasnip")

    -- nvim-cmp setup
    local cmp = require("cmp")
    if cmp == nil then
        return
    end
    local lspkind = require("lspkind")

    cmp.setup({
        -- show source name in menu
        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol_text",
                menu = {
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    nvim_lua = "[Lua]",
                    dictionary = "[Dictionary]",
                    path = "[Path]",
                    cmp_tabnine = "[TabNine]",
                },
            }),
        },

        preselect = cmp.PreselectMode.None,
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            -- 上一个
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            -- 下一个
            ['<C-j>'] = cmp.mapping.select_next_item(),
            -- abort
            ["<C-c>"] = cmp.mapping.abort(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),

        sources = {
            { name = "neorg" },
            { name = "luasnip" },
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
            { name = "nvim_lsp_signature_help" },
            { name = "nvim_lua" },
        },
    })

    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline", max_item_count = 30 },
        }),
    })
    cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })
    cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
            { name = "luasnip",    priority = 100 },
            { name = "buffer",     keyword_length = 3 },
            { name = "dictionary", priority = 10,     max_item_count = 5, keyword_length = 3 },
        }),
    })

    cmp.setup.filetype("markdown", {
        sources = cmp.config.sources({
            { name = "luasnip",    priority = 100 },
            { name = "buffer",     keyword_length = 3 },
            { name = "dictionary", priority = 10,     max_item_count = 5, keyword_length = 3 },
        }),
    })
end

return M
