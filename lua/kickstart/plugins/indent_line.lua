-- Add indentation guides even on blank lines

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help ibl`
local gh = require('core/functions').gh

vim.pack.add { gh 'lukas-reineke/indent-blankline.nvim' }

require('ibl').setup {}
