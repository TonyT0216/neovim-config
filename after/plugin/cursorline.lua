local has_cl, nvim_cursorline = pcall(require, 'nvim-cursorline')
if not has_cl then return end

nvim_cursorline.setup({
    cursorline = {
        enable = true,
        timeout = 1000,
        number = false,
    },
    cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
    }
})
