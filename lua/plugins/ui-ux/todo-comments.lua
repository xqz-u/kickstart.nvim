-- Highlight todo, notes, etc in comments
local gh = require('core.functions').gh

vim.pack.add { gh 'folke/todo-comments.nvim' }

require('todo-comments').setup { signs = false }
