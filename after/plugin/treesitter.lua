local has_treesitter, _ = pcall(require, 'nvim-treesitter')
if not has_treesitter then return end

local has_treesitter_configs, configs = pcall(require, 'nvim-treesitter.configs')
if not has_treesitter_configs then return end

configs.setup({
    auto_install = true,
    ensure_installed = { "css", "help", "html", "javascript", "lua", "php", "phpdoc", "query", "scss", "typescript", "vim" },

    highlight = {
        additional_vim_regex_highlighting = false,
        enable = true,
    },

    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    },

    query_linter = {
        enable = true,
        lint_events = {"BufWrite", "CursorHold"},
    },

})
