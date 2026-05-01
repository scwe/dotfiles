-- ==============================================================================
-- Neovim Configuration: init.lua
-- Revised for modern Neovim (v0.9.0+ recommended)
-- ==============================================================================

-- ==============================================================================
-- 1. General Settings
-- ==============================================================================
vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.showcmd = true
vim.opt.showmode = false -- Handled by lualine
vim.opt.background = "dark"
vim.opt.encoding = "utf8"
vim.opt.backupcopy = "yes"

-- Create backup, swap, and undo directories
vim.opt.backupdir = vim.fn.stdpath('data') .. '/backup'
vim.opt.directory = vim.fn.stdpath('data') .. '/swap'
vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'
vim.opt.wildignore = "*.meta,*.prefab,*.exe,*.zip,*.animation,*/node_modules/*,*\\node_modules\\*"

-- Make wrapped line movement more intuitive
vim.keymap.set({ 'n', 'v' }, 'j', 'gj')
vim.keymap.set({ 'n', 'v' }, 'k', 'gk')
vim.keymap.set({ 'i' }, '<Down>', '<C-o>gj')
vim.keymap.set({ 'i' }, '<Up>', '<C-o>gk')
vim.keymap.set({ 'n', 'v' }, '$', 'g$')
vim.keymap.set({ 'n', 'v' }, '0', 'g0')

-- ==============================================================================
-- 2. Plugin Management with lazy.nvim
-- ==============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- The plugin manager itself
  { "folke/lazy.nvim" },

  -- Colorscheme
  {
    'tomasr/molokai',
    priority = 1000, -- Ensure it loads first
    config = function()
      vim.cmd.colorscheme('molokai')
    end
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    -- CHANGE: Simplified to only use `opts`
    opts = {
      options = {
        theme = 'molokai',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      }
    },
  },

  -- ============================================================================
  -- LSP, Completion, and Linting Setup
  -- This single block replaces YCM, copilot.vim, and null-ls
  -- ============================================================================
{
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- All your other dependencies like nvim-cmp, copilot, etc. go here
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    { 'zbirenbaum/copilot.lua', cmd = 'Copilot', event = 'InsertEnter' },
    { 'zbirenbaum/copilot-cmp', dependencies = 'copilot.lua' },
  },
  config = function()
    -- Define required modules
    local cmp = require('cmp')
    local lspconfig = require('lspconfig')
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')

    -- Set up Mason
    mason.setup()

    -- ====================================================================
    -- UNIFIED LSP, COPILOT, AND CMP SETUP
    -- ====================================================================

    -- Define shared LSP settings for keymaps and capabilities
    local on_attach = function(client, bufnr)
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
      end
      map('gd', vim.lsp.buf.definition, 'Go to Definition')
      map('K', vim.lsp.buf.hover, 'Hover Documentation')
      map('<leader>rn', vim.lsp.buf.rename, 'Rename')
      map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    end

    -- Get capabilities from cmp-nvim-lsp
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- This is the main setup function. It tells mason-lspconfig how to
    -- configure each server.
    mason_lspconfig.setup({
      -- A list of servers to automatically install if they're not already present
      ensure_installed = { 'lua_ls', 'pyright' },

      -- The 'handlers' section is the key. We define a setup function for each server.
      handlers = {
        -- This is the default handler for servers that don't have a specific setup below.
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,

        -- Custom setup for lua_ls
        ['lua_ls'] = function()
          lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { 'vim' } },
              },
            },
          })
        end,
      },
    })

    -- Set up Copilot
    require('copilot').setup({
      panel = { enabled = false },
      suggestion = { enabled = false },
    })
    require('copilot_cmp').setup()

    -- Set up nvim-cmp
    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require('luasnip').expand_or_jumpable() then
            require('luasnip').expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require('luasnip').jumpable(-1) then
            require('luasnip').jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      -- THE ORDER OF SOURCES IS IMPORTANT!
      sources = cmp.config.sources({
        { name = 'nvim_lsp' }, -- LSP suggestions should come first
        { name = 'copilot' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      }),
    })
  end,
},

  -- File Explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- Required for icons
      'MunifTanjim/nui.nvim',
    },
    opts = {
      window = { width = 30 },
      -- Your original config tried to set ignore lists here,
      -- which should be done under `filesystem.filtered_items`
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            'node_modules',
            '.git',
          },
          -- Never show these files
          never_show = {
             "*.meta", "*.prefab"
          },
        }
      }
    },
    keys = {
      { '<leader>t', '<cmd>Neotree toggle<cr>', desc = 'Toggle Neo-tree' },
    }
  },

  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
    config = function()
      local telescope = require('telescope')
      defaults = {
          file_ignore_patterns = {
            'node_modules',
            '__pycache__',
            '%.git/',
            '%.meta',
          }
      }
      pickers = {
          find_files = {
            -- This tells Telescope to use `fd` and includes options
            -- to find hidden files and exclude the .git folder.
            find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
          },
      }
      telescope.setup({
        extensions = { fzf = {
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        }}
      })
      telescope.load_extension('fzf')
    end,
    keys = {
      { '<leader>b', '<cmd>Telescope buffers<cr>', desc = 'Find Buffer' },
      { '<C-p>', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
    }
  },

  -- Commenting
  { 'numToStr/Comment.nvim', opts = {} },

  -- Surrounding pairs
  -- CHANGE: Removed the duplicate tpope/vim-surround
  { 'kylechui/nvim-surround', tag = '*', opts = {} },

  -- Indent lines
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '│', tab_char = '│' },
      scope = { enabled = false },
    },
  },

  -- Syntax Highlighting
  -- CHANGE: Simplified to use `opts` and removed redundant old syntax plugins
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'javascript', 'typescript', 'jsx', 'html', 'css', 'lua', 'python' },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
})

-- ==============================================================================
-- 3. Mappings and Autocmds
-- ==============================================================================
-- Clear search highlight
vim.keymap.set('n', '<leader>,', ':nohlsearch<CR>', { desc = 'No Highlight Search' })
-- Navigate buffers
vim.keymap.set('n', '<leader>j', ':bp<CR>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<leader>k', ':bn<CR>', { desc = 'Next Buffer' })
-- Map jk to esc
vim.keymap.set({ 'i', 'v' }, 'jk', '<ESC>', { desc = 'jk -> Esc' })

-- Autocmds
local autocmd = vim.api.nvim_create_autocmd
autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
  desc = "Set Python indentation to 4 spaces"
})
autocmd({'BufRead', 'BufNewFile'}, {
  pattern = "*.gyp",
  command = "set filetype=json",
  desc = "Set gyp files to json filetype"
})
