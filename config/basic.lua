-- Basic Configuration

local utils = require("utils")
local bind = require("utils.bind")
local set = vim.opt


-- REMEMBER: See `:help 'formatoptions'`!


-- See `:h ins-expandtab`.
set.tabstop = 4 -- Width of the tab character.
set.shiftwidth = 0 -- Width of one indent level.
set.softtabstop = 0 -- How many tabs/spaces to insert when pressing `<Tab>`.
set.smarttab = true -- Use `shiftwidth` at beginning, `tabstop`/`softtabstop` within line.
set.expandtab = false -- Whether to insert spaces when pressing `<Tab>`.

set.number = true
set.relativenumber = false

set.confirm = true -- Ask for confirmation by default.

--set.list = true -- Show hidden characters.

-- Enable 24-bit RGB color if the terminal supports it.
-- This messes up the default colorscheme.
--set.termguicolors = utils.has_feature("termguicolors")

-- Controls how many lines of context to show when the cursor is scrolling
-- toward the edge of the screen. Values from https://github.com/tpope/vim-sensible.
set.scrolloff = 1
set.sidescrolloff = 5

set.splitbelow = true
set.splitright = true

-- Add ‘@’ and ‘?’ to the valid file name characters,
-- so URLs are detected in full.
set.isfname:append { "@-@", "?" }

-- Make smartcase the default, switch to case-sensitive with `\C`.
set.smartcase = true
set.ignorecase = true

set.completeopt = { "menu", "menuone", "noselect", "preview" }
-- Also see `:h 'completeopt'`.
set.wildmenu = true
set.wildignorecase = true
set.wildmode = { "longest", "longest:full", "full" } -- Like my Zsh config

bind "c" {
	{"<Up>",    "<C-p>", desc = "Move to previous completion"},
	{"<Down>",  "<C-n>", desc = "Move to next completion"},
	{"<Left>",  "<Space><BS><Left>",  desc = "Move left instead of changing completion"},
	{"<Right>", "<Space><BS><Right>", desc = "Move right instead of changing completion"},
	{"<C-n>",   "<C-g>", desc = "Move to next 'incsearch' match"},
	{"<C-p>",   "<C-t>", desc = "Move to previous 'incsearch' match"},
	{"<C-g>",   "<C-e>", desc = "Stop completion – Emacs muscle memory"},
}

set.guifont = {
	"Fira_Code:h10",
	"Hack:h10",
	"Noto_Mono:h10",
	"Symbols_Nerd_Font:h10",
}



---------------------------------------------------------------------
-- Mouse and Selection Behavior                                    --
---------------------------------------------------------------------

-- Enable mouse support for all (“a”) modes.
set.mouse = "a"

-- Allow the cursor to move freely over the screen in Visual Block mode,
-- to allow for true rectangular selection.
set.virtualedit = {"block"}

-- This is my own compromise between ‘:behave mswin’ and ‘:behave xterm’,
-- which happens to line up exactly with the one suggested in
-- https://groups.google.com/g/vim_use/c/MTmvH5OCJek/m/sns56w-3tugJ.

-- Enter Select mode when selecting using the mouse or Shift + movement keys.
-- This would be much more useful if ‘keymodel=stopsel’ would only apply to
-- Select mode but not to Visual mode.
--set.selectmode = {"mouse", "key"}
set.selectmode = {"key"}

-- Make mouse clicks behave sanely, with shift left click extending the
-- selection and right click opening a popup menu regarding the thing that
-- was clicked on. See the documentation of this option for information on how
-- to remap mouse clicks based on modifiers.
set.mousemodel = "popup_setpos"

-- Start a selection when using Shift + movement keys. This does not contain
-- ‘stopsel’ to automatically remove the selection like usual, because ‘stopsel’
-- applies not only to Select mode, but to Visual mode as well.
-- This is a longstanding issue with Vim.
set.keymodel = { "startsel" }

-- Use the normal inclusive selection by default, until I find a way to use
-- ‘selection=exclusive’ in Select mode but not in Visual mode.
set.selection = "inclusive"


---------------------------------------------------------------------
-- Bindings                                                        --
---------------------------------------------------------------------

vim.g.mapleader = " " -- Set `<Leader>` to `<Space>`.
vim.g.maplocalleader = "ß" -- Set `<LocalLeader>` for now.

bind "n" {
	{ "<Leader>", "<Nop>", desc = "Unbind the leader key" },
	{ "<Leader>w", "<C-w>", remap = true, desc = "Ergonomic <C-w>" },
}

-- The bindings below are untested, and a vanilla alternative to `moll/vim-bbye`.
-- https://superuser.com/questions/289285/how-to-close-buffer-without-closing-the-window
-- https://vim.fandom.com/wiki/Deleting_a_buffer_without_closing_the_window
--{"<Leader>bd", ":bn|:bd#<CR>"}
--{"<Leader>bw", ":bn|:bd#<CR>"}


bind "n" {
	{ "<C-w>d",     "<C-w>c", desc = "Delete window" },
	{ "<C-w><C-d>", "<C-w>c", desc = "Delete window" },
}

bind "n" {
	{ "<A-u>", "U", desc = "Undo whole line" },
	{ "U", "<C-r>", desc = "Redo using Shift-U" },
}

bind "n" {
	{ "<C-w><C-Up>",    "<C-w>K" },
	{ "<C-w><C-Down>",  "<C-w>J" },
	{ "<C-w><C-Left>",  "<C-w>H" },
	{ "<C-w><C-Right>", "<C-w>L" },
}


if false then
	bind(" ", ",", ";")
	bind(" ", "–", ",")
	bind("n", "g,", "g;")
	bind("n", "g–", "g,")
end


if false then
	-- Drag a line up or down. The ‘@_’ discards the count by reading from ‘"_’
	-- and ‘v:count1’ is inserted before ‘j’/‘k’ using ‘map-<expr>’.
	-- Replaced by plugin ‘vim-move’.

	--vim.cmd([[ nnoremap <expr> <A-Up> '@_dd'.v:count1.'kP' ]])
	--vim.cmd([[ nnoremap <expr> <A-Down> '@_dd'.(v:count1 == 1 ? 'p' : (v:count1-1).'jp') ]])

	local drag_up   = [['@_dd'..v:count1..'kP']]
	local drag_down = [[(v:count1 == 1 ? '@_ddp' : '@_dd'..(v:count1 - 1)..'jp')]]
	bind("n", "<A-Up>",   drag_up,   {expr = true, desc = "Drag a line up"})
	bind("n", "<A-Down>", drag_down, {expr = true, desc = "Drag a line down"})
end
