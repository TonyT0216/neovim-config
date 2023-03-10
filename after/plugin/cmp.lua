local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local has_cmp_comparator, cmp_under_comparator = pcall(require, 'cmp-under-comparator')
if not has_cmp_comparator then
    return
end

local has_cmp_autopairs, cmp_autopairs = pcall(require, 'nvim.autopairs.completion.cmp')
if not has_cmp_autopairs then
    return
end

local compare = require 'cmp.config.compare'
local lspkind = require "lspkind"

local source_mapping = {
  buffer = "[Buffer]",
  luasnip = "[Snip]",
  nvim_lsp = "[Lsp]",
  nvim_lsp_signature_help = "[Sig]",
  nvim_lua = "[Lua]",
  path = "[Path]",
  rg = "[Rg]",
  treesitter = "[Tree]",
}

vim.o.completeopt = "menu,menuone,noselect"

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

cmp.setup {
  completion = { completeopt = "menu,menuone,noinsert", keyword_length = 1 },
  sorting = {
    priority_weight = 2,
    comparators = {
      compare.score,
      compare.recently_used,
      compare.offset,
      compare.exact,
      cmp_under_comparator.under,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format {
      ellipsis_char = '...',
      maxwidth = 40,
      mode = 'symbol_text',

      before = function(entry, vim_item)
        vim_item.kind = lspkind.presets.default[vim_item.kind]
        local menu = source_mapping[entry.source.name]
        vim_item.menu = menu
        return vim_item
      end,
    },
  },
  sources = {
    { name = "nvim_lsp", max_item_count = 15 },
    { name = 'nvim_lsp_signature_help', max_item_count = 5 },
    { name = "luasnip", max_item_count = 5 },
    { name = 'treesitter', max_item_count = 5 },
    { name = 'rg', max_item_count = 2 },
    { name = "buffer", max_item_count = 5 },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      border = { "???", "???", "???", "???", "???", "???", "???", "???" },
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
    },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}

cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
