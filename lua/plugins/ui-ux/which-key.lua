-- Useful plugin to show you pending keybinds.
local gh = require('core.functions').gh

vim.pack.add { gh 'folke/which-key.nvim' }

require('which-key').setup {
  -- Delay between pressing a key and opening which-key (milliseconds)
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  -- Document existing key chains
  spec = {
    { '<leader>s', group = '[S]earch', mode = { 'n', 'x' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>b', group = '[B]uffer' },
    { '<leader>g', group = '[G]it' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
  },
}
