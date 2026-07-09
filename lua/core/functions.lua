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

--- Enable buffer-local spell checking for prose. Skips scratch/nofile buffers
--- (LSP hover, signature-help floats, etc.) where `spell` — being window-local —
--- would otherwise leak and just add noise. In a Treesitter-highlighted code
--- buffer the checker is automatically scoped to the `@spell` ranges (comments
--- and docstrings), so identifiers and keywords are left alone.
--- @param lang? string value for 'spelllang' (default 'en_us')
function M.enable_spell(lang)
  if vim.bo.buftype ~= '' then return end
  vim.opt_local.spell = true
  vim.opt_local.spelllang = lang or 'en_us'
end

--- Pick a random image from `folder` and build the `chafa` command that renders
--- it, ready to feed to a snacks' `terminal` dashboard section's `cmd`.
--- @param folder string directory to scan for images (relative to cwd or absolute)
--- @param opts? { width?: integer, height?: integer, stretch?: boolean } render size (default 60x20, stretch on)
--- @return string? cmd chafa command string, or nil if no image was found
function M.random_image_cmd(folder, opts)
  opts = opts or {}
  local images = vim.fn.globpath(folder, '*.{png,jpg,jpeg,gif,webp}', false, true)
  if vim.tbl_isempty(images) then return nil end
  local image = images[math.random(#images)]
  local size = string.format('%dx%d', opts.width or 60, opts.height or 20)
  local stretch = opts.stretch ~= false and '--stretch' or ''
  return string.format(
    'chafa %s --format symbols --size %s %s --symbols all; sleep .1',
    vim.fn.shellescape(image),
    size,
    stretch
  )
end

return M
