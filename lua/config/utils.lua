-- Utilities

--- [[ Augroup ]] ---

local function augroup(name, group_opts)
	local group = vim.api.nvim_create_augroup(name, group_opts or {})
	local function func(spec)
		local event = spec[1]
		local opts = vim.tbl_extend("force", { group = group, pattern = spec[2] }, spec)
		opts[1] = nil
		opts[2] = nil
		vim.api.nvim_create_autocmd(event, opts)
		return func
	end
	return func
end

--- [[ Bootstrap ]] ---

local function file_exists(path)
	return vim.fn.glob(vim.fn.fnameescape(path), true) ~= ""
end

local function ensure_package(name, url, package_dir)
	local install_dir = package_dir .. "/start/" .. name
	if file_exists(install_dir) then return end

	print("Cloning new copy of " .. name .. " into " .. install_dir .. " from " .. url)
	local output = vim.fn.system { "git", "clone", "--depth=1", "--", url, install_dir }
	assert(vim.v.shell_error == 0, output)
end

--- [[ Startup ]] ---

local has = vim.fn.has
local during_startup = false
local function is_startup()
	during_startup = during_startup or has("vim_starting")
	return during_startup
end

--- [[ Safe Calling ]] ---

local function safe_call(func, ...)
	local result = { xpcall(func, debug.traceback, ...) }
	if not result[1] then
		vim.notify(result[2], vim.log.levels.ERROR)
		return
	end
	return unpack(result, 2)
end

local function safe_require(modname)
	return safe_call(require, modname)
end

--- [[ Vim Wrappers ]] ---

local function bool(obj)
	return obj and obj ~= 0
end

local function predicate(func)
	return function(...) return bool(func(...)) end
end

local function packadd(pkgname) -- TODO Use this
	return vim.cmd((is_startup() and "packadd! " or "packadd ") .. pkgname)
end

--- [[ Mappings ]] ---

local modestr_replacements = { _ = "", m = "", e = "!" }

local function splitmodestr(modestr)
	local len = #modestr
	if len == 1 then
		return modestr_replacements[modestr] or modestr
	end

	local sub = string.sub
	local chars = {}
	for i = 1, len do
		local ch = sub(modestr, i, i)
		chars[i] = modestr_replacements[ch] or ch
	end
	return chars
end


local function map1(mode, lhs, rhs, opts)
	-- print("map1(", mode, lhs, rhs, opts, ")")
	if rhs then
		return vim.keymap.set(mode, lhs, rhs, opts)
	else
		return vim.keymap.del(mode, lhs, opts)
	end
end

local map_defaults = { silent = true }

local function maps(modestr, lhs, opts, rhs, desc)
	if type(opts) ~= "table" then
		opts, rhs, desc = {}, opts, rhs
	end

	local modes = splitmodestr(modestr)
	local newopts = vim.tbl_extend("keep", opts, { desc = desc }, map_defaults)
	for i = 1, #opts do
		newopts[opts[i]] = true
		newopts[i] = nil
	end

	if type(lhs) == "table" then
		for i = 1, #lhs do
			map1(modes, lhs[i], rhs, newopts)
		end
	else
		return map1(modes, lhs, rhs, newopts)
	end
end


--- [[ Functional ]] ---

local function ignore() end

local function preapply(func, args)
	return function() return func(unpack(args)) end
end

--- [[ Meta Code ]] ---

local function if_let(ok, ...)
	if ok then
		local args = { ... }
		return function(then_fn)
			return then_fn(unpack(args))
		end
	else
		return ignore
	end
end

local function if_call(...)
	return if_let(pcall(...))
end

--- [[ Hooks ]] ---

local Hook = {}

function Hook.new(funcs)
	return setmetatable(funcs or {}, {
		__index = Hook,
		__call = Hook.run,
	})
end

function Hook.run(self, ...)
	for i = 1, #self do
		self[i](...)
	end
end


local HookTable = {}

function HookTable.new(hooks)
	return setmetatable({ hooks = hooks or {} }, { __index = HookTable })
end

function HookTable.add(self, keys, ...)
	if type(keys) ~= "table" then keys = { keys } end
	local values = { ... }

	for i = 1, #keys do
		local key = keys[i]
		local hook = self.hooks[key]

		if hook then
			vim.list_extend(hook, values)
		else
			self.hooks[key] = Hook.new({ ... })
		end
	end
end

function HookTable.run(self, key, ...)
	local hook = self.hooks[key]
	if hook then
		return hook:run(self, ...)
	end
end


return {
	augroup = augroup,
	file_exists = file_exists,
	ensure_package = ensure_package,
	is_startup = is_startup,
	safe_call = safe_call,
	safe_require = safe_require,
	bool = bool,
	predicate = predicate,
	packadd = packadd,
	maps = maps,
	nmap = function(...) return map1("n", ...) end,
	imap = function(...) return map1("i", ...) end,
	cmap = function(...) return map1("c", ...) end,
	vmap = function(...) return map1("v", ...) end,
	xmap = function(...) return map1("x", ...) end,
	smap = function(...) return map1("s", ...) end,
	omap = function(...) return map1("o", ...) end,
	tmap = function(...) return map1("t", ...) end,
	lmap = function(...) return map1("l", ...) end,
	nvmap = function(...) return map1({ "n", "v" }, ...) end,
	icmap = function(...) return map1({ "i", "c" }, ...) end,
	nvomap = function(...) return map1({ "n", "v", "o" }, ...) end,
	preapply = preapply,
	Hook = Hook,
	HookTable = HookTable,
}
