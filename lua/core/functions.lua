-- Shared helper functions.
local M = {}

--- Build a full GitHub URL from an "owner/repo" shorthand, to cut down on
--- repetition in `vim.pack.add` specs.
--- @param repo string owner/repo shorthand (e.g. 'folke/which-key.nvim')
--- @return string url full https GitHub URL
function M.gh(repo) return 'https://github.com/' .. repo end

return M
