-- Path Utilities

local Path = {}

Path.separator = package.config:sub(1, 1)

function Path.join(...)
	return table.concat({...}, Path.separator)
end

return Path
