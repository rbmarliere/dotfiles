require("neodev").setup()

require("mason").setup({ ui = { border = "rounded" } })
require("mason-lspconfig").setup()

-- override border for floating windows
require("lspconfig.ui.windows").default_options.border = "rounded"
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- global lsp on_attach function
LSPAttach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- default mappings
  vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<C-q>", vim.diagnostic.setloclist, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<Leader>k", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<Leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workLeader_folders()))
  end, opts)
  vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<Leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)

  -- automatically format and organize imports when saving file
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "<buffer>",
    callback = function()
      if client.name == "tsserver" then
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = "",
        }
        vim.lsp.buf.execute_command(params)
      elseif client.supports_method("textDocument/codeAction") then
        local response = client.request_sync("textDocument/codeAction", vim.lsp.util.make_range_params())
        if response and response.result then
          local code_actions = response.result
          if code_actions then
            for _, code_action_object in ipairs(code_actions) do
              if code_action_object.kind == "source.organizeImports" then
                vim.lsp.buf.code_action({
                  context = { only = { "source.organizeImports" } },
                  apply = true,
                })
              end
            end
          end
        end
      end
      vim.lsp.buf.format()
    end,
  })
end

-- autocompletion
local cmp = require("cmp")
cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp_signature_help" },
  }, {
    { name = "path" },
  }, {
    { name = "nvim_lsp" },
  }, {
    { name = "nvim_lua" },
  }, {
    { name = "buffer" },
  })
})
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  })
})

-- global cmp capabilities
LSPCapabilities = require("cmp_nvim_lsp").default_capabilities()

-- setup every lsp installed by mason
-- https://github.com/VonHeikemen/lsp-zero.nvim#you-might-not-need-lsp-zero
local lspconfig = require("lspconfig")
local get_servers = require("mason-lspconfig").get_installed_servers
for _, server_name in ipairs(get_servers()) do
  lspconfig[server_name].setup({
    on_attach = LSPAttach,
    capabilities = LSPCapabilities,
  })
end
