-- Augroup Function

local function Augroup(name, opts) -- NOTE: Destructive
	if opts == "delete" then
		return vim.api.nvim_del_augroup_by_name(name)
	end

	local group =  vim.api.nvim_create_augroup(name, opts or {})
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

return Augroup
