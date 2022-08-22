-- Neovim Options

local set = vim.opt
local function feature(...) return vim.fn.has(...) ~= 0 end

-- REMEMBER: See `:help 'formatoptions'`!
-- Maybe try out `:h 'title'` in Neovide.


-- See `:h ins-expandtab` and `:h 'vartabstop'`/`:h 'varsofttabstop'`.
set.tabstop = 4 -- Width of the tab character.
set.shiftwidth = 0 -- Width of one indent level.
set.softtabstop = 0 -- How many tabs/spaces to insert when pressing `<Tab>`.
set.smarttab = true -- Use `shiftwidth` at beginning, `tabstop`/`softtabstop` within line.
set.expandtab = false -- Whether to insert spaces when pressing `<Tab>`.

set.confirm = true -- Ask for confirmation by default.

set.number = true
set.relativenumber = false

set.splitbelow = true -- Make `:sp` split below.
set.splitright = true -- Make `:vs` split right.

-- Values from https://github.com/tpope/vim-sensible.
set.scrolloff = 1 -- Always keep N lines above/below the cursor.
set.sidescrolloff = 5 -- Always keep N columns left/right of the cursor.

-- Also check out 'linebreak' and 'breakat' for plain text files.
set.breakindent = true -- Visually indent wrapped lines.
set.showbreak = " => " -- " └→ " -- "┄└⟶" -- Prefix for wrapped lines.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
set.breakindentopt = { "sbr" } -- Indent between the prefix and the line.
set.cpoptions:append "n" -- Use the space in the number column.

set.list = true -- Show hidden characters.
set.listchars = {
	nbsp = "␣",
	tab = "» ",
	trail = "-",
}

set.fillchars = { eob = " " }

-- Enable 24-bit RGB color if the terminal supports it.
-- This messes up the default colorscheme.
set.termguicolors = feature("termguicolors")


set.isfname:append { "@-@", "?" } -- Detect URLs containing `@` and `?`.

set.smartcase = true -- Enable smartcase by default.
set.ignorecase = true -- Ignore case in search patterns. See `:h /\C`.
set.gdefault = true -- Make patterns use the `g` flag by default.
set.completeopt = { "menu", "menuone", "noselect", "preview" } -- See `:h completeopt`

set.wildmenu = true -- Enable the completion menu.
set.wildignorecase = true -- Ignore case in command-line completion.
set.wildmode = { "longest", "longest:full", "full" } -- Like Zsh tab-completion.

set.guifont = {
	"Fira_Code:h10",
	"Hack:h10",
	"Noto_Mono:h10",
	"Symbols_Nerd_Font:h10",
}


-- This is my own compromise between `:behave mswin` and `:behave xterm`,
-- which happens to line up exactly with the one suggested in
-- https://groups.google.com/g/vim_use/c/MTmvH5OCJek/m/sns56w-3tugJ.

set.mouse = "a" -- Enable mouse support in all modes.

-- Make mouse clicks behave sanely, with shift left click extending the
-- selection and right click opening a popup menu regarding the thing that
-- was clicked on. See the documentation of this option for information on how
-- to remap mouse clicks based on modifiers.
set.mousemodel = "popup_setpos"

-- Use the normal inclusive selection by default, until I find a way to use
-- `selection=exclusive` in Select mode but not in Visual mode.
set.selection = "inclusive"

-- Allow the cursor to move freely over the screen in Visual Block mode,
-- to allow for true rectangular selection.
set.virtualedit = { "block" }


-- Enter Select mode when selecting using the mouse or Shift + movement keys.
-- This would be much more useful if `keymodel=stopsel` would only apply to
-- Select mode but not to Visual mode. Then we could add `mouse` to this list.
set.selectmode = { "key" }

-- Start a selection when using Shift + movement keys. This does not contain
-- `stopsel` to automatically remove the selection like usual, because `stopsel`
-- applies not only to Select mode, but to Visual mode as well.
-- This is a longstanding issue with Vim.
set.keymodel = { "startsel" }
