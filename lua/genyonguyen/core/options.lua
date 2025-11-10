-- Basic settings
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- File handling
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.autoread = true

-- Search settings
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.hlsearch = true

-- Visual settings
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.background = "dark"
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"

-- Behavior settings
vim.opt.backspace = { "indent", "eol", "start" } -- Better backspace behavior
vim.opt.iskeyword:append("-") -- Treat dash as part of word
vim.opt.path:append("**") -- include subdirectories in search
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")

-- Split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

-- Cursor settings
vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:block-blinkwait700-blinkoff400-blinkon250,r-cr:hor20,o:hor50,a:Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

vim.g.editorconfig = true
