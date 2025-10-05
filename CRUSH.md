# CRUSH.md

### Build/Lint/Test Commands

- **Formatting**:  
  - Use `:lua require("conform").format()` or `<leader>f` in Neovim to auto-format code (Stylua for Lua, prettier for JS/TS, etc.).
- **Linting**:  
  - Use `:lua require("lint").try_lint()` or `<leader>l` to lint the current file (eslint_d for JS/TS, pylint for Python, yamllint for YAML).  
  - Lint runs automatically on buffer write/enter/insert-leave.
- **Testing**:  
  - **Run nearest test:** `<leader>ntr`
  - **Run tests in current file:** `<leader>ntf`
  - **Debug nearest test:** `<leader>ntd`
  - **Stop nearest test:** `<leader>nts`
  - **Attach to nearest test:** `<leader>nta`
  - Powered by neotest.nvim (see `lua/plugins/neotest.lua`).

### Code Style Guidelines

- **Imports:**  
  - Lua: Use local `require` statements for modules; order alphabetically where practical.
- **Formatting:**  
  - 4 spaces per indent.  
  - Use double quotes.  
  - Unix line endings.  
  - Max column width: 120 chars.
- **Types & Naming:**  
  - Use `local` for variables, functions, and modules.  
  - `snake_case` for variables, lower/snake_case for files, `PascalCase` for modules.  
  - Avoid globals.
- **Error Handling:**  
  - Explicit error checks (`if not ... then return end`).  
  - Use `vim.notify` for user errors.
- **Function Style:**  
  - Prefer local functions.  
  - Comment only minimal, necessary logic.  
  - Use descriptive function/variable names.
- **Tests:**  
  - Use neotest for all new test integration.  
  - Prefer small, file-local tests.
- **Committing:**  
  - Do **not** commit secrets, credentials, or local editor/user paths.
- **General:**  
  - No Cursor/Copilot rules detected.  
  - Follow idiomatic Lua and Neovim best practices.
