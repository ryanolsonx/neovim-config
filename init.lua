-- Bootstrap lazy.nvim
vim.g.mapleader = ' '
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require("lazy").setup({
  spec = {
    {
      "rose-pine/neovim",
      name = "rose-pine",
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd([[colorscheme rose-pine]])
      end
    },
    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local harpoon = require("harpoon")
        harpoon:setup()
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end)
      end
    },
    { 'sheerun/vim-polyglot' },
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>g', builtin.git_files, {})
        vim.keymap.set('n', '<leader>i', builtin.find_files, {})
        vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>b', builtin.buffers, {})
        -- vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
      end
    },
    { 'jbranchaud/vim-bdubs' }
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Options
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.clipboard = "unnamedplus"
vim.cmd([[set statusline+=%F]])
-- Keybindings
vim.keymap.set('n', '<Leader>e', '<cmd>!npx eslint %<cr>')
vim.keymap.set('n', '<Leader>s', '<cmd>!npx stylelint %<cr>')
vim.keymap.set('n', '<Leader>p', '<cmd>:silent %!prettier --stdin-filepath %<CR>')
