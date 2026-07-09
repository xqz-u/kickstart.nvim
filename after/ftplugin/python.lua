-- Visual guide at column 88 (ruff/Black default line-length).
-- Buffer-local, so it doesn't leak into other filetypes.
vim.opt_local.colorcolumn = '88'

-- Spell-check prose only: Treesitter scopes this to comments and docstrings.
require('core.functions').enable_spell()
