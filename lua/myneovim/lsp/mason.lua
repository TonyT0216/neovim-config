local has_mason, mason = pcall(require, 'mason')
local has_masonlsp, mason_lsp = pcall(require, 'mason-lspconfig')
local has_mtl, mtl = pcall(require, 'mason-tool-installer')
local has_lspconfig, lsp_config = pcall(require, 'lspconfig')
local has_mason_null_ls, mason_null_ls = pcall(require, 'mason-null-ls')
local has_null_ls, null_ls = pcall(require, 'null-ls')

if not has_mason or not has_masonlsp or not has_lspconfig or not has_mtl or not has_mason_null_ls or not has_null_ls then
    return
end

local mason_servers = {
    "bashls",
    "cssls",
    "html",
    "jsonls",
    "pyright",
    "sumneko_lua",
    "tsserver",
    "yamlls",
}

local mtl_servers = {
    "bash-language-server",
    "css-lsp",
    "html-lsp",
    "json-lsp",
    "lua-language-server",
    "pyright",
    "stylua",
    "typescript-language-server",
    "yaml-language-server"
}

local settings = {
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lsp.setup({
    automatic_installation = true,
    automatic_setup = false,
    ensure_installed = mason_servers,
})

local opts = {}

for _, server in pairs(mason_servers) do
	opts = {
		on_attach = require("myneovim.lsp.handlers").on_attach,
		capabilities = require("myneovim.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "myneovim.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lsp_config[server].setup(opts)
end

mtl.setup({
    ensure_installed = mtl_servers,
    run_on_start = true,
    start_delay = 3000,
})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup {
  debug = false,
  sources = {
    diagnostics.codespell,
    diagnostics.eslint_d,
    formatting.stylua,
  },
}

mason_null_ls.setup({
    automatic_installation = true,
    automatic_setup = false,
    ensure_installed = nil,
})
