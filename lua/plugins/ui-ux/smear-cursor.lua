local gh = require('core.functions').gh

vim.pack.add { gh 'sphamba/smear-cursor.nvim' }

require('smear_cursor').setup {
  distance_stop_animating = 0.5,
  stiffness = 0.6,
  trailing_stiffness = 0.5,
  damping = 0.7,

  particles_enabled = true,
  never_draw_over_target = true, -- if you want to actually see under the cursor
  hide_target_hack = true, -- same
  particle_spread = 1,
  particles_per_second = 500,
  particles_per_length = 50,
  particle_max_initial_velocity = 20,
  particle_velocity_from_cursor = 0.5,
  particle_damping = 0.15,
  particle_gravity = -50,
  min_distance_emit_particles = 0,
}

-- No particles in insert mode.
-- `smear-cursor` has no per-mode particle toggle, but `config.particles_enabled`
-- is re-read on every frame, so flip it around insert mode.
local config = require 'smear_cursor.config'

vim.api.nvim_create_autocmd('InsertEnter', {
  desc = 'Disable smear-cursor particles in insert mode',
  callback = function() config.particles_enabled = false end,
})
vim.api.nvim_create_autocmd('InsertLeave', {
  desc = 'Re-enable smear-cursor particles when leaving insert mode',
  callback = function() config.particles_enabled = true end,
})
