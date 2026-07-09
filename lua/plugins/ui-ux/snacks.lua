local functions = require 'core.functions'

vim.pack.add { functions.gh 'folke/snacks.nvim' }

-- Shared between the chafa render size and the dashboard section height so the
-- terminal pane is exactly as tall as the image it renders.
local image_width, image_height = 60, 20

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
      key = function(item)
        return { { '[', hl = 'special' }, { item.key, hl = 'key' }, { ']', hl = 'special' } }
      end,
    },
    pane_gap = 4,
    sections = {
      {
        section = 'terminal',
        cmd = functions.random_image_cmd(
          vim.fn.join({ vim.fn.stdpath 'config', 'images' }, '/'),
          { width = image_width, height = image_height, stretch = false }
        ),
        width = image_width,
        height = image_height,
      },
      { pane = 2, section = 'header' },
      { pane = 2, section = 'keys', icon = ' ', title = 'Keymaps', indent = 2, padding = 1 },
      {
        pane = 2,
        section = 'recent_files',
        icon = ' ',
        title = 'Recent Files',
        indent = 2,
        padding = 1,
      },
      -- { pane = 2, section = 'projects', icon = ' ', title = 'Projects', indent = 2, padding = 1 },
    },
  },
  terminal = {},
  image = {},
  picker = {},
}

-- Under '<leader>gs' as to signify 'git status' (similar to magit in emacs)
vim.keymap.set('n', '<leader>gs', function() Snacks.lazygit() end, { desc = 'LazyGit' })

-- Snacks picker for files: previews images inline, unlike Telescope's previewer.
vim.keymap.set(
  'n',
  '<leader>sf',
  function()
    Snacks.picker.files {
      matcher = { frecency = true, sort_empty = true },
    }
  end,
  { desc = '[S]earch [F]iles' }
)

-- Reopen the dashboard on demand (not just at startup).
vim.keymap.set('n', '<leader>d', function() Snacks.dashboard.open() end, { desc = '[D]ashboard' })

-- Options applied only to shells, keeping lazygit floating.
-- Window navigation in and out of terminal lives in 'core/keymaps.lua'.
local term_opts = { win = { position = 'bottom', height = 0.4 } }
-- <leader>tt toggles a single persistent shell (same terminal comes back);
-- <leader>tT always spawns a brand new, independent one.
vim.keymap.set(
  { 'n', 't' },
  '<leader>tt',
  function() Snacks.terminal.toggle(nil, term_opts) end,
  { desc = '[T]oggle [T]erminal' }
)
vim.keymap.set(
  { 'n', 't' },
  '<leader>tT',
  function() Snacks.terminal.open(nil, term_opts) end,
  { desc = 'New [T]erminal' }
)

-- Delete the current buffer via Snacks so the window/split layout survives.
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = '[B]uffer [D]elete' })
