# My Changes

Personal customizations layered on top of upstream kickstart.nvim. Read this before updating the base config.

## Current state

- Config path: `~/.config/nvim` (symlink to `~/dotfiles/nvim/.config/nvim`)
- Git repo: `git@github.com:rdxpr/dotfiles.git` (the whole dotfiles repo)
- Base: kickstart.nvim `main`, commit `8e35dbe` (2026-10-03)
- Neovim: 0.12.6
- Plugin manager: `vim.pack` (upstream)
- Pre-update backup: `init.lua.bak-2026-10-28` (old lazy.nvim-based config, kickstart base around `bcdb4cd`, 2024-12-12)

## What is custom

### 1. `lua/custom/init.lua`

All personal preferences and keymaps live here. It is loaded by `require 'custom'` from `init.lua:177`. Keep this file when replacing the base config.

Preferences:

- `vim.g.have_nerd_font = true`
- `vim.o.relativenumber = true`
- `vim.o.termguicolors = true`
- System clipboard is not synced automatically; it is cleared on `VimEnter`.

Keymaps:

- `<leader>y` in normal/visual mode: yank to the system clipboard (`"+y`)
- `<A-j>` / `<A-k>` in visual mode: move the line down/up
- `p` in visual mode and `<leader>p` in visual mode: paste without yanking (`"_dP`)
- `J` / `K` / `<A-j>` / `<A-k>` in visual mode: move the selection and keep it selected
- `gl` in normal mode: open the floating diagnostic message

### 2. Edits inside `init.lua`

Only three local edits exist. Re-apply them after copying the latest upstream `init.lua`.

1. Load the custom file after the options block and before plugin setup, because `have_nerd_font` is read during plugin setup. Currently at `init.lua:177`:

   ```lua
   require 'custom'
   ```

2. Add the extra language servers to the `servers` table. Currently around `init.lua:752`:

   ```lua
   -- Web development
   tsc = {}, -- TypeScript / JavaScript (native TypeScript 7 LSP)
   html = {},
   cssls = {},
   jsonls = {},
   emmet_ls = {
     filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact' },
   },
   eslint = {},
   tailwindcss = {},

   -- Python
   pyright = {},
   ```

3. Add `tree-sitter-cli` to the Mason `ensure_installed` list. Currently around `init.lua:824`:

   ```lua
   vim.list_extend(ensure_installed, {
     -- Needed by nvim-treesitter to build parsers.
     'tree-sitter-cli',
   })
   ```

   Without it, nvim-treesitter on the `main` branch fails with `ENOENT: no such file or directory (cmd): 'tree-sitter'` while installing parsers.

## Update checklist

1. Back up the current config:

   ```sh
   cp ~/.config/nvim/init.lua ~/.config/nvim/init.lua.bak-$(date +%F)
   ```

2. Get the latest upstream:

   ```sh
   cd /tmp
   rm -rf kickstart.nvim
   git clone https://github.com/nvim-lua/kickstart.nvim.git
   ```

   For future diffs, add a remote once:

   ```sh
   cd ~/.config/nvim
   git remote add kickstart https://github.com/nvim-lua/kickstart.nvim.git
   git fetch kickstart
   git diff kickstart/main -- init.lua
   ```

3. Replace `init.lua` with upstream:

   ```sh
   cp /tmp/kickstart.nvim/init.lua ~/.config/nvim/init.lua
   ```

4. Re-apply the three edits from "Edits inside `init.lua`".

5. Confirm `lua/custom/init.lua` is still present and is still required.

6. Start Neovim and verify:

   ```sh
   nvim --headless "+lua print('ok')" +qa
   ```

   Inside Neovim:

   - `:map <leader>y`
   - `:map gl`
   - `:lua =vim.o.relativenumber`
   - `:lua =vim.g.have_nerd_font`
   - `:lua =vim.o.clipboard` (should be empty after startup)
   - `:lua =vim.lsp.is_enabled('tsc')`
   - `:lua =vim.lsp.is_enabled('pyright')`

7. Install any missing Mason packages:

   ```vim
   :MasonInstall tsc pyright css-lsp json-lsp eslint-lsp tailwindcss-language-server tree-sitter-cli
   ```

   `html-lsp`, `lua-language-server`, and `emmet-language-server` may already be installed. The Mason `tsc` package installs `typescript@7.x`, which provides the native `tsc --lsp` server.

## Requirements and constraints

- The user only cares about custom keybinds and editor preferences. Plugins and the plugin manager can change freely.
- TypeScript/JavaScript, Python, and Lua LSPs must work. Web development LSPs are also desired.
- Do not perform destructive actions without asking. Back up before replacing config files.
- Ask before using hacky workarounds.
- Outdated packages and old plugin configuration can be dropped. There is no need to preserve old plugin setup.

## Notes for future agents

- Upstream kickstart on `main` uses `vim.pack`, `blink.cmp`, and `vim.lsp.config` / `vim.lsp.enable`. It no longer uses `lazy.nvim` or `nvim-cmp`.
- TypeScript/JavaScript uses the native TypeScript 7 LSP (`tsc`), not the old `ts_ls` / `typescript-language-server`. `tsgo` is deprecated in favor of `tsc`. The Mason `tsc` package installs `typescript@7.x`; a project-local TypeScript 7 `node_modules/.bin/tsc` takes precedence when available.
- `lua/custom/init.lua` is plain Neovim Lua and has no plugin-manager dependency.
- `lua/custom/plugins/init.lua` is unused and returns `{}`.
- Old lazy.nvim plugins in `~/.local/share/nvim/lazy` are not loaded by the new config and can be removed after confirming the new setup works.
- Old kickstart helper files under `lua/kickstart/` are unused.
- `nvim-pack-lock.json` is generated by `vim.pack`; consider tracking it in git.
- The clipboard preference uses a `VimEnter` autocmd in `lua/custom/init.lua` because upstream schedules `clipboard=unnamedplus` during startup. If upstream changes that behavior, verify `:lua =vim.o.clipboard` is empty after startup.
- If a future base already defines any of the custom keymaps, re-apply them after the base's keymaps so the personal mappings win.
- The dotfiles repo may show unrelated changes (for example `zsh/.zshrc`). Do not commit or revert those unless asked.

## Verify commands

```sh
luac -p ~/.config/nvim/init.lua
luac -p ~/.config/nvim/lua/custom/init.lua
nvim --headless "+lua print('ok')" +qa
```
