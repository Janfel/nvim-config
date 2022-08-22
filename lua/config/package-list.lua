-- Package List

local extend = vim.tbl_extend

local function command(cmd)
	return function() return vim.cmd(cmd) end
end

local function start(name, url, opts)
	return extend("force", { as = name, url = url, opt = false }, opts or {})
end

local function opt(name, url, opts)
	return extend("force", { as = name, url = url, opt = true }, opts or {})
end

return {
	start("paq", "https://github.com/savq/paq-nvim"),
	start("impatient", "https://github.com/lewis6991/impatient.nvim"),

	opt("vim-bbye", "https://github.com/moll/vim-bbye"),
	opt("vim-closetag", "https://github.com/alvan/vim-closetag"),
	opt("vim-matchup", "https://github.com/andymass/vim-matchup"),
	opt("vim-move", "https://github.com/matze/vim-move"),

	opt("vim-endwise", "https://github.com/tpope/vim-endwise"),
	opt("vim-repeat", "https://github.com/tpope/vim-repeat"),
	opt("vim-sleuth", "https://github.com/tpope/vim-sleuth"),
	opt("vim-surround", "https://github.com/tpope/vim-surround"),
	opt("vim-speeddating", "https://github.com/tpope/vim-speeddating"),
	opt("vim-switch", "https://github.com/AndrewRadev/switch.vim"),

	start("Comment", "https://github.com/numToStr/Comment.nvim"),
	start("numb", "https://github.com/nacro90/numb.nvim"),
	start("nvim-autopairs", "https://github.com/windwp/nvim-autopairs"),
	start("nvim-treesitter", "https://github.com/nvim-treesitter/nvim-treesitter", { run = command "TSUpdate" }),
	start("plenary", "https://github.com/nvim-lua/plenary.nvim"), -- Dep (Telescope)
	start("project_nvim", "https://github.com/ahmedkhalf/project.nvim"),
	start("telescope", "https://github.com/nvim-telescope/telescope.nvim", { branch = "0.1.x" }),
	start("telescope-luasnip", "https://github.com/benfowler/telescope-luasnip.nvim"),
	start("telescope-fzf-native", "https://github.com/nvim-telescope/telescope-fzf-native.nvim", { run = "make" }),
	start("telescope-ui-select", "https://github.com/nvim-telescope/telescope-ui-select.nvim"),
	start("which-key", "https://github.com/folke/which-key.nvim"),

	start("lualine", "https://github.com/nvim-lualine/lualine.nvim"),
	start("nvim-web-devicons", "https://github.com/kyazdani42/nvim-web-devicons"), -- Dep (Lualine, ...)
	start("luasnip", "https://github.com/L3MON4D3/LuaSnip"),
	start("friendly-snippets", "https://github.com/rafamadriz/friendly-snippets"), -- Dep (Luasnip, ...)

	start("cmp", "https://github.com/hrsh7th/nvim-cmp"),
	start("cmp-buffer", "https://github.com/hrsh7th/cmp-buffer"),
	start("cmp-cmdline", "https://github.com/hrsh7th/cmp-cmdline"),
	start("cmp-path", "https://github.com/hrsh7th/cmp-path"),
	start("cmp-luasnip", "https://github.com/saadparwaiz1/cmp_luasnip"),
	start("cmp-nvim-lsp", "https://github.com/hrsh7th/cmp-nvim-lsp"),

	start("lspconfig", "https://github.com/neovim/nvim-lspconfig"),
-- User Interface --

	start("onenord", "https://github.com/rmehri01/onenord.nvim"),
	start("doom-one", "https://github.com/NTBBloodbath/doom-one.nvim"),
	start("material", "https://github.com/marko-cerovac/material.nvim"),
	start("tokyodark", "https://github.com/tiagovla/tokyodark.nvim"),
	start("tokyonight", "https://github.com/folke/tokyonight.nvim"),

-- Games --
	start("nvim-tetris", "https://github.com/alec-gibson/nvim-tetris"),
}
