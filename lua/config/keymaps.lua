-- Key Mappings

-- Change the controls of the wildmenu.
-- { mode = "c",
--   { "<Up>", "<C-p>", desc = "Move to previous completion" },
--   { "<Down>", "<C-n>", desc = "Move to next completion" },
--   { "<Left>", "<Space><BS><Left>", desc = "Move left instead of changing completion" },
--   { "<Right>", "<Space><BS><Right>", desc = "Move right instead of changing completion" },
--   { "<C-n>", "<C-g>", desc = "Move to next 'incsearch' match" },
--   { "<C-p>", "<C-t>", desc = "Move to previous 'incsearch' match" },
--   { "<C-g>", "<C-e>", desc = "Stop completion – Emacs muscle memory" },
-- },

local utils = require("config.utils")
local maps = utils.maps

local function vim_diag(name)
	return vim.diagnostic[name], "vim.diagnostic." .. name .. "()"
end

vim.g.mapleader = "\\"
vim.g.maplocalleader = "…"

maps("n", "<Leader>", "<Nop>", "Unmap the leader")
maps("n", "<Leader>b", "<Cmd>buffers<CR>:buffer<Space>", "Vanilla buffer jetpack")

maps("nvic", "<C-ß>", { "remap" }, "<C-]>", "Ergonomic <C-]>")

maps("nv", "<Space>w", { "remap" }, "<C-w>", "Ergonomic window mappings")
maps("nv", "<C-w>d",         "<C-w>c", "Delete window")
maps("nv", "<C-w><C-d>",     "<C-w>c", "Delete window")
maps("nv", "<C-w><C-Up>",    "<C-w>K", "Move window up")
maps("nv", "<C-w><C-Down>",  "<C-w>J", "Move window down")
maps("nv", "<C-w><C-Left>",  "<C-w>H", "Move window left")
maps("nv", "<C-w><C-Right>", "<C-w>L", "Move window right")

maps("nv", "<Space>dd", vim_diag("setloclist"))
maps("nv", "<Space>dh", vim_diag("hide"))
maps("nv", "<Space>de", vim_diag("open_float"))
maps("nv", "<Space>dq", vim_diag("setqflist"))
maps("nv", "<Space>dl", vim_diag("setloclist"))

maps("n", "[d", vim_diag("goto_prev"))
maps("n", "]d", vim_diag("goto_next"))

maps("n", "U", "<C-r>", "Redo using Shift-U")
-- maps("n", "<A-u>", "U", "Undo whole line")


maps("c", "<A-n>", "<C-g>")
maps("c", "<A-p>", "<C-t>")
--cmap("<C-g>", "<C-t>", silent)
--cmap("<C-t>", "<C-g>", silent)

-- Use visual navigation by default on the arrow keys.
maps("m", "<Up>", "g<Up>", "Visual line up")
maps("m", "g<Up>", "<Up>", "Logical line up")
maps("m", "<Down>", "g<Down>", "Visual line down")
maps("m", "g<Down>", "<Down>", "Logical line down")

maps("m", ",", ";", "Repeat [ftFT]")
maps("m", "–", ",", "Reverse repeat [ftFT]")
