local has_hardmode, hardmode = pcall(require, 'hardmode')
if not has_hardmode then
    return
end

hardmode.setup {}
