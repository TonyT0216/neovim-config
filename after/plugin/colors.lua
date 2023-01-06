-- s/o ThePrimeagen

-- This is needed since this will prevent an error when Neovim's init.lua
-- is first called from a fresh install.
local has_nightfox, nightfox = pcall(require, 'nightfox')
if not has_nightfox then return end

nightfox.setup({
    disable_background = true
})

function ColorMyPencils(color)
    color = color or "duskfox"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

ColorMyPencils()
