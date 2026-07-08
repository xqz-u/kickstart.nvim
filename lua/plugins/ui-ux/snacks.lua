local gh = require('core.functions').gh

vim.pack.add { gh 'folke/snacks.nvim' }

require('snacks').setup {
  lazygit = {},
  -- Enabled to clear the "notifier is not ready" checkhealth error; snacks and
  -- lazygit route their messages through it.
  notifier = { enabled = true },
  -- Free perf wins (no UX change): degrade gracefully on huge files / fast open.
  bigfile = { enabled = true },
  quickfile = { enabled = true },
  dashboard = {
    formats = {
      key = function(item) return { { '[', hl = 'special' }, { item.key, hl = 'key' }, { ']', hl = 'special' } } end,
    },
    sections = {
      { section = 'header' },
      { section = 'keys', icon = ' ', title = 'Keymaps', indent = 2, padding = 1 },
      { section = 'recent_files', icon = ' ', title = 'Recent Files', indent = 2, padding = 1 },
      { section = 'projects', icon = ' ', title = 'Projects', indent = 2, padding = 1 },
    },
  },
  terminal = {},
}

vim.keymap.set('n', '<leader>lg', function() Snacks.lazygit() end, { desc = '[L]azy[G]it' })

-- Options applied only to shells, keeping lazygit floating.
-- Window navigation in and out of terminal lives in 'core/keymaps.lua'.
local term_opts = { win = { position = 'bottom', height = 0.4 } }
-- <leader>tt toggles a single persistent shell (same terminal comes back);
-- <leader>tT always spawns a brand new, independent one.
vim.keymap.set({ 'n', 't' }, '<leader>tt', function() Snacks.terminal.toggle(nil, term_opts) end, { desc = '[T]oggle [T]erminal' })
vim.keymap.set({ 'n', 't' }, '<leader>tT', function() Snacks.terminal.open(nil, term_opts) end, { desc = 'New [T]erminal' })

-- Delete the current buffer via Snacks so the window/split layout survives.
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = '[B]uffer [D]elete' })
