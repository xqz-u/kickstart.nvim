-- autopairs
-- https://github.com/windwp/nvim-autopairs

local gh = require('core.functions').gh

vim.pack.add { gh 'windwp/nvim-autopairs' }

require('nvim-autopairs').setup {}
