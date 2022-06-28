-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
opt.clipboard = ''         -- do not Copy/paste to system clipboard
opt.swapfile = true                  -- use swapfile
opt.directory='.' -- put swapfile in same directory as file
-- do I still want to keep swap files next to the actual file?
-- I think yes, because of my script for dealing with swap files after an unclean shutdown uses it.

-- opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options
opt.completeopt = 'longest,menu,preview'

opt.wildignore:append '*/.git/*,*/.hg/*,*/.svn/*'
-- the default for cms is `/*%s*/` which is far less common than commenting to
-- a pound sign. so set cms to a pound before filetype kicks in overrides when
-- the correct comment type is known.
opt.commentstring='#%s'

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true           -- Show line number
opt.cursorline = true
opt.showmatch = true        -- Highlight matching parenthesis
-- opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
opt.foldlevel=1 -- default fold level. 0 for all closed
-- opt.colorcolumn = '80'      -- Line lenght marker at 80 columns
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.linebreak = true        -- Wrap on word boundary
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.hlsearch = true         -- highlight results

opt.wildmenu = true         -- show some autocomplete options in status bar

opt.textwidth=0 -- do not break lines when line lenght increases
opt.scrolloff=3
opt.sidescrolloff=3


-- set diffopt+=filler
-- set diffopt+=iwhite
-- set diffopt+=icase

-- opt.laststatus=3            -- Set global statusline

opt.guioptions='egit'

opt.diffopt='internal,filler,closeoff,iwhite,icase'

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true        -- Use spaces instead of tabs
opt.shiftwidth = 4          -- Shift 4 spaces when tab
opt.tabstop = 4             -- 1 tab == 4 spaces
opt.smartindent = true      -- Autoindent new lines
opt.autoindent = true      -- Autoindent new lines
opt.pastetoggle='<F12>'       -- Sane indentation on pastes

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 1000           -- Remember N lines in history
opt.maxmempattern=10000
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 700        -- ms to wait for trigger an event
opt.timeoutlen=400

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append "sI"

-- Disable builtins plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

