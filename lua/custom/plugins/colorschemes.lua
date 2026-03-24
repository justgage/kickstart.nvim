-- Colorscheme Collection
-- A curated collection of beautiful Neovim themes

return {
  -- Tokyo Night (multiple variants)
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        styles = {
          comments = { italic = false },
        },
      }
    end,
  },

  -- Catppuccin (multiple variants)
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
  },

  -- Rose Pine (multiple variants)
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
  },

  -- Gruvbox
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
  },

  -- Nord
  {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
  },

  -- Kanagawa
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
  },

  -- Nightfox (multiple variants)
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
  },

  -- Everforest
  {
    'neanias/everforest-nvim',
    lazy = false,
    priority = 1000,
  },

  -- Dracula
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
  },

  -- One Dark
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
  },

  -- Solarized Osaka
  {
    'craftzdog/solarized-osaka.nvim',
    lazy = false,
    priority = 1000,
  },

  -- Material
  {
    'marko-cerovac/material.nvim',
    lazy = false,
    priority = 1000,
  },

  -- Oasis
  {
    'uhs-robert/oasis.nvim',
    lazy = false,
    priority = 1000,
  },

  -- Monokai Pro
  {
    'loctvl842/monokai-pro.nvim',
    lazy = false,
    priority = 1000,
  },

  -- Cyberdream
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
  },

  -- Melange
  {
    'savq/melange-nvim',
    lazy = false,
    priority = 1000,
  },

  {
    'yorumicolors/yorumi.nvim',
    lazy = false,
    priority = 1000,
  },
}
