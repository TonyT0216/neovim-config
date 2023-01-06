local has_mason, mason = pcall(require, 'mason')
local has_masonlsp, mason_lsp = pcall(require, 'mason-lspconfig')
local has_lspconfig, lsp_config = pcall(require, 'lspconfig')

if not has_mason or not has_masonlsp or not has_lspconfig then
    return
end

local servers = {
    "bashls",
    "cssls",
    "html",
    "jsonls",
    "pyright",
    "sumneko_lua",
    "tsserver",
    "yamlls",
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
    ensure_installed = servers,
})
