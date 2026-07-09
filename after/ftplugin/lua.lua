-- Visual guide at column 100 for Lua files.
vim.opt_local.colorcolumn = '100'

-- Spell-check prose only: Treesitter scopes this to comments and docstrings.
require('core.functions').enable_spell()
