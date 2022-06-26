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

function utils.selfmetatable(table)
	return setmetatable(table, table)
end

return utils
