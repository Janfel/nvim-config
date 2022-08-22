;; Fixes https://github.com/andymass/vim-matchup/issues/238
(do_statement
  "do" @open.block
  "end" @close.block) @scope.block
