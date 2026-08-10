-- Project-wide search and replace, ripgrep-backed
--
local functions = require 'core.functions'

vim.pack.add { functions.gh 'MagicDuck/grug-far.nvim' }

require('grug-far').setup {}

local grug_far_keybindings = {
  { 'n', '<leader>rr', function() require('grug-far').open() end, { desc = '[R]eplace' } },
  {
    'n',
    '<leader>rw',
    function() require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } } end,
    { desc = '[R]eplace [W]ord' },
  },
  {
    'x',
    '<leader>rw',
    function() require('grug-far').with_visual_selection() end,
    { desc = '[R]eplace [W]ord (visual selection)' },
  },
  {
    'n',
    '<leader>rb',
    function() require('grug-far').open { prefills = { paths = vim.fn.expand '%' } } end,
    { desc = '[R]eplace in [B]uffer' },
  },
}
functions.set_keymaps(grug_far_keybindings)
