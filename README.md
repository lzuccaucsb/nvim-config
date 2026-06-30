# Neovim Config

Personal Neovim configuration. Plugin manager is [lazy.nvim](https://github.com/folke/lazy.nvim).
The LSP setup is modeled on [radleylewis/nvim](https://github.com/radleylewis/nvim) and uses
Neovim's **native LSP API** (`vim.lsp.config` / `vim.lsp.enable`), so it requires **Neovim 0.11+**.

This README documents the LSP system specifically: how it fits together, the keymaps, and how to
extend it.

---

## Architecture

The LSP system has a **two-layer design**:

- **Plugins** (`lua/plugins/`) declare *what to install*.
- **Servers** (`lua/servers/`) declare *how each language server runs*.

Load flow on startup:

```
nvim starts
  └─ lazy.nvim reads lua/plugins/*        installs plugins
       └─ nvim-lspconfig.lua  config()    runs after plugins load
            ├─ require("utils.diagnostics").setup()   styles diagnostics
            └─ require("servers")                       -> lua/servers/init.lua
                 ├─ build capabilities (from cmp_nvim_lsp)
                 ├─ load 12 server recipes (servers/*.lua)
                 └─ vim.lsp.enable({...})               servers start per filetype
  └─ open a file -> matching server attaches -> completion + diagnostics
       ├─ nvim-cmp renders the completion popup
       └─ efm runs formatters/linters as if they were a language server
```

Why split: plugin installs rarely change; server config changes every time you add a language.
Adding a language touches **only** `lua/servers/` — never the plugin specs.

---

## File map

| File | Job |
| --- | --- |
| `lua/plugins/nvim-lspconfig.lua` | Plugin spec. Installs mason, efmls-configs-nvim, cmp-nvim-lsp. Its `config` calls diagnostics setup + `require("servers")`. **Plumbing only** — no server config here. |
| `lua/plugins/nvim-cmp.lua` | Completion engine (the autocomplete popup). Also produces the `capabilities` every server uses. Copilot scaffolding included but commented out. |
| `lua/utils/diagnostics.lua` | How errors/warnings look: inline text, underline, float popup, custom gutter sign glyphs. |
| `lua/servers/init.lua` | **Orchestrator.** Builds capabilities once, runs every recipe, `vim.lsp.enable(...)`, and sets the LSP keymaps via an `LspAttach` autocmd. |
| `lua/servers/<name>.lua` | One **recipe** per server: `return function(capabilities) vim.lsp.config(name, {...}) end`. Registers settings + which filetypes wake it. |

Server recipes (12):
`lua_ls`, `pyright`, `gopls`, `jsonls`, `ts_ls`, `bashls`, `clangd`, `dockerls`, `emmet_ls`,
`yamlls`, `tailwindcss`, and `efm-langserver` (the formatter/linter bridge).

---

## The three moving parts

| Part | Job | Lives in |
| --- | --- | --- |
| **Language servers** (pyright, gopls, ...) | Language smarts: goto-definition, hover, references, completion, diagnostics. | `lua/servers/*.lua` |
| **nvim-cmp** | Renders the completion popup; feeds `capabilities` to servers. | `lua/plugins/nvim-cmp.lua` |
| **efm** | Runs CLI formatters/linters (stylua, black, prettier, eslint, ...) and exposes them through the LSP client. | `lua/servers/efm-langserver.lua` |

[Mason](https://github.com/mason-org/mason.nvim) is the installer that puts the actual binaries on
disk. Open its UI with `:Mason`.

---

## Keymaps

Leader key is **space**.

### LSP (normal mode, active only in buffers where a server attached)

Set in the `LspAttach` autocmd at the bottom of `lua/servers/init.lua`.

| Key | Action |
| --- | --- |
| `gd` | Goto definition |
| `gD` | Goto declaration |
| `gr` | List references |
| `gi` | Goto implementation |
| `K` | Hover docs |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>f` | Format buffer (via efm) |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>d` | Show diagnostic float |

### Completion (insert mode, while the cmp menu is open)

Set in `lua/plugins/nvim-cmp.lua`.

| Key | Action |
| --- | --- |
| `<C-j>` | Next item |
| `<C-k>` | Previous item |
| `<C-b>` | Scroll docs up |
| `<C-f>` | Scroll docs down |
| `<C-Space>` | Trigger completion |
| `<C-e>` | Abort menu |
| `<CR>` | Confirm selection |

---

## Installing binaries

The config files describe *how* to run servers/tools, but the binaries are installed separately via
Mason. Install all 12 servers + the efm formatter/linter tools in one go:

```
:MasonInstall lua-language-server pyright gopls json-lsp typescript-language-server bash-language-server clangd dockerfile-language-server emmet-ls yaml-language-server tailwindcss-language-server efm luacheck stylua flake8 black revive gofumpt prettierd eslint_d fixjson shellcheck shfmt hadolint cpplint clang-format
```

**Toolchain prerequisites** (some tools are built/installed by their language's toolchain, which
must be on `PATH`):

- **Go** — `gopls`, `gofumpt`, `revive`  (install: `brew install go`)
- **Node** — `prettierd`, `eslint_d`, `typescript-language-server`, `json-lsp`, `tailwindcss-language-server`, `emmet-ls`
- **Python** — `black`, `flake8`, `cpplint`

After installing a missing toolchain, **restart Neovim** (so it picks up the updated `PATH`) before
re-running `:MasonInstall`.

Verify a server is attached: open a relevant file and run `:checkhealth lsp` or `:LspInfo`.

---

## How-to: add a language

1. **Create the recipe** `lua/servers/<name>.lua`:

   ```lua
   return function(capabilities)
       vim.lsp.config("<name>", {
           capabilities = capabilities,
           -- filetypes = { ... },   -- optional
           -- settings = { ... },    -- optional
       })
   end
   ```

2. **Wire it into** `lua/servers/init.lua` — add two lines:

   ```lua
   require("servers.<name>")(capabilities)   -- with the other require()s
   ```

   ```lua
   vim.lsp.enable({
       ...
       "<name>",                              -- add to the enable list
   })
   ```

3. **Install the binary**: `:MasonInstall <mason-package-name>` (the Mason package name may differ
   from the server name — check `:Mason`).

---

## GitHub Copilot

Copilot is **enabled**, running in **cmp menu mode** (mode A). Suggestions show in the nvim-cmp
completion popup tagged with the `` icon — navigate with `<C-j>`/`<C-k>`, accept with `<CR>`.

Setup that was done (for reference / re-enabling on a fresh machine):

1. In `lua/plugins/nvim-cmp.lua`, the three `COPILOT:` markers are uncommented (the
   `{ name = "copilot" }` source, and the `copilot = ""` menu icon).
2. `lua/plugins/copilot.lua` exists (installs `zbirenbaum/copilot.lua` + `zbirenbaum/copilot-cmp`).
3. `:Lazy sync` to install the plugins.
4. `:Copilot auth` — one-time GitHub login (requires an active Copilot subscription).
5. `:Copilot status` to verify it's online.

### Two modes

You can run Copilot one of two ways — not both at once (double UI = noise):

- **Mode A — cmp menu (current).** Suggestions appear in the completion popup, line-oriented.
  Config: `suggestion = { enabled = false }` in `copilot.lua`, plus the `{ name = "copilot" }`
  source active in `nvim-cmp.lua`.
- **Mode B — inline ghost text.** Full multi-line suggestion appears in gray ahead of the cursor;
  `<Tab>` accepts the whole block. To switch permanently: set `suggestion = { enabled = true,
  auto_trigger = true, keymap = { accept = "<Tab>" } }` in `copilot.lua`, **and** re-comment the
  `{ name = "copilot" }` source + `copilot = ""` icon in `nvim-cmp.lua`, then `:Lazy sync`.

To **test mode B temporarily** without editing files (reverts on nvim restart):

```vim
:lua require("copilot").setup({ suggestion = { enabled = true, auto_trigger = true, keymap = { accept = "<Tab>" } }, panel = { enabled = false } })
```

`panel = { enabled = false }` disables the third UI (a separate split listing many suggestions,
opened via `:Copilot panel`) — unused here.

---

## Troubleshooting

- **`pyright 100%` notification spam on every keystroke** — already fixed: `mini.notify` is set with
  `lsp_progress = { enable = false }` in `lua/plugins/mini.nvim.lua`. (pyright's `diagnosticMode =
  "workspace"` re-scans the project on each edit and emits progress events.)
- **Diagnostic / completion icons show as boxes** — no Nerd Font in your terminal. Install one (e.g.
  `brew install --cask font-jetbrains-mono-nerd-font`) and set it as the terminal font.
- **A server fails to install in Mason** — usually a missing toolchain. Check the prerequisites above
  (Go / Node / Python), install it, restart Neovim, retry.
- **`module 'cmp_nvim_lsp' not found` on startup** — plugins not installed yet. Run `:Lazy sync`,
  then restart.
