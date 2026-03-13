# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using **lazy.nvim** as the plugin manager. All configuration is written in Lua.

## Architecture

```
init.lua              # Main entry point — sets leader key, bootstraps lazy.nvim, loads all modules
lua/
  lazy.lua            # Minimal lazy.nvim initialization
  plugins.lua         # All plugin specs (single source of truth for plugins)
  keybindings.lua     # All key mappings, organized by leader prefix
  settings.lua        # Neovim options, colorscheme, netrw settings
  opts.lua            # Obsidian.nvim workspace/template configuration
  treesitter.lua      # Tree-sitter parser configuration
  dap_csharp.lua      # C# debugger (netcoredbg / Godot .NET)
lazy-lock.json        # Pinned plugin versions — update with :Lazy update
```

**Leader key**: `<Space>`

## Plugin Organization (lua/plugins.lua)

All 35 plugins live in a single file. Key groups:
- **LSP**: `nvim-lspconfig` + `mason.nvim` + `mason-lspconfig` — language servers managed via Mason UI (`:Mason`)
- **Completion**: `nvim-cmp` with LSP, buffer, and path sources; snippets via `LuaSnip`
- **Telescope**: Primary picker for files, grep, LSP references, DAP — using ivy theme
- **Formatting**: `conform.nvim` — formats on save (stylua, black+isort, prettier, clang-format, csharpier, rustfmt)
- **Debugging**: `nvim-dap` + `nvim-dap-ui` + `telescope-dap.nvim`
- **C#**: `roslyn.nvim` provides the primary C# LSP (not omnisharp)
- **Notes**: `obsidian.nvim` with vault at `~/Documents/Notes`

## Keybinding Conventions (lua/keybindings.lua)

Prefixes are organized by function:
- `<leader>f*` — file finding (ff=files, fb=buffers, fe=explorer, fa=all files, fr=recent, fn=notes, fc=config)
- `<leader>g*` — grep/search (gg=grep, ga=all grep, gr=resume, gn=notes grep, gc=git commits)
- `<leader>l*` — LSP (ld=def, lt=type def, li=impl, ls=symbols, lw=workspace symbols, lr=rename, la=action, lh=hover, lf=format, lp=sig help)
- `<leader>o*` — Obsidian (od=dailies, on=new, oq=quick switch, ot=template, ol=links, ob=backlinks, oe=extract)
- `<leader>d*` — DAP debugging
- `<S-h>` / `<S-l>` — previous/next buffer
- `<C-h/j/k/l>` — window navigation (tmux-aware via vim-tmux-navigator)

## Language Server Setup

Configured servers (auto-installed by Mason):
- `pyright` — Python
- `clangd` — C/C++
- `bashls` — Bash
- `roslyn.nvim` — C# (separate plugin, not mason-lspconfig)

To add a new LSP server: add it to the `ensure_installed` list in the `mason-lspconfig` spec in `plugins.lua`, then add handler configuration in the same spec's `handlers` table.

## Adding Plugins

Add a spec to `lua/plugins.lua` following the lazy.nvim spec format:
```lua
{
  "author/plugin-name",
  event = "VeryLazy",           -- for lazy loading
  dependencies = { "dep/name" },
  config = function() require("plugin").setup({}) end,
  -- or:
  opts = { key = value },
}
```

Run `:Lazy sync` to install after adding.
