local lspconfig = require("lspconfig")
local use_cmp = CONFIG_OPTS.use_cmp
local use_telescope = CONFIG_OPTS.use_telescope


local settings = {
	Lua = { -- TODO: Automatic/Project-local configuration
		runtime = { version = "LuaJIT" },
		diagnostics = { globals = { "vim" } }, -- Can enable code style checking, see: https://github.com/sumneko/lua-language-server/wiki/Formatter
		telemetry = { enable = false },
		format = {
			enable = true,
			defaultConfig = { -- TODO: Deduplicate
				-- See: https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/docs/format_config_EN.md
				-- See: https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/include/CodeService/LuaCodeStyleOptions.h
				-- These options should be set by LSP `:h vim.lsp.buf.formatting`.
				-- indent_style = "tab", -- Values: space/tab
				-- indent_size = "2", -- Only for `indent_style == "space"`.
				-- tab_width = "2", -- Only for `indent_style == "tab"`.
				quote_style = "double", -- Values: none/single/double.
				-- continuation_indent_size = "2", -- Is this set by LSP?
				align_function_define_params = "false",
				table_append_expression_no_space = "true",
				remove_empty_header_and_footer_lines_in_function = "true",
				keep_line_after_function_define_statement = "maxLine:2",
			},
		},
	},
}


local capabilities = vim.lsp.protocol.make_client_capabilities()

if use_cmp then
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
end


local map_keys = (function()
	local utils = require("config.utils")
	local maps = utils.maps

	local function list_workspace_folders(...)
		return print(vim.inspect(vim.lsp.buf.list_workspace_folders(...)))
	end

	local function lsp_buf(name, func)
		return func or vim.lsp.buf[name], "vim.lsp.buf." .. name .. "()"
	end

	if use_telescope then
		local builtin = require("config.plugin.telescope").builtin

		return function(bufnr)
			local buffer = { buffer = bufnr }
			maps("n", "gd",        buffer, builtin("lsp_definitions"))
			maps("n", "gD",        buffer, lsp_buf("declaration"))
			maps("n", "gi",        buffer, builtin("lsp_implementations"))
			maps("n", "gr",        buffer, builtin("lsp_references"))
			maps("n", "K",         buffer, lsp_buf("hover"))
			maps("n", "<C-k>",     buffer, lsp_buf("signature_help"))
			maps("n", "<Space>D",  buffer, builtin("lsp_type_definitions"))
			maps("n", "<space>ca", buffer, lsp_buf("code_action"))
			maps("n", "<space>cf", buffer, lsp_buf("formatting"))
			maps("n", "<space>cr", buffer, lsp_buf("rename"))
			maps("n", "<Space>ci", buffer, builtin("lsp_incoming_calls"))
			maps("n", "<Space>co", buffer, builtin("lsp_outgoing_calls"))
			maps("n", "<Space>cs", buffer, builtin("lsp_document_symbols"))
			maps("n", "<space>wa", buffer, lsp_buf("add_workspace_folder"))
			maps("n", "<space>wr", buffer, lsp_buf("remove_workspace_folder"))
			maps("n", "<space>wl", buffer, lsp_buf("list_workspace_folders", list_workspace_folders))
			maps("n", "<Space>ws", buffer, builtin("lsp_workspace_symbols"))
			maps("n", "<Space>wS", buffer, builtin("lsp_dynamic_workspace_symbols"))
		end
	else
		return function(bufnr)
			local buffer = { buffer = bufnr }
			maps("n", "gd",        buffer, lsp_buf("definition"))
			maps("n", "gD",        buffer, lsp_buf("declaration"))
			maps("n", "gi",        buffer, lsp_buf("implementation"))
			maps("n", "gr",        buffer, lsp_buf("references"))
			maps("n", "K",         buffer, lsp_buf("hover"))
			maps("n", "<C-k>",     buffer, lsp_buf("signature_help"))
			maps("n", "<space>D",  buffer, lsp_buf("type_definition"))
			maps("n", "<space>ca", buffer, lsp_buf("code_action"))
			maps("n", "<space>cf", buffer, lsp_buf("formatting"))
			maps("n", "<space>cr", buffer, lsp_buf("rename"))
			maps("n", "<space>wa", buffer, lsp_buf("add_workspace_folder"))
			maps("n", "<space>wr", buffer, lsp_buf("remove_workspace_folder"))
			maps("n", "<space>wl", buffer, lsp_buf("list_workspace_folders", list_workspace_folders))
		end
	end
end)()

local function on_attach(client, bufnr)
	if not use_cmp then
		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
	end
	return map_keys(bufnr)
end


local default_opts = {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = settings,
}

local function setup(server, server_opts)
	return lspconfig[server].setup(vim.tbl_extend("keep", server_opts or {}, default_opts))
end

setup "clangd"
setup "pyright"
setup "rust_analyzer"
setup "sumneko_lua"
