#!/usr/bin/env python3
"""
Parse Nix configuration files to extract tool information.
Used by the zsh fzf-tools-widget for dynamic tool discovery.
"""

import os
import re
import subprocess
import sys
from pathlib import Path
from typing import Dict, List, Tuple


def is_tool_installed(tool_name: str) -> bool:
    """Check if a tool is installed and available in PATH."""
    # Some packages have different binary names than package names
    binary_name_map = {
        "nodejs": "node",
        "ripgrep": "rg",
        "gnumake": "make",
        "difftastic": "difft",
        "claude-code": "claude",
        "postgresql": "psql",
    }

    # Use mapped binary name if available, otherwise use package name
    binary_name = binary_name_map.get(tool_name, tool_name)

    try:
        subprocess.run(
            ["which", binary_name],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            check=True,
        )
        return True
    except subprocess.CalledProcessError:
        return False


def parse_nix_file(file_path: Path) -> Dict[str, Tuple[str, str]]:
    """
    Parse a Nix configuration file for package declarations with comments.

    Returns:
        Dict mapping tool_name -> (description, tags)
    """
    tools = {}

    if not file_path.exists():
        return tools

    try:
        with open(file_path, "r") as f:
            content = f.read()
    except (IOError, OSError) as e:
        print(f"Error reading {file_path}: {e}", file=sys.stderr)
        return tools

    # Regex patterns for different comment formats
    patterns = [
        # Pattern 1: package # description {tags}
        r"^\s*([a-zA-Z0-9_-]+)\s*#\s*([^{]+?)\s*\{([^}]+)\}",
        # Pattern 2: package # description (no tags)
        r"^\s*([a-zA-Z0-9_-]+)\s*#\s*(.+?)(?:\s*$)",
        # Pattern 3: bare package name
        r"^\s*([a-zA-Z0-9_-]+)\s*$",
    ]

    for line in content.splitlines():
        # Skip lines that clearly aren't package declarations
        if (
            line.strip().startswith("#")
            or line.strip().startswith("with")
            or "pkgs" in line
            or (any(char in line for char in "[]") and "#" not in line)
        ):
            continue

        # Try each pattern in order
        for i, pattern in enumerate(patterns):
            match = re.match(pattern, line)
            if match:
                if i == 0:  # package # description {tags}
                    tool, desc, tags = match.groups()
                    tools[tool.strip()] = (desc.strip(), tags.strip())
                elif i == 1:  # package # description
                    tool, desc = match.groups()
                    tools[tool.strip()] = (desc.strip(), tool.strip())
                else:  # bare package
                    tool = match.group(1).strip()
                    # Only add if not already found with a comment
                    if tool not in tools and tool not in ["with", "pkgs"]:
                        tools[tool] = (f"{tool} package", tool)
                break

    return tools


def main():
    """Main function to parse Nix files and output tool information."""
    # Configuration file paths
    home_dir = Path.home()
    config_files = [
        home_dir / ".config/nixos/home.nix",
        home_dir / ".config/nixos/configuration.nix",
    ]

    all_tools = {}

    # Parse all configuration files
    for config_file in config_files:
        tools = parse_nix_file(config_file)
        all_tools.update(tools)

    # Debug: Print all parsed tools if DEBUG env var is set
    if os.environ.get("DEBUG"):
        print("DEBUG: All parsed tools:", file=sys.stderr)
        for tool, (desc, tags) in all_tools.items():
            installed = "✓" if is_tool_installed(tool) else "✗"
            print(f"  {installed} {tool}: {desc} [{tags}]", file=sys.stderr)
        print("", file=sys.stderr)

    # Filter to only installed tools and output
    for tool_name, (description, tags) in all_tools.items():
        if is_tool_installed(tool_name):
            print(f"{tool_name}:{description}:{tags}")


if __name__ == "__main__":
    main()

