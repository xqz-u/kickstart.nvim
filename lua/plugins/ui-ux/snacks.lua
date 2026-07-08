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
}

vim.keymap.set('n', '<leader>lg', function() Snacks.lazygit() end, { desc = '[L]azy[G]it' })
