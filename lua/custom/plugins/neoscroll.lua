-- neoscroll.nvim: smooth scrolling
-- https://github.com/karb94/neoscroll.nvim
return {
  'karb94/neoscroll.nvim',
  event = 'VeryLazy',
  config = function()
    local neoscroll = require 'neoscroll'
    neoscroll.setup {
      -- All keys that will be mapped. Leave empty to map them manually below.
      mappings = {
        '<C-u>', '<C-d>',
        '<C-b>', '<C-f>',
        '<C-y>', '<C-e>',
        'zt', 'zz', 'zb',
      },
      -- (gg/G handled with custom mappings below for line-targeted scroll.)
      hide_cursor = true,          -- hide cursor while scrolling
      stop_eof = true,             -- stop at <EOF> when scrolling downwards
      respect_scrolloff = false,   -- stop scrolling when cursor reaches scrolloff
      cursor_scrolls_alone = true, -- cursor keeps scrolling even if the window can't
      duration_multiplier = 1.0,   -- global duration multiplier
      easing = 'quadratic',        -- default easing: linear|quadratic|cubic|quartic|quintic|circular|sine
      pre_hook = nil,
      post_hook = nil,
      performance_mode = false,
    }

    -- Custom mappings with nicer durations/easings.
    local keymap = {
      ['<C-u>'] = function() neoscroll.ctrl_u { duration = 90,  easing = 'quadratic' } end,
      ['<C-d>'] = function() neoscroll.ctrl_d { duration = 90,  easing = 'quadratic' } end,
      ['<C-b>'] = function() neoscroll.ctrl_b { duration = 180, easing = 'quadratic' } end,
      ['<C-f>'] = function() neoscroll.ctrl_f { duration = 180, easing = 'quadratic' } end,
      ['<C-y>'] = function() neoscroll.scroll(-0.1, { move_cursor = false, duration = 50 }) end,
      ['<C-e>'] = function() neoscroll.scroll(0.1,  { move_cursor = false, duration = 50 }) end,
      ['zt']    = function() neoscroll.zt { half_win_duration = 90 } end,
      ['zz']    = function() neoscroll.zz { half_win_duration = 90 } end,
      ['zb']    = function() neoscroll.zb { half_win_duration = 90 } end,
      -- gg / G: smooth-scroll to top / bottom of buffer.
      -- For long distances, jump instantly to within ~1 screen of the
      -- destination, then animate the final stretch. Keeps animation length
      -- bounded so big files don't feel sluggish.
      ['gg']    = function()
        local target = vim.v.count > 0 and vim.v.count or 1
        local win_h  = vim.api.nvim_win_get_height(0)

        if math.abs(vim.fn.line('.') - target) > win_h then
          -- Teleport to ~1 screen below target, then animate up to it.
          local jump_to = math.min(target + win_h, vim.fn.line('$'))
          vim.cmd('normal! ' .. jump_to .. 'G')
        end
        local lines = target - vim.fn.line('.')
        neoscroll.scroll(lines, { move_cursor = true, duration = 150, easing = 'quadratic' })
      end,
      ['G']     = function()
        local target = vim.v.count > 0 and vim.v.count or vim.fn.line('$')
        local win_h  = vim.api.nvim_win_get_height(0)

        if math.abs(target - vim.fn.line('.')) > win_h then
          -- Teleport to ~1 screen before target, then animate down to it.
          local jump_to = math.max(1, target - win_h)
          vim.cmd('normal! ' .. jump_to .. 'G')
        end
        local lines = target - vim.fn.line('.')
        neoscroll.scroll(lines, { move_cursor = true, duration = 150, easing = 'quadratic' })
      end,
    }
    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func, { silent = true, desc = 'neoscroll: ' .. key })
    end
  end,
}
