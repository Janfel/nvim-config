-- init.lua

if vim.fn.has "vim_starting" == 0 then
	local clear_cache = require("utils").clear_cache
	clear_cache "utils"
end

local loadconf = require("utils.conf").load

loadconf "basic"
loadconf "filetypes"

if vim.g.vscode then
	-- VSCode specific configuration.
	-- See: https://github.com/vscode-neovim/vscode-neovim
end

if vim.g.neovide then
	vim.g.neovide_cursor_animation_length = 0.03
	vim.g.neovide_remember_window_size = false
	vim.g.neovide_remember_window_position = false
end

if vim.o.loadplugins then
	loadconf "packages"
end
