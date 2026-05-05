-- smear-cursor.nvim: animated smear effect for the cursor
-- https://github.com/sphamba/smear-cursor.nvim
return {
  'sphamba/smear-cursor.nvim',
  event = 'VeryLazy',
  config = function()
    -- Pull a hex color from a highlight group; fall back through a list,
    -- and finally to a sensible default if nothing resolves.
    local function hl_color(groups, attr, fallback)
      for _, g in ipairs(groups) do
        local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = g, link = false })
        if ok and hl and hl[attr] then
          return string.format('#%06x', hl[attr])
        end
      end
      return fallback
    end

    -- Preferred: whatever the theme uses for `Function` (usually an accent
    -- color that pops against the background). Falls back to `Identifier`,
    -- `Keyword`, then `Cursor`, then a default.
    local function pick_smear_color()
      return hl_color({ 'Function', 'Identifier', 'Keyword', 'Cursor' }, 'fg', '#ff8800')
    end

    local function apply()
      require('smear_cursor').setup {
        -- Smear behaviour
        smear_between_buffers = true,
        smear_between_neighbor_lines = true,
        scroll_buffer_space = true,
        legacy_computing_symbols_support = false,
        smear_insert_mode = true,

        -- Long smear, fast landing
        stiffness = 0.9,
        trailing_stiffness = 0.3,
        trailing_exponent = 3,
        distance_stop_animating = 0.3,

        -- Theme-derived color
        cursor_color = pick_smear_color(),
      }
    end

    apply()

    -- Re-apply whenever the colorscheme changes.
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('SmearCursorThemeSync', { clear = true }),
      callback = apply,
    })
  end,
}
