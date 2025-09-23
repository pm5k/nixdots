# Neovim Configuration

A clean, modular Neovim configuration built for development workflow efficiency.

## Overview

This configuration transforms the original kickstart.nvim monolithic approach into a well-organized, modular system focused on performance and maintainability.

### Architecture

```
nvim/
├── init.lua                    # Entry point (43 lines)
├── lua/
│   ├── config/                 # Core configuration
│   │   ├── options.lua         # Vim settings & leader keys
│   │   ├── keymaps.lua         # Custom keybindings
│   │   └── autocmds.lua        # Autocommands
│   ├── plugins/                # Modular plugin configurations
│   │   ├── lsp.lua             # Language server setup
│   │   ├── completion.lua      # nvim-cmp & snippets
│   │   ├── telescope.lua       # Fuzzy finder
│   │   ├── git.lua             # Git integration
│   │   ├── formatting.lua      # Code formatting
│   │   ├── treesitter.lua      # Syntax highlighting
│   │   ├── ui.lua              # Status line & visual enhancements
│   │   ├── editing.lua         # Text editing improvements
│   │   ├── oil.lua             # File management
│   │   ├── debug.lua           # Debug adapter protocol
│   │   └── ...                 # Additional specialized plugins
│   └── langlist.lua            # Supported languages for syntax
└── README.md                   # This file
```

### Key Features

**Language Support**
- LSP configuration for TypeScript, Python, Go, Lua, C/C++, Svelte, Elixir
- Automatic formatter setup (stylua, ruff, prettier, mix)
- Debug adapter protocol with Go-specific configuration

**Git Integration**
- Neogit for modern Git workflow
- Gitsigns for inline diff indicators and hunk operations
- Diffview for comprehensive diff visualization

**Search & Navigation**
- Telescope for fuzzy finding files, text, and symbols
- Oil.nvim for directory editing as buffers
- Which-key for keymap discovery and organization

**Text Editing**
- nvim-cmp with intelligent completion sources
- Mini.nvim modules for text objects and surround operations
- Smart autopairs with mini.pairs

**Performance Optimizations**
- Lazy loading for debug stack (only loads when debugging)
- Filetype-specific loading (markdown rendering only for .md/.livemd files)
- Minimal plugin footprint with strategic consolidation

## Performance

**Startup Time**: Optimized from 175ms to ~90ms (-48.5%)

**Plugin Strategy**:
- Essential plugins load immediately
- Heavy functionality (debugging, markdown) lazy loads on demand
- Redundant plugins removed (eliminated statusline conflicts, git tool overlap)

## Requirements

- Neovim 0.9+ (targets latest stable and nightly)
- Git, make, unzip, C compiler
- ripgrep (for telescope grep functionality)
- Node.js (for TypeScript LSP)
- Language-specific tools as needed (go, python, etc.)

## Installation

```bash
# Backup existing configuration
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this configuration
git clone <your-repo-url> ~/.config/nvim

# Start Neovim (lazy.nvim will install plugins automatically)
nvim
```

## Key Bindings

**Leader Key**: Space

**Core Workflow**
- `<leader><Tab>` - File explorer (Oil)
- `<leader>sf` - Find files
- `<leader>sg` - Live grep search
- `<leader>gg` - Git status (Neogit)

**LSP Features** (when in supported files)
- `gd` - Go to definition
- `gr` - Go to references
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol

**Debug** (lazy loads on first use)
- `F5` - Start/Continue debugging
- `<leader>b` - Toggle breakpoint
- `F7` - Toggle debug UI

See `lua/config/keymaps.lua` for complete keymap reference.

## Customization

The modular structure makes customization straightforward:

- **Add languages**: Extend `lua/plugins/lsp.lua` and `lua/plugins/formatting.lua`
- **Modify UI**: Edit `lua/plugins/ui.lua` for themes and visual elements
- **Custom keymaps**: Add to `lua/config/keymaps.lua`
- **Plugin management**: Create new files in `lua/plugins/` for additional functionality

## Philosophy

This configuration prioritizes:
- **Performance**: Fast startup, lazy loading, minimal overhead
- **Modularity**: One concern per file, easy to understand and modify
- **Developer Experience**: Intelligent defaults with room for customization
- **Maintainability**: Clear organization, documented decisions, version control friendly

*Last updated: January 2025*