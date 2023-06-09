return {

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows"))
    	and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp" or nil,
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

				-- https://www.reddit.com/r/neovim/comments/t7jl7p/cmp_autocomplete_in_golang_does_not_autoselect/
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
					{ name = "luasnip", priority = 100 },
					{ name = "nvim_lsp", priority = 90 },
					-- { name = "cmp_tabnine", priority = 98, max_item_count = 2, keyword_length = 3 },
					{ name = "buffer", priority = 80, max_item_count = 3, keyword_length = 5 },
					{ name = "path", priority = 80, max_item_count = 3, keyword_length = 3 },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lua" },
					-- disable fuzzy
					-- { name = "dictionary", priority = 10, max_item_count = 5, keyword_length = 5 },
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
					{ name = "luasnip", priority = 100 },
					{ name = "buffer", keyword_length = 3 },
					{ name = "dictionary", priority = 10, max_item_count = 5, keyword_length = 3 },
				}),
			})

			cmp.setup.filetype("markdown", {
				sources = cmp.config.sources({
					{ name = "luasnip", priority = 100 },
					{ name = "buffer", keyword_length = 3 },
					{ name = "dictionary", priority = 10, max_item_count = 5, keyword_length = 3 },
				}),
			})
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
}
