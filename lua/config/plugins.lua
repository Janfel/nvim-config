local utils = require("config.utils")
local bool = utils.bool
local maps = utils.maps
local nmap = utils.nmap
local vmap = utils.vmap
local imap = utils.imap

local silent = { silent = true }
local function nmaps(lhs, rhs) return nmap(lhs, rhs, silent) end

local function vmaps(lhs, rhs) return vmap(lhs, rhs, silent) end

local function imaps(lhs, rhs) return imap(lhs, rhs, silent) end

local function packadd(plugin)
	-- TODO: See builtins.lua
	vim.cmd("packadd! " .. plugin)
end

local preload_table = package.preload
local function preload(plugname, value)
	local modname = "config.plugin." .. plugname
	preload_table[modname] = value
end

preload("paq", function()
	local package_list = require("config.package-list")
	require("paq"):setup({ path = CONFIG_OPTS.package_dir })(package_list)
end)

preload("vim-bbye", function()
	packadd "vim-bbye"
	nmaps("<Space>bd", "<CMD>Bdelete<CR>")
	nmaps("<Space>bD", "<CMD>Bdelete!<CR>")
	nmaps("<Space>bw", "<CMD>Bwipeout<CR>")
	nmaps("<Space>bW", "<CMD>Bwipeout!<CR>")
end)

preload("vim-closetag", function() packadd "vim-closetag" end)

preload("vim-matchup", function()
	packadd "vim-matchup"
	vim.g.matchup_surround_enabled = 1
	vim.g.matchup_delim_noskips = 0 -- Useless with Tree-Sitter.
	vim.g.matchup_matchparen_offscreen = {} -- Useless with Lualine.
	vim.g.matchup_matchparen_deferred = 1
	vim.cmd [[ :highlight MatchWord ctermfg=NONE guifg=NONE cterm=underline gui=underline ]]
end)

preload("vim-move", function()
	packadd "vim-move"
	vim.g.move_map_keys = 0 -- Free `<A-hjkl>` for something else.

	nmaps("<A-Up>", "<Plug>MoveLineUp")
	nmaps("<A-Down>", "<Plug>MoveLineDown")
	nmaps("<A-Left>", "<Plug>MoveCharLeft")
	nmaps("<A-Right>", "<Plug>MoveCharRight")

	vmaps("<A-Up>", "<Plug>MoveBlockUp")
	vmaps("<A-Down>", "<Plug>MoveBlockDown")
	vmaps("<A-Left>", "<Plug>MoveBlockLeft")
	vmaps("<A-Right>", "<Plug>MoveBlockRight")

	imaps("<A-Up>", "<C-\\><C-o><Plug>MoveLineUp")
	imaps("<A-Down>", "<C-\\><C-o><Plug>MoveLineDown")
	imaps("<A-Left>", "<C-\\><C-o><Plug>MoveCharLeft")
	imaps("<A-Right>", "<C-\\><C-o><Plug>MoveCharRight")
end)

preload("vim-endwise", function() packadd "vim-endwise" end)
preload("vim-repeat", function() packadd "vim-repeat" end)
preload("vim-sleuth", function() packadd "vim-sleuth" end)
preload("vim-surround", function() packadd "vim-surround" end)
preload("vim-speeddating", function()
	packadd "vim-speeddating"
	vim.g.speeddating_no_mappings = true

	maps("nx", "<C-a>", "<Plug>SpeedDatingUp")
	maps("nx", "<C-x>", "<Plug>SpeedDatingDown")
	maps("n", "d<C-a>", "<Plug>SpeedDatingNowUTC")
	maps("n", "d<C-x>", "<Plug>SpeedDatingNowLocal")
end)
preload("vim-switch", function()
	packadd "vim-switch"
	vim.g.switch_mapping = ""

	local function switch_next()
		if not bool(vim.call("switch#Switch")) then
			return vim.call("speeddating#increment", vim.v.count1)
		end
	end

	local function switch_prev()
		if not bool(vim.call("switch#Switch", { reverse = true })) then
			return vim.call("speeddating#increment", -vim.v.count1)
		end
	end

	maps("n", "<C-a>", switch_next, "Switch words or increment")
	maps("n", "<C-x>", switch_prev, "Switch words or decrement")
end)

preload("Comment", function() require("Comment").setup() end)

preload("lualine", function()
	-- maybe_load: nvim-web-devicons
	require("lualine").setup { options = { section_separators = "" } }
end)

preload("luasnip", function()
	local luasnip = require("luasnip")
	local loaders = require("luasnip.loaders")
	require("luasnip.loaders.from_vscode").lazy_load() -- Load FriendlySnippets.
	require("luasnip.loaders.from_snipmate").lazy_load() -- Load custom snippets.

	vim.api.nvim_create_user_command("LuaSnipEdit", loaders.edit_snippet_files, {
		desc = "Edit a LuaSnip snippet file",
	})

	if not CONFIG_OPTS.use_cmp then
		local expand_or_jump = [[luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>']]
		local function jump_next() return luasnip.jump(1) end
		local function jump_prev() return luasnip.jump(-1) end
		local next_choice = [[luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>']]
		local prev_choice = [[luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-e>']]

		maps("i", "<Tab>", { "expr", "remap" }, expand_or_jump, "Expand or jump")
		maps("s", "<Tab>", jump_next, "Jump forward")
		maps("is", "<S-Tab>", jump_prev, "Jump back")
		maps("is", { "<C-n>", "<C-e>" }, { "expr", "remap" }, next_choice, "Next choice")
		maps("is", { "<C-p>", "<C-y>" }, { "expr", "remap" }, prev_choice, "Previous choice")
	end
end)

preload("numb", function() require("numb").setup() end)

preload("nvim-treesitter", function()
	require("nvim-treesitter.configs").setup {
		ensure_installed = { "lua" },
		highlight = { enable = true },
		indent = { enable = true }, -- Experimental
		-- https://github.com/andymass/vim-matchup
		matchup = { enable = true,  }, -- Experimental
	}
end)

preload("which-key", function()
	local wk = require("which-key")
	wk.setup {
		key_labels = {
			["<Space>"] = "SPC",
			["<CR>"] = "RET",
		},
	}
	wk.register { -- The builtin descriptions are sorely lacking.
		zF = "Create a fold for [count] lines",
		zd = "Delete fold under cursor",
		zD = "Delete all folds under cursor",
		zE = "Eliminate all folds in the window",
		zX = "Update folds and re-apply 'foldlevel'",
		zn = "Fold none",
		zN = "Fold normal",
		zi = "Toggle folding",
	}
end)

preload("doom-one", function()
	vim.g.doom_one_italic_comments = true

	vim.g.doom_one_plugin_neorg = false
	vim.g.doom_one_plugin_barbar = false
	vim.g.doom_one_plugin_telescope = true
	vim.g.doom_one_plugin_neogit = false
	vim.g.doom_one_plugin_nvim_tree = false
	vim.g.doom_one_plugin_dashboard = false
	vim.g.doom_one_plugin_startify = false
	vim.g.doom_one_plugin_whichkey = false
	vim.g.doom_one_plugin_indent_blankline = false
	vim.g.doom_one_plugin_vim_illuminate = false
	vim.g.doom_one_plugin_lspsaga = false
end)

-- See https://github.com/rmehri01/onenord.nvim#configuration
preload("onenord", function() require("onenord").setup() end)
