-- Utilities

local utils = {}

function utils.predicate(vimfunc)
	return function(...) return vimfunc(...) ~= 0 end
end

function utils.chars(str)
	local chars = {}
	local sub = string.sub
	for i = 1, #str do
		chars[i] = sub(str, i)
	end
	return chars
end

function utils.clear_cache(namespace)
	local prefix = namespace .. "."
	for name in pairs(package.loaded) do
		if name == namespace or vim.startswith(name, prefix) then
			package.loaded[name] = nil
		end
	end
end

function utils.selfmetatable(table)
	return setmetatable(table, table)
end

return utils
