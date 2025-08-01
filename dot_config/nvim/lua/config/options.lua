vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.scrolloff = 4 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context

opt.showmode = false -- Only show mode in the statusline
opt.signcolumn = "yes" -- Always show signcolumn to avoid text shifting

-- General options {{{
opt.history = 50 -- keep 50 lines of command line history

opt.selection = "exclusive"
opt.selectmode = { "mouse", "key" }
opt.mousemodel = "popup"
opt.keymodel = { "startsel", "stopsel" }

opt.wildmode = "longest:full,full" -- Command-line completion mode
--}}}
-- Appearance options {{{
opt.laststatus = 3 -- global statusline
opt.cursorline = true -- highlight the current line
opt.number = true -- show line numbers

opt.background = "dark" -- set background early to avoid possible screen flash
opt.termguicolors = true -- True color support
--}}}
-- Search options {{{
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals
-- If ripgrep is available, use it as the grep prog.
-- Otherwise, fall back to GNU grep.
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --no-heading"
  opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
  -- opt.grepformat = "%f:%l:%c:%m"
else
  opt.grepprg = "grep -nH"
end
--}}}
-- Default file options {{{
-- (these can be overridden later for specific filetypes)
opt.tabstop = 4 -- Exapnd hard tabs to 4-spaces for display
opt.shiftwidth = 4 -- Default indent size
opt.softtabstop = -1 -- Soft tab size uses 'shiftwidth' value
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftround = true -- Round indent to multiples of 'shiftwidth'
--}}}
