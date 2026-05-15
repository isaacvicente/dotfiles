-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard = ""

-- Disable Snacks.animate animations
vim.g.snacks_animate = false

-- New ui2
-- https://neovim.io/doc/user/news-0.12/#_ui
require("vim._core.ui2").enable()

-- vim.diagnostic.config({
--   virtual_lines = {
--     current_line = true,
--   },
-- })
