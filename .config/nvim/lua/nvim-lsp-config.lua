local capabilities = require('cmp_nvim_lsp').default_capabilities()


local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

require'lspconfig'.pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = { pylsp = { plugins = { mccabe = { threshold = 25 } } } }
}

require'lspconfig'.cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require'lspconfig'.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

local project_library_path = "./node_modules"
local cmd = { project_library_path .. "/.bin/ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path, "--logFile", "/home/ricardo/ngserver.log", "--logVerbosity", "verbose"}
require'lspconfig'.angularls.setup{
    on_attach = on_attach,
    cmd = cmd,
    on_new_config = function(new_config,new_root_dir)
        new_config.cmd = cmd
    end,
}

require'lspconfig'.bashls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
