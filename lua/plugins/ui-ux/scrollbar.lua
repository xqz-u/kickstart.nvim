-- A thin scrollbar on the right edge, marking the proportional
-- position of git hunks and diagnostics along the whole file for discovery at a glance.
local gh = require('core.functions').gh

vim.pack.add {
  gh 'lewis6991/gitsigns.nvim', -- optional gitsigns integration;
  gh 'petertriho/nvim-scrollbar',
}

local scrollbar = require 'scrollbar'
local scrollbar_config = require 'scrollbar.config'

scrollbar.setup {
  handlers = { gitsigns = true },
  excluded_filetypes = { 'snacks_dashboard', 'snacks_picker_list' },
  marks = {
    Cursor = { text = '▶', highlight = 'CursorLineNr', gui = 'bold' },
    GitAdd = { text = '▍' },
    GitChange = { text = '▍' },
    GitDelete = { text = '▁' },
    -- Diagnostics: a solid block, and a heavier one when a
    -- single mark stands in for several collapsed lines (the two-glyph form).
    Error = { text = { '▍', '▉' } },
    Warn = { text = { '▍', '▉' } },
    Info = { text = { '▍', '▉' } },
    Hint = { text = { '▍', '▉' } },
  },
}

local function minimap_open()
  local ok, minimap = pcall(require, 'mini.map')
  if not ok then return false end
  local win = vim.tbl_get(minimap.current or {}, 'win_data', vim.api.nvim_get_current_tabpage())
  return win ~= nil and vim.api.nvim_win_is_valid(win)
end

-- Hide this scrollbar whenever a `mini.map` minimap is open for the current
-- tabpage.
-- `config.show` is nvim-scrollbar's global gate — `render()` reads it fresh every draw — so
-- flipping it and redrawing is enough; its own autocmds then no-op while the map is up.
local function sync_scrollbar_visibility()
  local show = not minimap_open()
  scrollbar_config.get().show = show
  if show then
    scrollbar.render()
  else
    scrollbar.clear()
  end
end

-- Scheduled so mini.map has finished creating/closing its window before we look.
vim.api.nvim_create_autocmd({ 'WinNew', 'WinClosed', 'WinEnter', 'TabEnter' }, {
  group = vim.api.nvim_create_augroup('scrollbar-hide-with-minimap', { clear = true }),
  callback = vim.schedule_wrap(sync_scrollbar_visibility),
})
