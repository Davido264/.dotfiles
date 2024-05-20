#!/bin/bash

# Install plugins
nvim --headless "+Lazy! sync" +qa

nvim --headless "+Mason" +qa

# Define tools
tools=(
	# Ansible
	"ansible-language-server"
	"ansible-lint"

	# Bash/sh
	"bash-language-server"
	"shellcheck"
	"shfmt"

	# C/C++
	"clangd"
	"cmake-language-server"

	# Clojure/babashka
	"clj-kondo"
	"clojure-lsp"

	# Go
	"gopls"
	"golangci-lint"
	"delve"

	# Java
	"jdtls"

	# Kotlin
	"kotlin-language-server"

	# Lua
	"lua-language-server"
	"selene"
	"stylua"

	# C#
	"omnisharp"
	"netcoredbg"

	# Python
	"pyright"
	"pylint"
	"black"
	"debugpy"

	# LaTeX
	"texlab"

	# Javascript/Typescript
	"typescript-language-server"
	"eslint_d"
	"prettier"
	"node-debug2-adapter"
	"firefox-debug-adapter"

	# HTML/CSS/JSON/YAML/Commit
	"css-lsp"
	"html-lsp"
	"json-lsp"
	"yaml-language-server"
	"commitlint"

	# Rust
	"rust-analyzer"

	## Rarely using ##
	# Dart (Included with dart)
	#
	# F#
	# "fsautocomplete"
	#
	# Tailwindcss
	# "tailwindcss-language-server"
	#
	# Powershell
	# "powershell-editor-services"
	#
	# Prisma.js
	# "prisma-language-server"
	#
	# Minecraft mcfunction (manually install spyglassmc_language_server)
)

nvim --headless +"MasonInstall ${tools[*]}" +qa &
nvim --headless +"TSInstallSync all" +qa &

wait
