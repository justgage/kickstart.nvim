-- Active-window emphasis:
--   - tint.nvim dims inactive windows
--   - cursorline shows only in the active window
-- https://github.com/levouh/tint.nvim
return {
  'levouh/tint.nvim',
  event = 'VeryLazy',
  config = function()
    require('tint').setup {
      tint = -45,            -- amount to dim inactive windows (negative = darker)
      saturation = 0.6,      -- 0 = grayscale, 1 = no desaturation
      transforms = require('tint').transforms.SATURATE_TINT,
      tint_background_colors = true,
      highlight_ignore_patterns = {
        'WinSeparator', 'Status.*', 'NeoTree.*', 'TelescopePrompt.*', 'TelescopeBorder',
        -- Keep the gutter at full brightness even on inactive windows so line
        -- numbers / signs / diagnostics stay legible.
        'LineNr', 'LineNrAbove', 'LineNrBelow', 'CursorLineNr',
        'SignColumn', 'FoldColumn', 'EndOfBuffer',
        'GitSigns.*', 'DiagnosticSign.*', 'Diagnostic.*',
        -- Don't dim the winbar / its lualine fill so the tab pill stays vivid
        -- and its background matches Normal on inactive windows too.
        'WinBar', 'WinBarNC', 'WinBar.*', 'lualine_.*',
      },
      window_ignore_function = function(winid)
        local bufid   = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_get_option_value('buftype',  { buf = bufid })
        local floating = vim.api.nvim_win_get_config(winid).relative ~= ''
        -- Don't tint floating windows or special buffers (terminals, prompts, etc.)
        return floating or buftype ~= ''
      end,
    }

    -- Cursorline only in the active window.
    local cursorline_group = vim.api.nvim_create_augroup('ActiveCursorline', { clear = true })
    vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'InsertLeave' }, {
      group = cursorline_group,
      callback = function()
        if vim.bo.buftype == '' then
          vim.wo.cursorline = true
        end
      end,
    })
    vim.api.nvim_create_autocmd({ 'WinLeave', 'InsertEnter' }, {
      group = cursorline_group,
      callback = function() vim.wo.cursorline = false end,
    })
  end,
}
