-- Package Configuration Utilities

local package = { disabled = {} }

local function pkgpath(pkgname)
	return "pack/paqs/opt/"..pkgname
end

function package.disable(pkgname)
	package.disabled[pkgname] = true
end

function package.find(pkgname)
	local dir = vim.fn.finddir(pkgpath(pkgname), vim.o.packpath)
	if dir == "" then return nil end
	return dir
end

function package:__call(pkgname)
	if package.disabled[pkgname] then
		return false, 'Package disabled: "'..pkgpath(pkgname)..'"'
	end
	if not package.find(pkgname) then
		return false, 'Package not found: "'..pkgpath(pkgname)..'"'
	end
	return pcall(vim.cmd, "packadd! "..pkgname)
end

return setmetatable(package, package)
