local fn = vim.fn
local execute = vim.api.nvim_command

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end


local packer = require('packer')


packer.startup(function (use)
  use 'wbthomason/packer.nvim'
  -- use 'sheerun/vim-polyglot'

  -- help
  use { 'folke/which-key.nvim',
    requires = {{ 'nvim-lua/plenary.nvim' }}
  }

  -- ui
  use '~/Dev/@A/vim-trash-polka'
  use 'kyazdani42/nvim-web-devicons'
  use 'lukas-reineke/indent-blankline.nvim'
  use { 'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use { 'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
  }

  -- file tree
  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   requires = 'kyazdani42/nvim-web-devicons',
  --   config = function()
  --     vim.g['nvim_tree_disable_window_picker'] = 1
  --   end,
  -- }

  use 'preservim/nerdtree'
  use 'Xuyuanp/nerdtree-git-plugin'

  -- use 'justinmk/vim-dirvish'
  -- use 'kristijanhusak/vim-dirvish-git'

  -- tools
  use 'ibhagwan/fzf-lua'
  use 'vijaymarupudi/nvim-fzf'
  use { 'tpope/vim-fugitive' }

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'

  -- dev
  use 'pantharshit00/vim-prisma'
  use 'editorconfig/editorconfig-vim'
  use { 'terrortylor/nvim-comment',
    config = function()
    end
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
    'ray-x/lsp_signature.nvim',
    'jose-elias-alvarez/nvim-lsp-ts-utils',
  }
  use 'nvim-lua/lsp-status.nvim'
  use 'arkav/lualine-lsp-progress'

  use {'creativenull/diagnosticls-configs-nvim',
    run = table.concat({
      'npm i -g',
      'eslint',
      'eslint_d',
      'prettier',
    }, ' ')
  }

  -- https://github.com/hrsh7th/nvim-cmp
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-vsnip"
  use "f3fora/cmp-spell"
  use "hrsh7th/cmp-calc"
  use "hrsh7th/cmp-emoji"
  use "onsails/lspkind-nvim"
end)

require('lsp-status').config({
  indicator_errors = 'E:',
  indicator_warnings = 'W:',
  indicator_info = 'I:',
  indicator_hint = 'H:',
  indicator_ok = 'Ok',
  current_function = false,
  show_filename = false,

})


require('lualine').setup({
  options = {
    theme = '16color',
    section_separators = { left = '|', right = '|'},
    component_separators = { left = '|', right = '|'},
  },
  sections = {
    lualine_b = {{'diagnostics', sources={'nvim_lsp'}}, 'lsp_progress'},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {{'diff', colored = false}, 'filetype'}
  },
  extensions = {'quickfix', 'fugitive', 'fzf'}
})





-- local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

require('nvim-treesitter.configs').setup {
	ensure_installed = { "javascript", "tsx", "typescript", "php", "dockerfile" },
}

-- print(id)

require('nvim_comment').setup()
require "plugins/cmp"
require "lib/obsidian_cmp_source"
