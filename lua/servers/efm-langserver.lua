return function(capabilities)
  -- =========================================================================
  -- 1. Import Linters and Formatters
  -- =========================================================================
  -- These require statements load configuration presets from 'efmls-configs'
  local luacheck = require("efmls-configs.linters.luacheck")
  local stylua = require("efmls-configs.formatters.stylua")
  local ruff_lint = require("efmls-configs.linters.ruff")
  local ruff_fmt = require("efmls-configs.formatters.ruff")
  local go_revive = require("efmls-configs.linters.go_revive")
  local gofumpt = require("efmls-configs.formatters.gofumpt")
  local prettier_d = require("efmls-configs.formatters.prettier_d")
  local eslint_d = require("efmls-configs.linters.eslint_d")
  local fixjson = require("efmls-configs.formatters.fixjson")
  local shellcheck = require("efmls-configs.linters.shellcheck")
  local shfmt = require("efmls-configs.formatters.shfmt")
  local hadolint = require("efmls-configs.linters.hadolint")
  local cpplint = require("efmls-configs.linters.cpplint")
  local clangformat = require("efmls-configs.formatters.clang_format")
  local djlint_fmt = require("efmls-configs.formatters.djlint")

  -- =========================================================================
  -- 2. Configure EFM Language Server
  -- =========================================================================
  vim.lsp.config("efm", {
    -- Inherit capabilities (e.g., autocompletion, snippets) from your main LSP setup
    capabilities = capabilities,

    -- Define which filetypes will trigger the EFM language server
    filetypes = {
      "c",
      "cpp",
      "docker",
      "go",
      "html",
      "htmldjango",
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "python",
      "sh",
      "svelte",
      "typescript",
      "typescriptreact",
      "vue",
    },

    -- Tell Neovim which LSP features EFM should handle
    init_options = {
      documentFormatting = true,      -- Enables code formatting (:lua vim.lsp.buf.format())
      documentRangeFormatting = true, -- Enables formatting visual selections
      hover = true,                   -- Enables tooltips / hover documentation
      documentSymbol = true,          -- Enables document outline/symbol navigation
      codeAction = true,              -- Enables quick-fix suggestions from linters
      completion = true,              -- Enables autocompletion hooks
    },

    -- =========================================================================
    -- 3. Map Tools to Languages
    -- =========================================================================
    -- Assigns the imported linters and formatters to their respective filetypes
    settings = {
      languages = {
        c = { clangformat, cpplint },
        cpp = { clangformat, cpplint },
        css = { prettier_d },
        docker = { hadolint, prettier_d },
        go = { gofumpt, go_revive },
        html = { prettier_d },
        htmldjango = { djlint_fmt },
        javascript = { eslint_d, prettier_d },
        javascriptreact = { eslint_d, prettier_d },
        json = { eslint_d, fixjson },
        jsonc = { eslint_d, fixjson },
        lua = { luacheck, stylua },
        markdown = { prettier_d },
        python = { ruff_lint, ruff_fmt },
        sh = { shellcheck, shfmt },
        svelte = { eslint_d, prettier_d },
        typescript = { eslint_d, prettier_d },
        typescriptreact = { eslint_d, prettier_d },
        vue = { eslint_d, prettier_d },
      },
    },
  })
end
