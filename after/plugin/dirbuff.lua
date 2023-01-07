local has_dirbuf, dirbuf = pcall(require, 'dirbuf')
if not has_dirbuf then
    return
end

dirbuf.setup({
    hash_padding = 2,
    show_hidden = true,
    sort_order = "default",
    write_cmd = "DirbufSync",
})