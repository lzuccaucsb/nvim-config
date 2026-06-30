-- ================================================================================================
-- TITLE : nvim-cmp
-- ABOUT : Completion engine. Shows the autocomplete popup and feeds LSP "capabilities"
--         (via cmp-nvim-lsp) to every language server so servers know the editor supports
--         completion, snippets, signature help, etc.
-- LINKS :
--   > github           : https://github.com/hrsh7th/nvim-cmp
--   > lspkind          : https://github.com/onsails/lspkind.nvim          (icons in menu)
--   > LuaSnip          : https://github.com/L3MON4D3/LuaSnip              (snippet engine)
--   > friendly-snippets: https://github.com/rafamadriz/friendly-snippets  (premade snippets)
--   > cmp-nvim-lsp     : https://github.com/hrsh7th/cmp-nvim-lsp          (LSP source)
--   > cmp-buffer       : https://github.com/hrsh7th/cmp-buffer            (current-buffer words)
--   > cmp-path         : https://github.com/hrsh7th/cmp-path              (filesystem paths)
--   > signature-help   : https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
--
-- GITHUB COPILOT (currently DISABLED — see the 3 "COPILOT:" markers below to enable):
--   To turn Copilot on later you change THREE places in this project:
--     1. Create lua/plugins/copilot.lua          (template at bottom of this comment block)
--     2. Uncomment the `{ name = "copilot" }` line in the `sources` table below.
--     3. (optional) Uncomment the `copilot = ""` line in the lspkind `menu` table for an icon.
--   Then run `:Lazy sync` and `:Copilot auth` (one-time GitHub login; needs a Copilot sub).
--
--   ---- template for lua/plugins/copilot.lua (create this file when enabling) ----------------
--   return {
--       {
--           "zbirenbaum/copilot.lua",
--           cmd = "Copilot",
--           event = "InsertEnter",
--           opts = {
--               suggestion = { enabled = false },  -- disable inline ghost text; cmp drives it
--               panel = { enabled = false },
--           },
--       },
--       {
--           "zbirenbaum/copilot-cmp",            -- exposes Copilot as a nvim-cmp source
--           dependencies = "zbirenbaum/copilot.lua",
--           opts = {},
--       },
--   }
--   -------------------------------------------------------------------------------------------
-- ================================================================================================

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "onsails/lspkind.nvim", -- VS Code-like pictograms in the menu
    "saadparwaiz1/cmp_luasnip", -- bridges LuaSnip into cmp as a source
    {
      "L3MON4D3/LuaSnip", -- the snippet engine itself
      version = "v2.*",
      build = "make install_jsregexp", -- compiles optional regex support
    },
    "rafamadriz/friendly-snippets", -- big library of ready-made snippets
    "hrsh7th/cmp-nvim-lsp", -- LSP completion source (+ default_capabilities)
    "hrsh7th/cmp-buffer", -- complete from words in open buffers
    "hrsh7th/cmp-path", -- complete filesystem paths
    "hrsh7th/cmp-nvim-lsp-signature-help", -- shows function arg hints while typing

    -- COPILOT (1/3): when enabling, you do NOT add deps here — Copilot lives in its own
    -- plugin file (lua/plugins/copilot.lua, see header). Lazy loads it automatically.
  },
  config = function()
    local lspkind = require("lspkind")
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- load all VS Code-style snippets shipped by friendly-snippets (lazily)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      -- tell cmp how to expand a chosen snippet, using LuaSnip
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- how each entry is rendered: icon + text, plus a short source tag on the right
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          menu = {
            -- COPILOT (3/3 optional): uncomment for a Copilot tag in the menu
            copilot = "",
            luasnip = "",
            buffer = "",
            path = "",
            nvim_lsp = "🅻",
          },
        }),
      },

      -- keybinds active while the completion menu / insert mode is open
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- up in menu
        ["<C-j>"] = cmp.mapping.select_next_item(), -- down in menu
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- scroll doc popup up
        ["<C-f>"] = cmp.mapping.scroll_docs(4), -- scroll doc popup down
        ["<C-l>"] = cmp.mapping.complete(), -- force-open menu
        ["<C-q>"] = cmp.mapping.abort(), -- close menu, keep typed text
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Enter = confirm highlighted
      }),

      -- completion sources, in priority order (higher = listed first)
      sources = {
        -- COPILOT (2/3): uncomment to feed Copilot suggestions into the menu.
        -- Put it first so AI suggestions rank at the top.
        { name = "copilot" },
        { name = "luasnip" }, -- snippets
        { name = "nvim_lsp" }, -- language server items
        { name = "buffer" }, -- words from current buffer
        { name = "path" }, -- file paths
        { name = "nvim_lsp_signature_help" }, -- function signature hints
      },
    })
  end,
}
