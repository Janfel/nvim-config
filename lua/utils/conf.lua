-- Config File Utilities

local path = require("utils.path")

local conf = {}

conf.dir = path.join(vim.fn.stdpath("config"), "config")

function conf.file(confname)
	return path.join(conf.dir, confname..".lua")
end

function conf.load(confname)
	return conf.loadfile(conf.file(confname))
end

function conf.loadfile(filename)
	local ok, val = xpcall(dofile, debug.traceback, filename)
	if not ok then vim.api.nvim_err_writeln(val) end
	return ok, val
end

return conf
