-- You can easily change to a different colorscheme.
-- Change the name of the colorscheme plugin below, and then
-- change the command under that to load whatever the name of that colorscheme is.
--
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
local gh = require('core.functions').gh

vim.pack.add { gh 'folke/tokyonight.nvim' }

---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
  transparent = true,
  styles = {
    comments = { italic = true },
  },
  -- Brighten low-contrast text that gets washed out by terminal transparency.
  ---@param hl tokyonight.Highlights
  ---@param c ColorScheme
  on_highlights = function(hl, c)
    -- Default `c.comment` (#636da6) is too dim over a transparent background.
    hl.Comment = { fg = c.fg_dark, italic = true }
    -- Non-current line numbers use the same dim comment color by default.
    hl.LineNr = { fg = c.fg_gutter }
    -- Bottom message line / echo area.
    hl.MsgArea = { fg = c.fg }
    -- rainbow-delimiters paints brackets with a high-priority foreground, so
    -- MatchParen can't win the fg channel - meaning it is difficult to highlight the fg
    -- of the matching item
    hl.MatchParen = { bold = true, underline = true }
  end,
}

-- Load the colorscheme here.
-- Like many other themes, this one has different styles, and you could load
-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
vim.cmd.colorscheme 'tokyonight-moon'
