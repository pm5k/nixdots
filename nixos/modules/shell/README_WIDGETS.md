# Zsh Widgets Documentation

## 1. `fzf-history-widget`
Enhanced command history browser with formatting and search.
- **Keybind:** `Ctrl+R`
- **Features:** Formatted history, syntax highlighting, copy to clipboard

## 2. `fzf-tools-widget` 
Interactive explorer for your Nix-managed tools and packages.
- **Keybind:** `Ctrl+T`
- **Alias:** `tools`
- **Features:** Dynamic tool detection, descriptions, manual pages

## Adding New Tools to the Tools Widget

The tools widget automatically detects installed packages but requires manual description entries.

### Step 1: Add Package to Nix Config
Add the tool to your `home.packages` in `home.nix`:
```nix
home.packages = with pkgs; [
  # ... existing packages
  newtool  # Add your new tool here
];
```

### Step 2: Add Description Entry
Edit `widgets.zsh` and add an entry to the `tool_descriptions` associative array:
```bash
local -A tool_descriptions=(
  # ... existing entries
  ["newtool"]="description of what it does:tag1,tag2,tag3"
)
```

### Step 3: Rebuild and Test
```bash
nixrebuild
# Then test: press Ctrl+T or type 'tools'
```

## Description Format
Each tool entry follows this pattern:
```
["command_name"]="short description:comma,separated,tags"
```

**Example:**
```bash
["jq"]="JSON processor and query tool:json,parse,query,filter,data"
```

- **Command name:** The actual executable name
- **Description:** Short, helpful description (40 chars recommended)  
- **Tags:** Comma-separated keywords for FZF searching

## Notes
- Only tools that are actually installed (via `command -v`) will appear
- Tags make tools searchable within the FZF interface
- Descriptions should be concise but informative
- The widget automatically shows "✓" for all tools (since we pre-filter to installed only)
