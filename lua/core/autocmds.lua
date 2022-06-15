-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-- Use scrolloff of 1 in quickfix buffer
autocmd('BufEnter', {
  pattern = '*',
  command = "if &ft == 'qf' | set scrolloff=1 | endif"
})
autocmd('BufLeave', {
  pattern = '*',
  command = "if &ft == 'qf' | set scrolloff=3 | endif"
})

-- Put swapfile in local dir when editing a file in /etc
autocmd('BufNewFile,BufReadPre,FileReadPre', {
  pattern = '/etc/*',
  -- TODO: dynamically find the vimdir
  command = "setlocal directory=~/.vim/swap/"
})

-- Helper for dealing with stray swapfiles
autocmd('SwapExists', {
  pattern = '*',
  command = ":let b:swapname = v:swapname"
})

-- Highlight on yank
-- augroup('YankHighlight', { clear = true })
-- autocmd('TextYankPost', {
--   group = 'YankHighlight',
--   callback = function()
--     vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
--   end
-- })

-- Don't auto commenting new lines
-- autocmd('BufEnter', {
--   pattern = '*',
--   command = 'set fo-=c fo-=r fo-=o'
-- })

-- Settings for filetypes:
-- Disable line length marker
-- augroup('setLineLength', { clear = true })
-- autocmd('Filetype', {
--   group = 'setLineLength',
--   pattern = { 'text', 'markdown', 'html', 'xhtml', 'javascript', 'typescript' },
--   command = 'setlocal cc=0'
-- })

-- Set indentation to 2 spaces
-- augroup('setIndent', { clear = true })
-- autocmd('Filetype', {
--   group = 'setIndent',
--   pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
--     'yaml', 'lua'
--   },
--   command = 'setlocal shiftwidth=2 tabstop=2'
-- })

-- Terminal settings:
-- Open a Terminal on the right tab
-- autocmd('CmdlineEnter', {
--   command = 'command! Term :botright vsplit term://$SHELL'
-- })

-- Enter insert mode when switching to terminal
-- autocmd('TermOpen', {
--   command = 'setlocal listchars= nonumber norelativenumber nocursorline',
-- })

-- autocmd('TermOpen', {
--   pattern = '*',
--   command = 'startinsert'
-- })

-- Close terminal buffer on process exit
-- autocmd('BufLeave', {
--   pattern = 'term://*',
--   command = 'stopinsert'
-- })
