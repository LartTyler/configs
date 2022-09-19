local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {}),
})

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' },
	}, {}),
})

local on_attach = function(client, buf)
	vim.api.nvim_buf_set_option(buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local function set_keymap(key, func) vim.keymap.set('n', key, func, { noremap = true, silent = true, buffer = buf }) end

	set_keymap('gd', vim.lsp.buf.definition)
	set_keymap('K', vim.lsp.buf.hover)
	set_keymap('<leader>r', vim.lsp.buf.rename)
	set_keymap('<leader>a', vim.lsp.buf.code_action)
	set_keymap('gr', vim.lsp.buf.references)
	set_keymap('<leader>e', vim.diagnostic.open_float)
	set_keymap('[d', vim.diagnostic.goto_prev)
	set_keymap(']d', vim.diagnostic.goto_next)
	set_keymap('<leader>f', vim.lsp.buf.formatting)
end

local lsp_flags = {
	debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')

lspconfig['tsserver'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}

require('rust-tools').setup({
	tools = {
		inlay_hints = {
			only_current_line = true,
		},
	},
	server = {
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
		['rust-analyzer'] = {
			cargo = {
				allFeatures = true,
			},
			completion = {
				postfix = {
					enable = false,
				},
			},
			checkOnSave = {
				command = 'clippy',
			},
		},
	},
})
