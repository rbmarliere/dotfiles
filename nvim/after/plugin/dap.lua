local keymap = {
  d = {
    name = 'Debug',
    R = { '<cmd>lua require("dap").run_to_cursor()<CR>', 'Run to Cursor' },
    E = { '<cmd>lua require("dapui").eval(vim.fn.input "[Expression] > ")<CR>', 'Evaluate Input' },
    C = { '<cmd>lua require("dap").set_breakpoint(vim.fn.input "[Condition] > ")<CR>', 'Conditional Breakpoint' },
    U = { '<cmd>lua require("dapui").toggle()<CR>', 'Toggle UI' },
    b = { '<cmd>lua require("dap").step_back()<CR>', 'Step Back' },
    c = { '<cmd>lua require("dap").continue()<CR>', 'Continue' },
    d = { '<cmd>lua require("dap").disconnect()<CR>', 'Disconnect' },
    e = { '<cmd>lua require("dapui").eval()<CR>', 'Evaluate' },
    g = { '<cmd>lua require("dap").session()<CR>', 'Get Session' },
    h = { '<cmd>lua require("dap.ui.widgets").hover()<CR>', 'Hover Variables' },
    S = { '<cmd>lua require("dap.ui.widgets").scopes()<CR>', 'Scopes' },
    i = { '<cmd>lua require("dap").step_into()<CR>', 'Step Into' },
    o = { '<cmd>lua require("dap").step_over()<CR>', 'Step Over' },
    p = { '<cmd>lua require("dap").pause.toggle()<CR>', 'Pause' },
    q = { '<cmd>lua require("dap").close()<CR>', 'Quit' },
    r = { '<cmd>lua require("dap").repl.toggle()<CR>', 'Toggle Repl' },
    s = { '<cmd>lua require("dap").continue()<CR>', 'Start' },
    t = { '<cmd>lua require("dap").toggle_breakpoint()<CR>', 'Toggle Breakpoint' },
    x = { '<cmd>lua require("dap").terminate()<CR>', 'Terminate' },
    u = { '<cmd>lua require("dap").step_out()<CR>', 'Step Out' },
  },
}

require('which-key').register(keymap, {
  mode = 'n',
  prefix = '<Leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})

local keymap_v = {
  name = 'Debug',
  e = { '<cmd>lua require("dapui").eval()<CR>', 'Evaluate' },
}
require('which-key').register(keymap_v, {
  mode = 'v',
  prefix = '<Leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})

require('dap').adapters.chrome = {
  type = 'executable',
  command = 'node',
  args = { vim.fn.stdpath 'data' .. '/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js' };
}

require('dap').configurations.typescript = {
  {
    type = 'chrome',
    request = 'attach',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    port = 9222,
    webRoot = '${workspaceFolder}',
  },
}

