-- From LunarVim/nvim-basic-ide
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return packer.startup(function(use)
    use { "wbthomason/packer.nvim" }

    -- Colorscheme {
    use 'EdenEast/nightfox.nvim'
    use 'folke/tokyonight.nvim'
    use 'sainnhe/everforest'
    use 'sainnhe/sonokai'
    use 'savq/melange'
    -- }

    -- LSP {
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig'
    use 'WhoIsSethDaniel/mason-tool-installer.nvim'
    use 'simrat39/inlay-hints.nvim'
    use 'j-hui/fidget.nvim'
    use 'folke/neodev.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'jayp0521/mason-null-ls.nvim'
    -- }

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
