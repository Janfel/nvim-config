local utils = require("config.utils")
local package_list = require("config.package-list")
local package_dir = CONFIG_OPTS.package_dir

local paq_spec
for i = 1, #package_list do
	local spec = package_list[i]
	local name = spec.as
	if name == "paq" or name == "paq-nvim" then
		paq_spec = spec
		break
	end
end

assert(paq_spec, "Paq must be in the package list")
assert(paq_spec.url, "Paq package spec must have the 'url' field")

local function bootstrap()
	utils.ensure_package(paq_spec.as, paq_spec.url, package_dir)
	vim.cmd("packadd " .. paq_spec.as) -- Just to be sure.

	local paq = require("paq")
	paq(package_list)
	paq.install()
end

vim.api.nvim_create_user_command("Bootstrap", bootstrap, {
	desc = "Clone paq.nvim and install the required packages"
})

print("Please call :Bootstrap to install dependencies")
