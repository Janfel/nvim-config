-- Configuration for nvim-cmp

local package = require("utils.package")

if not package "cmp" then return end

assert(package "cmp-buffer")
assert(package "cmp-cmdline")
assert(package "cmp-path")

if package "lspconfig" then
	-- TODO
	assert(package "cmp-nvim-lsp")
end

if package "luasnip" then
	-- TODO: Extract luasnip-specific configuration bits.
	assert(package "cmp-luasnip")
end

local cmp = require("cmp")
local luasnip = require("luasnip")

local mapping = {
	["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(),   {"i", "c"}),
	["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "c"}),
	["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
	["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
	["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
	["<C-e>"] = cmp.mapping(cmp.mapping.abort(), {"i", "c", "s"}), -- <C-g> ?
	["<C-y>"] = cmp.mapping(cmp.mapping.confirm { select = false }, {"i", "c", "s"}),
	["<CR>"] = cmp.mapping(cmp.mapping.confirm { select = false }, {"i", "c"}),
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			return cmp.select_next_item()
		elseif luasnip.expand_or_jumpable() then
			return luasnip.expand_or_jump()
			-- elseif has_words_before() then
			-- 	cmp.complete()
		else
			return fallback()
		end
	end, {"i", "c", "s"}),
	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			return cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			return luasnip.jump(-1)
		else
			return fallback()
		end
	end, {"i", "c", "s"}),
	["<C-n>"] = cmp.mapping(function(fallback)
		if luasnip.jumpable() then
			return luasnip.jump()
		else 
			return fallback()
		end
	end, {"s"}),
	["<C-p>"] = cmp.mapping(function(fallback)
		if luasnip.jumpable(-1) then
			return luasnip.jump(-1)
		else 
			return fallback()
		end
	end, {"s"}),
}

local insert_mapping = cmp.mapping.preset.insert(mapping)
local cmdline_mapping = cmp.mapping.preset.cmdline(mapping)

cmp.setup {
	snippet = {
		expand = function(args) return require("luasnip").lsp_expand(args.body) end,
	},
	window = {}, -- TODO
	mapping = insert_mapping,
	sources = cmp.config.sources ({ { name = "nvim_lsp" }, { name = "luasnip" } }, { { name = "buffer" } }),
}

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "buffer" } },
})

-- cmp.setup.cmdline(":", {
-- 	mapping = cmdline_mapping,
-- 	sources = cmp.config.sources({
-- 		{ name = "path", option = { trailing_slash = true } },
-- 		}, { { name = "cmdline" } }),
-- })

