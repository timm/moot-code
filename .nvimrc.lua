-- 🗂️ Netrw settings and auto-launch
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("Vex")
    vim.cmd("vertical resize 25")
  end
})

-- 🧼 Clean UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.hidden = true
vim.opt.termguicolors = true
vim.opt.fillchars = { eob = " " }
vim.opt.title = true
vim.opt.titlestring = "NVIM — %F"

-- 🔤 Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- 🔍 Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 🎨 Appearance
vim.cmd("syntax enable")
vim.opt.background = "dark"
vim.cmd("colorscheme sorbet")

-- 🧠 Behavior & files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- ⌨️ Mappings
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", ":Vex<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>x", ":w<CR>:!chmod +x % && ./%<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "Y", "y$", { noremap = true })
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })

-- ✨ Yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
})

