-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Plugin: nvim-lspconfig
-- url: https://github.com/neovim/nvim-lspconfig

-- For configuration see the Wiki: https://github.com/neovim/nvim-lspconfig/wiki
-- Autocompletion settings of "nvim-cmp" are defined in plugins/nvim-cmp.lua

local lsp_status_ok, mason = pcall(require, 'mason')
if not lsp_status_ok then
  return
end

local lsp_status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not lsp_status_ok then
  return
end

local lsp_status_ok, neodev = pcall(require, 'neodev')
if not lsp_status_ok then
  return
end

mason.setup()
mason_lspconfig.setup {
  automatic_installation = true,
}

neodev.setup({
  -- add any options here, or leave empty to use the default settings
  -- lspconfig = {
  --   cmd = {"lua-language-server"}
  -- },
  setup_jsonls = false,
})

local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
  return
end

-- Diagnostic options, see: `:help vim.diagnostic.config`
vim.diagnostic.config({ virtual_text = true })

-- Show line diagnostics automatically in hover window
-- TODO: switch to lua API
vim.cmd([[
  autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
]])

-- Add additional capabilities supported by nvim-cmp
-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local capabilities = cmp_nvim_lsp.default_capabilities()

capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Highlighting references
  if client.server_capabilities.document_highlight then
    -- TODO: switch to lua API
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

  vim.keymap.set('n', '<leader>cc', vim.lsp.buf.incoming_calls, opts)
  vim.keymap.set('n', '<leader>cd', vim.lsp.buf.outgoing_calls, opts)

  vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
  vim.api.nvim_buf_create_user_command(bufnr, "Format", vim.lsp.buf.formatting, {})


  -- vim.keymap.set('n', '<leader>e', vim.lsp.diagnostic.show_line_diagnostics, opts)
  -- vim.keymap.set('n', '[d', vim.lsp.diagnostic.goto_prev, opts)
  -- vim.keymap.set('n', ']d', vim.lsp.diagnostic.goto_next, opts)
  -- vim.keymap.set('n', '<leader>q', vim.lsp.diagnostic.set_loclist, opts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, opts)

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

--[[

Language servers setup:

For language servers list see:
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

Bash --> bashls
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls

Python --> pyright
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright

C-C++ --> clangd
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd

HTML/CSS/JSON --> vscode-html-languageserver
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html

JavaScript/TypeScript --> tsserver
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver

--]]

-- Define `root_dir` when needed
-- See: https://github.com/neovim/nvim-lspconfig/issues/320
-- This is a workaround, maybe not work with some servers.
local root_dir = function()
  return vim.fn.getcwd()
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches.
-- Add your language server below:
-- local servers = { 'bashls', }

-- Call setup
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     root_dir = root_dir,
--     capabilities = capabilities,
--     flags = {
--       -- default in neovim 0.7+
--       debounce_text_changes = 150,
--     }
--   }
-- end

-- 2. (optional) Override the default configuration to be applied to all servers.
lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = root_dir,
        flags = {
          -- default in neovim 0.7+
          debounce_text_changes = 150,
        }
    }
)

-- 3. Loop through all of the installed servers and set it up via lspconfig
-- for _, server in ipairs(lsp_installer.get_installed_servers()) do
--   lspconfig[server.name].setup {}
-- end


lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})


local yamlcompanion = require("yaml-companion").setup({
  lspconfig = {
    settings = {
      yaml = {
        editor = {
          -- Enable/disable on type indent and auto formatting array
          formatOnType = true
        }
      }
    }
  }
  -- Add any options here, or leave empty to use the default settings
  -- lspconfig = {
  --   cmd = {"yaml-language-server"}
  -- },
})
lspconfig.yamlls.setup(yamlcompanion)


-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches.
-- Add your language server below:
-- TODO: move pylsp config into scalyr-agent-2 local config
local servers = {
  ccls = {},
  gopls = {},
  bashls = {},
  -- jdtls = {
  --   use_lombok_agent = true,
  -- },
  pylsp = {
    settings = {
      pylsp = {
        -- configurationSources = {'flake8'},
        plugins = {
          autopep8 = {
            enabled = false
          },
          mypy = {
            enabled = true,
            overrides = {
              "--install-types",
              "--non-interactive",
              true,
            }
          },
          rope = {
            enabled = true,
          },
          yapf = {
            enabled = false
          },
          pydocstyle = {
            enabled = false
          },
          pyflakes = {
            enabled = true
          },
          mccable = {
            enabled = true
          },
          pycodestyle = {
            enabled = true,
            ignore = {'W391'},
            maxLineLength = 200,
          },
          pylint = {
            enabled = false,
            executable = "pylint"
          },
          flake8 = {
            enabled = false,
            maxLineLength = 200,
          },
          black = {
            enabled = true,
            line_length = 200,
          },
        }
      }
    }
  }
}

-- Call setup
for lsp, cfg in pairs(servers) do
  lspconfig[lsp].setup(cfg)
end
