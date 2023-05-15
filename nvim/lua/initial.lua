
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("core.options")

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

require("plugins.lazy-nvim")
require("keyBinding/key_mapping").common_key_setup({})
