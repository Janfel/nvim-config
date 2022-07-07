-- Plugins

local paq = require("paq")

local function register(name, url, opts)
	local spec = { as = name, url = url, opt = true }
	if opts then spec = vim.tbl_extend("force", spec, opts) end
	return paq.register(spec)
end

local function command(cmd)
	return function() return vim.cmd(cmd) end
end

paq {} -- Reset package list

register("paq", "https://github.com/savq/paq-nvim")
register("packer", "https://github.com/wbthomason/packer.nvim")
register("impatient", "https://github.com/lewis6991/impatient.nvim")

register("auto-pairs", "https://github.com/jiangmiao/auto-pairs")
register("vim-bbye", "https://github.com/moll/vim-bbye")
register("vim-move", "https://github.com/matze/vim-move")

register("Comment", "https://github.com/numToStr/Comment.nvim")
register("nvim-autopairs", "https://github.com/windwp/nvim-autopairs")

register("vim-endwise", "https://github.com/tpope/vim-endwise")
register("vim-repeat", "https://github.com/tpope/vim-repeat")
register("vim-sleuth", "https://github.com/tpope/vim-sleuth")
register("vim-surround", "https://github.com/tpope/vim-surround")
register("vim-speeddating", "https://github.com/tpope/vim-speeddating")

register("nvim-treesitter", "https://github.com/nvim-treesitter/nvim-treesitter", { run = command "TSUpdate" })

-- Completion --
register("lspconfig", "https://github.com/neovim/nvim-lspconfig")
register("cmp-nvim-lsp", "https://github.com/hrsh7th/cmp-nvim-lsp")

register("friendly-snippets", "https://github.com/rafamadriz/friendly-snippets")
register("luasnip", "https://github.com/L3MON4D3/LuaSnip")
register("cmp-luasnip", "https://github.com/saadparwaiz1/cmp_luasnip")

register("cmp", "https://github.com/hrsh7th/nvim-cmp")
register("cmp-buffer", "https://github.com/hrsh7th/cmp-buffer")
register("cmp-cmdline", "https://github.com/hrsh7th/cmp-cmdline")
register("cmp-path", "https://github.com/hrsh7th/cmp-path")

-- User Interface --
register("nvim-web-devicons", "https://github.com/kyazdani42/nvim-web-devicons")
register("lualine", "https://github.com/nvim-lualine/lualine.nvim") -- Requires "nvim-web-devicons"

register("onenord", "https://github.com/rmehri01/onenord.nvim")
register("tokyodark", "https://github.com/tiagovla/tokyodark.nvim")
register("tokyonight", "https://github.com/folke/tokyonight.nvim")

-- Games --
register("nvim-tetris", "https://github.com/alec-gibson/nvim-tetris")
