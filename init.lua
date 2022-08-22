-- Neovim Configuration

CONFIG_OPTS = {
	package_dir = vim.fn.stdpath("data") .. "/site/pack/paqs/",
	use_cmp = false,
	use_telescope = true,
}

local bootstrap = not pcall(require, "impatient")
local utils = require("config.utils")

local function module(modname)
	return utils.safe_require("config." .. modname)
end

module "options"
module "keymaps"
module "builtins"
module "hooks.filetype"

if bootstrap then
	module "bootstrap"
	return
end

module "plugins"
module "plugin.paq"

module "plugin.vim-bbye"
module "plugin.vim-closetag"
module "plugin.vim-matchup"
module "plugin.vim-move"

module "plugin.vim-endwise"
module "plugin.vim-repeat"
module "plugin.vim-sleuth"
module "plugin.vim-surround"
module "plugin.vim-speeddating"
module "plugin.vim-switch"

module "plugin.Comment"
module "plugin.lspconfig"
module "plugin.lualine"
module "plugin.luasnip"
module "plugin.numb"
module "plugin.nvim-autopairs"
module "plugin.nvim-treesitter"
module "plugin.project_nvim"
module "plugin.telescope"
module "plugin.which-key"

module "plugin.doom-one"

vim.cmd [[ colorscheme doom-one ]] -- TODO: Color configuration
