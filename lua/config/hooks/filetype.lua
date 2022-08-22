local utils = require("config.utils")
local Augroup = utils.augroup
local HookTable = utils.HookTable


local function undo_ftplugin(code)
	if vim.b.undo_ftplugin then
		vim.b.undo_ftplugin = vim.b.undo_ftplugin .. " | " .. code
	else
		vim.b.undo_ftplugin = code
	end
end

local function defer_unset(opts)
	local stropts = { "setlocal " }
	for i = 1, #opts do
		stropts[2 * i] = opts[i]
		stropts[2 * i + 1] = "< "
	end
	undo_ftplugin(table.concat(stropts))
end

local function defer_unlet(vars)
	undo_ftplugin("unlet! " .. table.concat(vars, " "))
end


local T = HookTable.new()

---@diagnostic disable: redefined-local

local lisp_modes = { "lisp", "scheme", "clojure", "fennel" }
T:add(lisp_modes, function(T, ...)
	return T:run("lisp-common", ...)
end)

local shell_modes = { "sh", "csh", "wsh", "zsh", "bash", "mush", "tcsh", "gnash" }
T:add(shell_modes, function(T, ...)
	return T:run("shell-common", ...)
end)

local xml_modes = { "html", "sgml", "xhtml", "xml" }
T:add(xml_modes, function(T, ...)
	return T:run("xml-common", ...)
end)

---@diagnostic enable: redefined-local

local function use_tabs(indent)
	return function()
		defer_unset { "shiftwidth", "tabstop", "softtabstop", "expandtab" }
		vim.bo.shiftwidth = 0
		vim.bo.tabstop = indent
		vim.bo.softtabstop = 0
		vim.bo.expandtab = false
	end
end

local function use_spaces(indent, tabwidth)
	return function()
		defer_unset { "shiftwidth", "tabstop", "softtabstop", "expandtab" }
		vim.bo.shiftwidth = indent
		vim.bo.tabstop = tabwidth or vim.go.tabstop
		vim.bo.softtabstop = -1
		vim.bo.expandtab = true
	end
end

T:add("lisp-common", use_spaces(2, 8))
T:add("shell-common", use_tabs(4))
T:add("xml-common", use_spaces(2))

T:add("go", use_tabs(4))
T:add("lua", use_tabs(2))
T:add("markdown", use_spaces(2))
T:add("python", use_tabs(4))
T:add("rust", use_tabs(4))
T:add("vim", use_tabs(2))

T:add({ "xhtml", "xml" }, function()
	if vim.g.xml_syntax_folding then
		defer_unset { "foldmethod", "foldlevel" }
		vim.wo.foldmethod = "syntax"
		vim.wo.foldlevel = 1
	end
end)

T:add("man", function()
	defer_unset { "breakindent", "showbreak" }
	vim.wo.breakindent = true
	vim.wo.showbreak = " "
end)

Augroup "config.hooks.filetype:run_filetype_hooks" {
	"FileType", "*",
	desc = "Run filetype hooks in order",
	callback = function(info)
		local hook_table = require("config.hooks.filetype")
		for ft in vim.gsplit(info.match, ".", true) do
			hook_table:run(ft)
		end
	end
}

return T
