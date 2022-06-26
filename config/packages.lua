--- [[ Package Configuration ]] ---

local Augroup = require("utils.Augroup")
local bind = require("utils.bind")
local conf = require("utils.conf")
local package = require("utils.package")
local path = require("utils.path")

local loadconf = conf.load
local disable = package.disable



--- Disabled Packages ---

-- Clear the set of disabled packages.
package.disabled = {}

disable "autopairs"
disable "cmp"
-- disable "luasnip"



--- Package Management ---

if package "impatient" then
	require("impatient")
end


if package "paq" then
	loadconf "package/paq"
	-- Augroup "plugin/paq:reload_package_list" {
	-- 	"BufWritePost", vim.fn.fnameescape(pkglist),
	-- 	desc = "Reload the plugin list",
	-- 	callback = function() conf.loadfile(pkglist) end,
	-- }
end



--- Utilities and Text Objects ---

if package "auto-pairs" then
	vim.g.AutoPairsMultilineClose = 0
end


if package "nvim-autopairs" then
	require("nvim-autopairs").setup()
end


if package "Comment" then
	require("Comment").setup()
end


if package "vim-bbye" then
	bind "n" {
		{ "<Leader>bd", "<CMD>Bdelete<CR>",   desc = "Delete buffer" },
		{ "<Leader>bw", "<CMD>Bwipeout<CR>",  desc = "Wipe out buffer" },
		{ "<Leader>bD", "<CMD>Bdelete!<CR>",  desc = "Delete buffer (including unsaved changes)" },
		{ "<Leader>bW", "<CMD>Bwipeout!<CR>", desc = "Wipe out buffer (including unsaved changes)" },
	}
end


if package "vim-move" then
	vim.g.move_map_keys = 0 -- Free `<A-hjkl>` for something else.

	bind "n" {
		{ "<A-Up>",    "<Plug>MoveLineUp"    },
		{ "<A-Down>",  "<Plug>MoveLineDown"  },
		{ "<A-Left>",  "<Plug>MoveCharLeft"  },
		{ "<A-Right>", "<Plug>MoveCharRight" },
	}

	bind "v" {
		{ "<A-Up>",    "<Plug>MoveBlockUp"    },
		{ "<A-Down>",  "<Plug>MoveBlockDown"  },
		{ "<A-Left>",  "<Plug>MoveBlockLeft"  },
		{ "<A-Right>", "<Plug>MoveBlockRight" },
	}

	bind "i" {
		{ "<A-Up>",    "<C-\\><C-o><Plug>MoveLineUp"    },
		{ "<A-Down>",  "<C-\\><C-o><Plug>MoveLineDown"  },
		{ "<A-Left>",  "<C-\\><C-o><Plug>MoveCharLeft"  },
		{ "<A-Right>", "<C-\\><C-o><Plug>MoveCharRight" },
	}
end



--- TPope Plugins ---

package "vim-endwise"
package "vim-sleuth"

if package "vim-surround" then
	package "vim-repeat"
end

if package "vim-speeddating" then
	package "vim-repeat"
end



--- Tree Sitter ---

if package "nvim-treesitter" then
	-- Try `incremental_selection` and try to find `textobjects`.
	require("nvim-treesitter.configs").setup {
		ensure_installed = { "lua" },
		highlight = { enable = true },
		indent = { enable = true }, -- Experimental feature
	}
end



--- Completion ---

if package "cmp" then
	-- TODO: Make `cmp` wait for `<C-Space>` until it starts completing.
	loadconf "package/cmp"
end


if package "lspconfig" then
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	if package "cmp" and package "cmp_nvim_lsp" then
		capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
	end
	-- TODO: LSP Stuff
end


if package "luasnip" then
	if package "friendly-snippets" then
		require("luasnip.loaders.from_vscode").lazy_load()
	end

	if package "cmp" then goto end_of_luasnip_config end

	-- WARN: Untested code
	-- Bindings from https://github.com/L3MON4D3/LuaSnip#keymaps

	local tab_expand_expr = [[luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>']]
	-- local ctrl_e_next_choice_expr = [[luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>']]

	bind "i" {
		{ "<Tab>", tab_expand_expr, silent = true, expr = true, remap = true },
		{ "<S-Tab>", [[<Cmd>lua require("luasnip").jump(-1)<CR>]], silent = true },
		-- { "<C-e>", ctrl_e_next_choice_expr, silent = true, expr = true, remap = true },
	}

	bind "s" {
		{ "<Tab>",   [[<Cmd>lua require("luasnip").jump(1)<CR>]],  silent = true },
		{ "<C-n>",   [[<Cmd>lua require("luasnip").jump(1)<CR>]],  silent = true },
		{ "<S-Tab>", [[<Cmd>lua require("luasnip").jump(-1)<CR>]], silent = true },
		{ "<C-p>",   [[<Cmd>lua require("luasnip").jump(-1)<CR>]], silent = true },
		-- { "<C-e>", ctrl_e_next_choice_expr, silent = true, expr = true, remap = true },
	}

	::end_of_luasnip_config::
end



--- User Interface ---


if package "lualine" then
	-- Required for icons in the statusline.
	package "nvim-web-devicons"

	-- Find a way to integrate `nvim_treesitter#statusline`.
	require("lualine").setup {
		options = { section_separators = "" },
	}
end


if package "onenord" then
	require("onenord").setup()
end

package "tokyodark"
package "tokyonight"



--- Games ---

package "nvim-tetris"

