-- tiny-glimmer.nvim: animated highlight for yank/paste/undo/redo/search
-- https://github.com/rachartier/tiny-glimmer.nvim
return {
  'rachartier/tiny-glimmer.nvim',
  event = 'VeryLazy',
  opts = {
    enabled = true,
    default_animation = {
      name = 'fade',
      settings = {
        max_duration = 1000,
        chars_for_max_duration = 8,
        from_color = '#FFD700', -- bright gold
      },
    },

    overwrite = {
      auto_map = true,

      yank = {
        enabled = true,
        default_animation = {
          name = 'fade',
          settings = {
            max_duration = 1000,
            chars_for_max_duration = 8,
            from_color = '#FFD700', -- gold flash
          },
        },
      },
      paste = {
        enabled = true,
        default_animation = {
          name = 'bounce',
          settings = {
            max_duration = 1200,
            chars_for_max_duration = 10,
            oscillation_count = 3,
            from_color = '#00FFAA', -- bright teal
          },
        },
      },
      undo = {
        enabled = true,
        default_animation = {
          name = 'fade',
          settings = {
            max_duration = 1000,
            chars_for_max_duration = 8,
            from_color = '#FF3355', -- vivid red
          },
        },
      },
      redo = {
        enabled = true,
        default_animation = {
          name = 'fade',
          settings = {
            max_duration = 1000,
            chars_for_max_duration = 8,
            from_color = '#33FF66', -- vivid green
          },
        },
      },
      search = {
        enabled = true,
        default_animation = {
          name = 'fade',
          settings = {
            max_duration = 300,        -- short and sweet
            chars_for_max_duration = 5,
            from_color = '#7AA2F7',    -- soft blue, not screaming
          },
        },
        next_mapping = 'nzzzv',
        prev_mapping = 'Nzzzv',
      },
    },

    -- Global animation tuning (used as fallbacks).
    animations = {
      fade = { max_duration = 1000, chars_for_max_duration = 8 },
      reverse_fade = { max_duration = 1000, chars_for_max_duration = 8 },
      bounce = { max_duration = 1200, chars_for_max_duration = 10, oscillation_count = 3 },
      left_to_right = { max_duration = 800, chars_for_max_duration = 30, lingering_time = 150 },
      pulse = { max_duration = 1200, chars_for_max_duration = 8, intensity = 2.0, pulse_count = 4 },
      rainbow = { max_duration = 1500, chars_for_max_duration = 10 },
      hue = { max_duration = 1000, chars_for_max_duration = 10 },
    },

    virt_text = {
      priority = 2048,
    },
  },
}
