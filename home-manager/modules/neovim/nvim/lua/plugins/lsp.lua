return {
	{
		"VonHeikemen/lsp-zero.nvim",
		event = { "BufReadPre", "BufNewFile" },
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			-- Snippet Collection (Optional)
			{ "rafamadriz/friendly-snippets" },

			{ "onsails/lspkind.nvim" },
		},
		config = function()
			local lsp = require("lsp-zero")
			lsp.preset("recommended")

			-- don't initialize this language server
			-- we will use rustaceanvim to setup rust_analyzer
			lsp.skip_server_setup({ "rust_analyzer" })

			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup({})
			local cmp_mappings = lsp.defaults.cmp_mappings({
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete({}),
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
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			local lspkind = require("lspkind")

			lsp.setup_nvim_cmp({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp_mappings,
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 75,
						ellipsis_char = "...",
						show_labelDetails = true,
					}),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "cmp_tabby" },
					{ name = "neorg" },
				},
			})

			local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function()
					vim.lsp.buf.format({ timeout_ms = 200 })
				end,
				group = format_sync_grp,
			})

			lsp.on_attach(function(_, bufnr)
				local opts = { buffer = bufnr, silent = true, remap = false }
				local bufmap = function(keys, func)
					vim.keymap.set("n", keys, func, opts)
				end

				bufmap("<leader>r", vim.lsp.buf.rename)
				bufmap("<leader>ca", vim.lsp.buf.code_action)
				bufmap("<leader>a", vim.lsp.buf.code_action)

				bufmap("gd", vim.lsp.buf.definition)
				bufmap("gD", vim.lsp.buf.declaration)
				bufmap("gI", vim.lsp.buf.implementation)
				bufmap("<leader>D", vim.lsp.buf.type_definition)
				bufmap("<leader>lf", vim.diagnostic.open_float)
				bufmap("[d", vim.diagnostic.goto_next)
				bufmap("]d", vim.diagnostic.goto_prev)

				bufmap("gr", require("telescope.builtin").lsp_references)
				bufmap("<leader>s", require("telescope.builtin").lsp_document_symbols)
				bufmap("<leader>S", require("telescope.builtin").lsp_dynamic_workspace_symbols)

				bufmap("K", vim.lsp.buf.hover)
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
			end)

			lsp.configure("nil_ls", {
				settings = {
					["nil"] = {
						formatting = { command = { "nixpkgs-fmt" } },
					},
				},
			})

			lsp.configure("volar", {
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
			})

			lsp.nvim_workspace()
			lsp.setup()

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				update_in_insert = true,
				underline = true,
				severity_sort = false,
				float = true,
			})
		end,
	},
}
