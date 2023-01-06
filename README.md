
# Neovim IDE Configuration


## Citations & Inspirations

My thanks to the following for making my Neovim journey an awesome experience.

- LunarVim/nvim-basic-ide [repository](https://github.com/LunarVim/nvim-basic-ide), and LunarVim/Neovim-from-scratch [repository](https://github.com/LunarVim/Neovim-from-scratch)
- ThePrimeagen's Neovim setup from his video ['0 to LSP: Neovim RC From Scratch'](https://www.youtube.com/watch?v=w7i4amO_zaE)
- tjdevries' config_manager [repository](https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim)

## Recommended Prerequisites

- Use a Neovim version manager, like [Bob](https://github.com/MordechaiHadad/bob).

This is definitely worth getting if you prefer to use neovim's nightly version in lieu of the stable version.

## Plugins Installed

### File Explorer

- [kyazdani42/nvim-tree](https://github.com/kyazdani42/nvim-tree.lua) in place of netrw.

### LSP

- [mason](https://github.com/williamboman/mason.nvim) for providing a hub for installing formatters, linters, and servers.
- [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim) for providing additional functionality.
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) provides configs for the Nvim lsp client.


### Syntax

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for syntax highlighting across multiple file types.

Currently, the setup will automatically install the syntax highlighting for css, help, html, javascript, lua, php, phpdoc, query, scss, typescript,  and vim.


### Startup

- [goolord/alpha.nvim](https://github.com/goolord/alpha-nvim) is used for the startup screen.

#### Dependencies
[nvim-telescope](https://github.com/nvim-telescope/telescope.nvim) is used for fuzzy finding files when the dashboard opens.
