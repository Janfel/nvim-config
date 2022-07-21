# Configuration Notes

## Gotchas

- Typing `<C-Space>` in the terminal sends `<C-@>` instead.

## Ideas

- Find out how to use `keymodel=stopsel` and `selection=exclusive` in Select mode, but not in Visual mode.
- Maybe map `C-g u` into `Space`, `Tab`, `Return`, etc. as described in for a more fine-grained undo.
  - https://stackoverflow.com/questions/2895551/how-do-i-get-fine-grained-undo-in-vim
- Bind `g C-u`, `v_C-u`, etc. to capitalization, see `:h case`.
- Steal `align-regexp` from https://vim.fandom.com/wiki/Regex-based_text_alignment.
- Procure an alternative to `hungry-delete`.
- Extend `gx` to support arbitrary buffer-local (Lua) transformers.
  - https://github.com/stsewd/gx-extended.vim
  - https://github.com/KabbAmine/myVimFiles/blob/master/autoload/ka/sys.vim
  - https://github.com/felipec/vim-sanegx
  - https://github.com/tyru/open-browser.vim
  - https://gist.github.com/habamax/0a6c1d2013ea68adcf2a52024468752e (vim-better-gx.adoc)
- Bind `v_C-l` to clear the region (e.g. `:s/.*//`).
- Bind `[[`, `]]`, ... to call `zt` afterwards.

## Plugins

- Modern version of `vim-easyclip`.
  - https://github.com/svermeulen/vim-cutlass
  - https://github.com/svermeulen/vim-yoink
  - https://github.com/svermeulen/vim-subversive
- Non-treesitter language support (see `vim-polyglot`):
  - https://github.com/tbastos/vim-lua
- Tabline integrating with `lualine`: https://github.com/kdheepak/tabline.nvim
- Better `netrw`:                     https://github.com/tpope/vim-vinegar
- Context compressor:                 https://github.com/wellle/context.vim
- Improved `:make`:                   https://github.com/neomake/neomake
- Lua Cache:                          https://github.com/lewis6991/impatient.nvim
- Lisp Eval Integration:              https://github.com/Olical/conjure
- Vim `.dir-locals.el`:               https://github.com/embear/vim-localvimrc
- Additional configuration languages:
  - https://github.com/Olical/aniseed (Fennel)
  - https://github.com/rktjmp/hotpot.nvim (Fennel)
- End inserter:                       https://github.com/tpope/vim-endwise
- Completion:
  - https://github.com/hrsh7th/nvim-cmp
  - https://github.com/hrsh7th/cmp-nvim-lsp
  - https://github.com/hrsh7th/cmp-buffer
  - https://github.com/hrsh7th/cmp-path
  - https://github.com/hrsh7th/cmp-cmdline
- Org:                                https://github.com/nvim-orgmode/orgmode
