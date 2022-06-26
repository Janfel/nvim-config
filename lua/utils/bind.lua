-- Keybinding Function

local utils = require("utils")

local function mapmodes(str)
	if str == "" then return {""} end
	if type(str) == "table" then return str end

	local chs = utils.chars(str)
	for i = 1, #chs do
		if chs[i] == " " then
			chs[i] = ""
		end
	end

	return chs
end

local function bind_1(mode, lhs, rhs, opts)
	-- TODO: Change to `true` for `<Nop>` and `false` for `del()` to free `nil`.
	local modes = mapmodes(mode)
	if rhs then
		vim.keymap.set(modes, lhs, rhs, opts)
	else
		vim.keymap.del(modes, lhs, opts)
	end
end

local function bindall_process_args(spec, mode)
	local off = mode and 1 or 0
	local args = mode and {mode} or {}
	local opts = {}

	for key, val in pairs(spec) do
		if type(key) == "number" then
			args[key+off] = val
		else
			opts[key] = val
		end
	end

	args[#args+1] = opts
	return args
end

local function bind(mode, lhs, rhs, opts)
	if not lhs then
		return function(specs)
			for _, spec in ipairs(specs) do
				bind_1(unpack(bindall_process_args(spec, mode)))
			end
		end
	else
		return bind_1(mode, lhs, rhs, opts)
	end
end

return bind
