local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local utils = require("core.utils")

local custom_on_attach = function(client, bufnr)
	utils.load_mappings("lspconfig", { buffer = bufnr })

	if client.server_capabilities.signatureHelpProvider then
		require("nvchad_ui.signature").setup(client)
	end

	if not utils.load_config().ui.lsp_semantic_tokens then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

local servers = {
	"html",
	"cssls",
	"svelte",
	"tsserver",
	"astro",
	"svelte",
	"pyright",
	"tailwindcss",
	"rust_analyzer",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig.gopls.setup({
	on_attach = custom_on_attach,
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
})
--[[ 
lspconfig.denols.setup({
	on_attach = custom_on_attach,
	root_dir = util.root_pattern("deno.json", "deno.jsonc"),
	init_options = {
		lint = true,
	},
})
 ]]
lspconfig.emmet_ls.setup({
	capabilities = capabilities,
	init_options = {
		html = {
			options = {
				["bem.enabled"] = true,
			},
		},
	},
})

lspconfig.volar.setup({
	init_options = {
		typescript = {
			-- tsdk = '/path/to/.npm/lib/node_modules/typescript/lib'
			-- Alternative location if installed as root:
			tsdk = "/home/berht/.local/share/fnm/node-versions/v20.9.0/installation/lib/node_modules/typescript/lib/",
			-- "/home/berht/local/.fnm/node-versions/v18.12.0/installation/lib/node_modules/typescript/lib",
		},
	},
})

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	update_in_insert = true,
	float = {
		source = "always", -- Or "if_many"
	},
})
