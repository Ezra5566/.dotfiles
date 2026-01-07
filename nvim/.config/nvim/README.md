# Ezra's Neovim Configuration

A modern, feature-rich Neovim configuration using lazy.nvim as the package manager.

## 🚀 Features

- **Package Management**: lazy.nvim for fast and efficient plugin management
- **LSP Support**: Full Language Server Protocol support with Mason
- **Code Completion**: nvim-cmp for intelligent code completion
- **Telescope**: Powerful fuzzy finder for files, buffers, and more
- **Treesitter**: Syntax highlighting and code understanding
- **Git Integration**: LazyGit for git operations
- **Formatting**: Auto-formatting with multiple formatters
- **Linting**: Code quality checking with various linters
- **UI/UX**: Beautiful themes and enhanced UI elements

## 📁 Structure

```
nvim/
├── init.lua                    # Main configuration file
├── lua/
│   ├── ezzdev/                # Core configuration
│   │   ├── autocmds.lua       # Auto commands
│   │   ├── globals.lua        # Global variables
│   │   ├── keymaps.lua        # Key mappings
│   │   └── options.lua        # Editor options
│   ├── plugins/               # Plugin configurations
│   │   ├── formatting/        # Code formatters
│   │   ├── langs/             # Language-specific configs
│   │   ├── linting/           # Linters configuration
│   │   ├── lsp/               # LSP setup
│   │   └── ...                # Other plugin configs
│   └── util/                  # Utility functions
└── stylua.toml               # Lua formatting config
```

## 🛠️ Installation

1. Backup your existing Neovim configuration:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. Clone this configuration:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

3. Open Neovim. Lazy.nvim will automatically install all plugins.

## ⚙️ Key Mappings

- `<Space>` - Leader key
- `<Ctrl-p>` - Telescope file finder
- `<Ctrl-g>` - LazyGit
- `<Space>lf` - Format file
- `<Space>lr` - LSP rename
- `<Space>ld` - LSP definition
- `<Space>ca` - LSP code actions

## 🎨 Customization

### Adding New Plugins

Add plugins to the appropriate files in `lua/plugins/`. For example:

```lua
-- In lua/plugins/your-plugin.lua
return {
  "author/plugin-name",
  config = function()
    -- Plugin configuration
  end,
}
```

### Language Support

Language-specific configurations are in `lua/plugins/langs/`. Each file contains LSP, formatting, and linting setup for that language.

### Formatting

Formatters are configured in `lua/plugins/formatting/`. Supported formatters include:
- Stylua (Lua)
- Prettier (JavaScript/TypeScript)
- Black (Python)
- dprint (Rust/TypeScript)

## 📦 Main Plugins

- **lazy.nvim** - Plugin manager
- **telescope.nvim** - Fuzzy finder
- **nvim-cmp** - Completion engine
- **nvim-treesitter** - Syntax highlighting
- **mason.nvim** - LSP package manager
- **lazygit.nvim** - Git interface
- **catppuccin** - Color scheme
- **null-ls.nvim** - Formatting and linting

## 🔧 LSP Servers

Commonly used LSP servers are automatically installed by Mason:
- lua_ls
- pyright
- tsserver
- rust_analyzer
- clangd

## 🐛 Troubleshooting

If you encounter issues:

1. Update plugins: `:Lazy update`
2. Check LSP status: `:LspInfo`
3. View logs: `:messages`
4. Reset configuration: Remove `~/.local/share/nvim` and restart

## 📝 Notes

- This configuration uses `vim.opt` for options (modern Neovim)
- All plugins are lazy-loaded for optimal startup performance
- The configuration is modular and easy to extend
- Auto-formatting is enabled on save for supported file types