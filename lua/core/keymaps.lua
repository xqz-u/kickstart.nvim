-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- quit & close buffer
vim.keymap.set('n', '<C-q>', '<cmd> bdelete <CR>', { desc = 'Close and [q]uit buffer' })

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x')

-- Resize with arrows
vim.keymap.set('n', '<Up>', '<cmd> resize -2 <CR>')
vim.keymap.set('n', '<Down>', '<cmd> resize +2 <CR>')
vim.keymap.set('n', '<Left>', '<cmd> vertical resize -2 <CR>')
vim.keymap.set('n', '<Right>', '<cmd> vertical resize +2 <CR>')

vim.keymap.set('n', '<leader><Tab>', '<cmd> bprevious <CR>', { desc = 'Switch to previous buffer' })

vim.keymap.set('n', '<leader>w', '<cmd> noautocmd w <CR>', { desc = 'Save file [w]ithout auto-formatting' })
