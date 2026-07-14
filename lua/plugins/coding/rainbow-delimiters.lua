local gh = require('core.functions').gh

vim.pack.add { gh 'hiphish/rainbow-delimiters.nvim' }

require('rainbow-delimiters.setup').setup {}
