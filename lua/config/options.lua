-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- lua/config/options.lua
-- Options are automatically loaded before lazy.nvim startup
-- LazyVim settings
-- vim.g.lazyvim_check_order = false -- Uncomment to disable plugin order check

-- Python provider (optional, speeds up startup)
vim.g.python3_host_prog = vim.fn.expand("~/anaconda/bin/python") -- Adjust path as needed
-- Enable system clipboard synchronization
vim.opt.clipboard = "unnamedplus"
