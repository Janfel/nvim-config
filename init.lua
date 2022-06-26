-- init.lua

local utils = require("utils")
local Augroup = require("utils.Augroup")
local bind = require("utils.bind")
local conf = require("utils.conf")
local package = require("utils.package")
local path = require("utils.path")

local confdir = conf.dir
local loadconf = conf.load
local defined = utils.predicate(vim.fn.exists)

loadconf "basic"
loadconf "filetypes"

if defined "g:vscode" then loadconf "vscode" end

if defined "g:neovide" then
	vim.g.neovide_cursor_animation_length = 0.03
	vim.g.neovide_remember_window_size = false
	vim.g.neovide_remember_window_position = false
end

if vim.o.loadplugins then
	loadconf "packages"
end
