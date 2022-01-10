-- Neovim config
vim.opt.completeopt = "menuone,noselect"

-- Completion
-- Source plugin (nvim-compe, folder name is 'completion')
vim.opt.runtimepath = vim.opt.runtimepath + '~/.local/share/nvim/plugins/completion'
vim.opt.runtimepath = vim.opt.runtimepath + '~/.local/share/nvim/plugins/completion/after'

-- LSP
-- Source plugin
vim.opt.runtimepath = vim.opt.runtimepath + '~/.local/share/nvim/plugins/lsp'
local nvim_lsp   = require("lspconfig")

require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'always',
    max_abbr_width = 80,
    max_kind_width = 80,
    max_menu_width = 80,
    documentation    = {
        border = 'rounded', -- the border option is the same as `|help nvim_open_win|`
        winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
        max_width = 60,
        min_width = 30,
        max_height = math.floor(vim.o.lines * 0.3),
        min_height = 1,
    },
    source = {
        path     = true,
        buffer   = true,
        calc     = true,
        nvim_lsp = true,
        nvim_lua = true,
    },
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    print('comp')
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


-- LSP config

-- On attach
local on_attach = function(client, bufnr)
    print('Attached!')
end

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Snippet support
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Resolve support
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

nvim_lsp.tsserver.setup {
    on_attach =  on_attach,
    capabilities = capabilities,
}
