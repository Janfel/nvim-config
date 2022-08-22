if not CONFIG_OPTS.use_telescope then return end

local telescope = require("telescope")
local telescope_actions = require("telescope.actions")
local telescope_themes = require("telescope.themes")


telescope.setup {
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key",
				["<C-g>"] = { telescope_actions.close, type = "action", opts = { nowait = true } },
			},
			n = {
				["<C-h>"] = "which_key",
				["<C-g>"] = { telescope_actions.close, type = "action", opts = { nowait = true } },
			},
		},
	},
	pickers = {},
	extensions = {
		["ui-select"] = { telescope_themes.get_dropdown() },
	}
}

do
	local Extension = telescope.load_extension

	Extension "fzf" -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
	Extension "luasnip" -- https://github.com/benfowler/telescope-luasnip.nvim
	Extension "ui-select" -- https://github.com/nvim-telescope/telescope-ui-select.nvim
	Extension "projects" -- https://github.com/ahmedkhalf/project.nvim#telescope-integration
end

---

local utils = require("config.utils")
local maps = utils.maps


local inspect_opts = { indent = "", newline = " " }
local function opts2str(opts)
	if opts then
		return "(" .. vim.inspect(opts, inspect_opts) .. ")"
	else
		return "()"
	end
end

local function builtin(name, opts)
	local function func()
		return require("telescope.builtin")[name](opts)
	end

	local desc = "telescope.builtin." .. name .. opts2str(opts)
	return func, desc
end

local function extension(extname, funcname, opts)
	if not telescope.extensions[extname] then return end

	if not funcname then funcname = extname end

	local function func()
		return require("telescope").extensions[extname][funcname](opts)
	end

	local desc = "telescope.extensions." .. extname .. "." .. funcname .. opts2str(opts)
	return func, desc
end

maps("nv", "<Space><Space>", builtin("git_files"))
maps("nv", "<Space>:", builtin("commands"))
maps("nv", "<Space>ß", extension("luasnip"))

maps("nv", "<Space>bb", builtin("buffers"))
maps("nv", "<Space>ff", builtin("find_files"))
maps("nv", "<Space>fr", builtin("oldfiles"))
maps("nv", "<Space>fg", builtin("live_grep"))
maps("nv", "<Space>rg", builtin("live_grep"))
maps("nv", "<Space>ll", builtin("loclist"))
maps("nv", "<Space>lq", builtin("quickfix"))

maps("nv", "<Space>ss", builtin("current_buffer_fuzzy_find"))
maps("nv", "<Space>st", builtin("treesitter"))
maps("nv", "<Space>sg", builtin("live_grep"))
maps("nv", "<Space>sG", builtin("grep_string"))

maps("nv", "<Space>ha", builtin("autocommands"))
maps("nv", "<Space>hc", builtin("colorscheme"))
maps("nv", "<Space>hf", builtin("filetypes"))
maps("nv", "<Space>hh", builtin("help_tags"))
maps("nv", "<Space>hk", builtin("keymaps"))
maps("nv", "<Space>hl", builtin("highlights"))
maps("nv", "<Space>hm", builtin("man_pages"))
maps("nv", "<Space>ho", builtin("vim_options"))

maps("nv", "<Space>fp", extension("projects"))
maps("nv", "<Space>pp", extension("projects"))

return { builtin = builtin, extension = extension }
