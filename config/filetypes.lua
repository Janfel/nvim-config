-- Filetype Config

local Augroup = require("utils.Augroup")
local set = vim.opt_local

local function configure(ft, func)
	return Augroup("filetypes.lua:configure_" .. ft) {
		"FileType", ft,
		desc = "Configure filetype " .. ft,
		callback = func,
	}
end

local function defer_unset(opts)
	local stropts = vim.tbl_map(function(opt) return opt .. "< " end, opts)
	local code = "setlocal " .. table.concat(stropts)
	if vim.b.undo_ftplugin then
		vim.b.undo_ftplugin = vim.b.undo_ftplugin .. " | " .. code
	else
		vim.b.undo_ftplugin = code
	end
end

local function defer_unlet(opts)
	local code = "unlet! " .. table.concat(opts, " ")
	if vim.b.undo_ftplugin then
		vim.b.undo_ftplugin = vim.b.undo_ftplugin .. " | " .. code
	else
		vim.b.undo_ftplugin = code
	end
end

local function use_tabs(indent)
	set.shiftwidth = 0
	set.tabstop = indent
	set.softtabstop = 0
	set.expandtab = false
	defer_unset { "shiftwidth", "tabstop", "softtabstop", "expandtab" }
end

local function use_spaces(indent, tabwidth)
	set.shiftwidth = indent
	set.tabstop = tabwidth or vim.go.tabstop
	set.softtabstop = -1
	set.expandtab = true
	defer_unset { "shiftwidth", "tabstop", "softtabstop", "expandtab" }
end


configure("lua", function() use_tabs(2) end)
configure("vim", function() use_tabs(2) end)

configure("html", function() use_spaces(2) end)
configure("sgml", function() use_spaces(2) end)
configure("xml",  function() 
	use_spaces(2)
	if vim.g.xml_syntax_folding then
		set.foldmethod = "syntax"
		set.foldlevel = 1
		defer_unset { "foldmethod", "foldlevel" }
	end
end)

configure("markdown", function() use_spaces(2) end)

configure("lisp",   function() use_spaces(2) end)
configure("scheme", function() use_spaces(2) end)

configure("sh",  function() use_tabs(4) end)
configure("zsh", function() use_tabs(4) end)
