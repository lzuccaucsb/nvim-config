-- Basic settings
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true -- redundant with filetype indentexpr; caused double-indent inside brackets
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.updatetime = 50
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.isfname:append("@-@")
vim.opt.colorcolumn = "80"
vim.opt.cmdheight = 1
vim.opt.spelllang = { "en" } -- set language for spellchecking
vim.opt.grepprg = "rg --vimgrep" -- use ripgrep if availible
vim.opt.grepformat = "%f:%l:%c:%m" -- filename, line number, column, content

-- Search settings
vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in search
vim.opt.hlsearch = false -- show the matches as you type

-- Visual settings
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.colorcolumn = "100"
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.matchtime = 2 -- How long to show matching brackets 
vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options
vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options
vim.opt.showmode = false -- don't show mode in command line
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popum menu transparency
vim.opt.winblend = 0
vim.opt.conceallevel = 0 -- Don't hide markup
vim.opt.concealcursor = "" -- show markup even on cursor line
vim.opt.lazyredraw = false
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
vim.opt.synmaxcol = 300

-- File handling
vim.opt.backup = false -- Don't create backup filese
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true
vim.opt.autowrite = false
vim.opt.diffopt:append("vertical") -- vertical diff splits
vim.opt.diffopt:append("algorithm:patience") -- better diff algorithm
vim.opt.diffopt:append("linematch:60") -- better diff highlighting

-- Set undo directory and ensureit exists
local undodir = "~/.local/share/nvim/undodir" -- Undo directory path
vim.opt.undodir = vim.fn.expand(undodir) -- Expand to full path
local undodir_path = vim.fn.expand(undodir)
if vim.fn.isdirectory(undodir_path) == 0 then
    vim.fn.mkdir(undodir_path, "p") -- Create if not exists
end


-- Behaviour settings
vim.opt.errorbells = false -- Disable error sounds
vim.opt.backspace = "indent,eol,start" -- Make backspace behave naturally
vim.opt.autochdir = false -- Don't change directory automatically
vim.opt.iskeyword:append("-") -- Treat dash as part of word
vim.opt.selection = "inclusive" -- Use inclusive selection
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard
vim.opt.modifiable = true -- Allow editing buffers
vim.opt.encoding = "UTF-8" -- use uft8 encoding
vim.opt.wildmenu = true -- Enable command line completion menu
vim.opt.wildmode = "longest:full,full" -- Completion mode for commandline
vim.opt.wildignorecase = true -- Case insensitive tab completion in commands

-- Folding settings
vim.opt.foldmethod = "expr" -- Use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
vim.opt.foldlevel = 99 -- Keep all folds open by defualt

-- Split behaviour
vim.opt.splitbelow = true
vim.opt.splitright = true





