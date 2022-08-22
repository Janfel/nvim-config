
-- TODO: Telescope integration.
-- TODO: Nvim-Tree integration.

-- TODO: Align-Regexp
-- MSBuild Patterns, see: https://stackoverflow.com/questions/2007689/is-there-a-standard-file-extension-for-msbuild-files/2012217

-- https://github.com/ahmedkhalf/project.nvim
require("project_nvim").setup {
	patterns = {
		".project", -- Generic
		".git", ".svn", ".hg", ".bzr", -- VCS
		"Makefile", "makefile", "GNUmakefile", -- Make
		"configure.ac", "configure.in", -- Automake
		"compile_commands.json", "CMakeLists.txt", "meson.build", -- C/C++
		"*.csproj", -- C#
		"deps.edn", "project.clj", "build.boot", -- Clojure
		"*.asd", -- Common Lisp
		"*.fsproj", -- F#
		"go.mod", -- Go
		"project.godot", -- Godot/GDScript
		"*.cabal", "stack.yaml", -- Haskell
		"build.xml", "pom.xml", "build.gradle", -- Java
		"package.json", -- JavaScript
		"pyproject.toml", "setup.py", -- Python
		"Cargo.toml", -- Rust
		"*.vbproj", -- Visual Basic
		"*.vcxproj", -- Visual C++
		".vscode", -- VSCode
	}
}
