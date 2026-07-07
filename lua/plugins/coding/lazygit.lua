local gh = require('core.functions').gh

vim.pack.add { gh 'kdheepak/lazygit.vim' }

require('lazygit')

vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })
