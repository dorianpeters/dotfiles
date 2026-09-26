# dotfiles

Personal configuration files and editor settings.

## Micro Configuration for Python & CS50p

This repository contains a streamlined, productive configuration for the [micro](https://micro-editor.github.io/) terminal text editor, tailored specifically for learning Python and completing coursework like **CS50p (CS50's Introduction to Programming with Python)**.

### Features & Settings (`micro/settings.json`)

- **Autoformatting with [ruff](https://docs.astral.sh/ruff/)**:
  - Automatically formats Python files on save with `ruff format`.
  - Manual formatting on demand via <kbd>Alt</kbd> + <kbd>f</kbd> or `> format` / `> fmt`.
- **Typechecking & Error Finding with [ty](https://github.com/astral-sh/ty)**:
  - Integrated into micro's built-in linter engine.
  - Automatically checks for type mismatches, unresolved references, and syntax errors on save.
  - Highlights error lines in the gutter and displays diagnostic messages when navigating code.
  - Full diagnostic summary runnable via <kbd>F7</kbd> or `> check` / `> ty`.
- **PEP 8 Compliance**:
  - `tabstospaces: true`: Converts tab key presses into spaces.
  - `tabsize: 4`: Enforces standard 4-space Python indentation (avoids `IndentationError` / `TabError`).
  - `colorcolumn: 80`: Visual guide column at 80 characters to keep code and docstrings within PEP 8 / `style50` line limits.
- **Visual Editing & Focus**:
  - `ruler: true`: Displays line numbers in the gutter to quickly locate errors from Python tracebacks.
  - `cursorline: true`: Highlights the active line.
  - `matchbrace: true`: Instantly highlights matching parentheses `()`, brackets `[]`, and braces `{}`.
  - `colorscheme: "monokai"`: High-contrast, vibrant syntax highlighting.
- **Workflow & Clean Code**:
  - `rmtrailingws: true`: Strips trailing whitespace upon saving (cleans up git diffs and passes `style50`).
  - `eofnewline: true`: Ensures every file ends with a trailing newline.
  - `smartpaste: true`: Prevents staircase formatting issues when pasting Python code.
  - `diffgutter: true`: Shows Git modifications directly in the gutter.
  - `savecursor: true`: Remembers your cursor position across sessions.
  - `saveundo: true`: Retains undo history even after closing and reopening files.

### Keybindings & Commands

| Shortcut / Command | Action | Description |
| :--- | :--- | :--- |
| <kbd>Ctrl</kbd> + <kbd>s</kbd> | Save & Autoformat | Saves the file, autoformats using `ruff`, and triggers `ty` checks. |
| <kbd>Alt</kbd> + <kbd>f</kbd> or `> format` | Format Code | Formats active Python file with `ruff format`. |
| <kbd>F7</kbd> or `> check` / `> ty` | Typecheck & Errors | Runs `ty check` interactively to show full diagnostic report. |
| <kbd>F5</kbd> or `> run` / `> python` | Run Python | Saves the file and executes `python3 <filename>` in an interactive terminal shell (supports `input()`). |
| <kbd>F6</kbd> or `> test` / `> pytest` | Run Tests | Saves the file and executes `pytest <filename>`. |
| <kbd>Ctrl</kbd> + <kbd>q</kbd> | Quit | Closes current buffer/micro. |
| <kbd>Ctrl</kbd> + <kbd>e</kbd> | Command Prompt | Opens the micro command bar (type `format`, `check`, `run`, `help`, etc.). |
| <kbd>Ctrl</kbd> + <kbd>f</kbd> | Find | Searches text in the current buffer. |
| <kbd>Alt</kbd> + <kbd>/</kbd> or <kbd>Ctrl</kbd> + <kbd>/</kbd> | Toggle Comment | Comments or uncomments the selected line(s) with `#`. |

### Installation / Linking

To link this configuration to your local micro editor:

```bash
./install.sh
```

This creates symbolic links from `micro/` in this repository to `~/.config/micro/`, backing up any existing configuration files.
