-- Shared helper functions.
local M = {}

-- LuaJIT's math.random isn't auto-seeded, so it yields the same sequence every
-- launch. Seed once, here, from the nanosecond clock so all callers get varied
-- randomness (and reproducibility isn't silently broken by re-seeding mid-run).
math.randomseed(vim.uv.hrtime())

--- Build a full GitHub URL from an "owner/repo" shorthand, to cut down on
--- repetition in `vim.pack.add` specs.
--- @param repo string owner/repo shorthand (e.g. 'folke/which-key.nvim')
--- @return string url full https GitHub URL
function M.gh(repo) return 'https://github.com/' .. repo end

--- Pick a random image from `folder` and build the `chafa` command that renders
--- it, ready to feed to a snacks' `terminal` dashboard section's `cmd`.
--- @param folder string directory to scan for images (relative to cwd or absolute)
--- @param opts? { width?: integer, height?: integer } render size (default 60x20)
--- @return string? cmd chafa command string, or nil if no image was found
function M.random_image_cmd(folder, opts)
  opts = opts or {}
  local size = string.format('%dx%d', opts.width or 60, opts.height or 20)
  local images = vim.fn.globpath(folder, '*.{png,jpg,jpeg,gif,webp}', false, true)
  if vim.tbl_isempty(images) then return nil end
  local image = images[math.random(#images)]
  return string.format('chafa %s --format symbols --size %s --stretch --symbols all; sleep .1', vim.fn.shellescape(image), size)
end

return M
