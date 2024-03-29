local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  print "Plugin cmp failed to load."
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local cmp_next = function(fallback)
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
end

local cmp_prev = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
end

local cmp_toggle = function()
      if cmp.visible() then
        cmp.close()
      else
        cmp.complete()
      end
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-n>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ['<C-Space>'] = cmp.mapping(cmp_toggle, {"i", "s", "c"}),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.config.disable,
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(cmp_next, { "i", "c" }),
    ["<S-Tab>"] = cmp.mapping(cmp_prev, { "i", "c" }),
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[LUA]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "orgmode" },
  }),

  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  -- window = {
  --   documentation = {
  --     border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  --   }
  -- },
  -- view = {
  --   entries = 'native'
  -- },
  experimental = {
    ghost_text = false,
  },
}

-- Autocomplete in the "/" research
cmp.setup.cmdline('/', {
  mapping = {
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ["<C-t>"] = cmp.mapping(cmp.mapping.confirm(), { 'i', 'c' }),
    ["<TAB>"] = cmp.mapping(cmp_next, { 'i', 'c' }),
    ["<S-TAB>"] = cmp.mapping(cmp_prev, { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp_toggle, {"i", "s", "c"}),
  },
  sources = {
    { name = 'buffer' }
  },
})
-- Autocomplete in the ":" command line
cmp.setup.cmdline(':', {
  mapping = {
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ["<C-t>"] = cmp.mapping(cmp.mapping.confirm(), { 'i', 'c' }),
    ["<TAB>"] = cmp.mapping(cmp_next, { 'i', 'c' }),
    ["<S-TAB>"] = cmp.mapping(cmp_prev, { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp_toggle, {"i", "s", "c"}),
  },
  sources = cmp.config.sources({
    { name = 'path'  },
  }, {
    { name = 'cmdline' }
  })
})

