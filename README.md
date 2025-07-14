# Emacs Configuration for Modern C/C++ Development

This Emacs configuration is optimized for C and C++ development using:
- `eglot` for LSP integration (with Clangd)
- `clang-format` for consistent code formatting
- `company-mode` for completion
- Modern UI enhancements (themes, modeline, dashboard)

---

## ✅ Features

### ⚙️ Core Functionality
- Uses `eglot` as the Language Server Protocol client
- Integrated with `clangd` for:
  - Code navigation (jump to definition, references)
  - Inlay hints and inline diagnostics
- Auto-formatting with `clang-format` on save
- Code completion via `company-mode` and `company-box`
- Snippet support via `yasnippet`

### 💅 UI Enhancements
- Doom theme and modeline
- Icon support with `all-the-icons`
- Startup dashboard via `dashboard`
- Smart parens and delimiter highlighting
- Font: JetBrainsMono Nerd Font (set to 130 height)

### 🔧 Developer Tools
- `which-key`: shows available keybindings
- `rainbow-delimiters`, `highlight-parentheses` for readable code
- Treemacs integration available (optional)

---

## 🚀 Requirements

- **Emacs 29+**
- **clangd** (installed via Homebrew or LLVM):
  ```bash
  brew install llvm
