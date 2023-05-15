

local common_key_setup = function()

local builtin = require('telescope.builtin')
local keymap = vim.keymap
keymap.set('n', '<leader>ff', builtin.find_files, {})
keymap.set('n', '<leader>fg', builtin.live_grep, {})
keymap.set('n', '<leader>fb', builtin.buffers, {})
keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- use jk to enter normal mode
keymap.set({ "i", "v", "c" }, "<leader>jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- bufferline 左右Tab切换
keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>")
keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

keymap.set("i", "<C-h>", "<Left>", { silent = true })
keymap.set("i", "<C-j>", "<Down>", { silent = true })
keymap.set("i", "<C-k>", "<Up>", { silent = true })
keymap.set("i", "<C-l>", "<Right>", { silent = true })

keymap.set("i", "<C-b>", "<PageUp>", { silent = true })
keymap.set("i", "<C-f>", "PageDown>", { silent = true })

-- window management
keymap.set("n", "<C-k>", "<c-w>k") -- focus the top window
keymap.set("n", "<C-j>", "<c-w>j") -- focus the bottom window
keymap.set("n", "<C-h>", "<c-w>h") -- focus the left window
keymap.set("n", "<C-l>", "<c-w>l") -- focus the right window

-- tab manager
keymap.set("n", "<S-Up>", ":resize -2<CR>", { silent = true })
keymap.set("n", "<S-Down>", ":resize +2<CR>", { silent = true })
keymap.set("n", "<S-Left>", ":vertical resize -2<CR>", { silent = true })
keymap.set("n", "<S-Right>", ":vertical resize +2<CR>", { silent = true })
keymap.set("t", "<S-Up>", "<cmd>:resize +2<CR>", { silent = true })
keymap.set("t", "<S-Down>", "<cmd>:resize -2<CR>", { silent = true })

keymap.set({ "n", "i", "v" }, "<c-s>", "<cmd>w<CR>")

-- terminal
keymap.set("t", "<ESC>", "<c-\\><c-n>")

-- 快速在buffer间跳转
vim.api.nvim_set_keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })

end


local which_key_common_map_register = function()

local status_ok, which_key = pcall(require, "which-key")
 -- 搜索(telescope)
function _G.grep_string_the_file()
  require("telescope.builtin").grep_string({
    grep_open_files = true,
  })
end

function _G.live_grep_the_file()
  require("telescope.builtin").live_grep({
    grep_open_files = true,
  })
end

-- terminal begin
local Terminal = require("toggleterm.terminal").Terminal

-- python terminal
local pyterm = Terminal:new({
  cmd = "python3",
  direction = "horizontal",
})

function _G.python_toggle() -- python terminal
  pyterm:toggle()
end

-- common terminal
local cuterm = Terminal:new()
function _G.st_custome_toogle()
  cuterm:toggle()
end

-- float terminal
local float_term = Terminal:new({
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
})

function _G.st_custome_float_term()
  float_term:toggle()
end

local mappings = {
  ["<leader>"] = {
    b = {
      name = "Buffer management",
      c = { ":bdelete %<CR>", "Delete current buffer" },
      p = { "<cmd>BufferLineCyclePrev<CR>", "Move cursor to pre tab" },
      n = { "<cmd>BufferLineCycleNext<CR>", "Move cursor to next tab" },
    },
    c = {
      name = "Code actions",
      S = {
        name = "Aerial Symbols window",
        o = { "<cmd>AerialOpen right<cr>", "Open" },
        c = { "<cmd>AerialClose<cr>", "Close" },
      },
      s = { "<cmd>SymbolsOutline<cr>", "Show code symbols" },
    },
    d = {
      name = "Debug functions",
      w = { "<cmd>lua require('dapui').toggle()<cr>", "Toogle debug window" },
      b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>j", "(<Leader>db)断点" },
      d = {
        "<cmd>lua require('dap').disconnect({ terminateDebuggee = true })<cr><cmd>lua require'dap'.close()<cr>",
        "结束",
      },
      e = { "<cmd>lua require'dapui'.eval()<CR>", "(<Leader>de)查看变量信息" },
      g = {
        "<cmd>lua require'dap'.continue()<CR>",
        "(<Leader>dg)下一个断点",
      },
      i = { "<cmd>lua require'dap'.step_into()<CR>", "(<Leader>di)进入" },
      n = { "<cmd>lua require'dap'.step_over()<CR>", "(<Leader>dn)下一行" },
      o = { "<cmd>lua require'dap'.step_out()<CR>", "(<Leader>do)退出" },
      p = { "<cmd>lua require'dap'.step_back()<CR>", "(<Leader>dp)上一行" },
      r = { "<cmd>lua require'dap'.run_last()<CR>", "(<Leader>dr)重新运行" },
      c = { "<cmd>lua require'dap'.run_to_cursor()<CR>", "(<Leader>rc)运行到当前光标处" },
    },
    e = {
      name = "File explorer",
      e = { ":NvimTreeToggle<cr>", "Show file explorer" },
      f = { ":NvimTreeFindFile<cr>", "Foucus opened file in explorer" },
      s = { "<cmd>w<cr>", "Svae current opened file, same as <c-s>" },
      q = { "<cmd>q<cr>", "Quit current opened file" },
    },
    f = {
      name = "Find",
      f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap = false }, -- additional options for creating the keymap
      s = { "<cmd>lua _G.live_grep_the_file()<cr>", "Find string in current file" },
      S = { "<cmd>Telescope live_grep<cr>", "Find string in workspace" },
      -- C = { "<cmd>Telescope grep_string<cr>", "Find cursor charactor in workspace" },
      -- c = { "<cmd>lua _G.grep_string_the_file()<cr>", "Find cursor charactor in cur file" },
      b = { "<cmd>Telescope buffers<cr>", "Show opened buffers" },
      k = { "<cmd>Telescope keymaps<cr>", "Show all Keymaps" },
      ["1"] = "which_key_ignore", -- special label to hide it in the popup
      -- b = {
      --   function()
      --     print("bar")
      --   end,
      --   "Foobar",
      -- }, -- you can also pass functions!
    },
    g = {
      name = "Git action",
      b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Show current line blame" },
      d = { "<cmd>LazyGitFilterCurrentFile<cr>", "Show current file git history" },
      g = { "<cmd>LazyGitCurrentFile<cr>", "Toggle lazygit view" },
      h = {
        name = "Hunk actions",
        n = { "<cmd>Gitsigns next_hunk<CR>", "Next hunk" },
        p = { "<cmd>Gitsigns prev_hunk<cr>", "Pre hunk" },
        v = { "<cmd>Gitsigns preview_hunk<CR>", "Show hunk preview" },
      },
    },
    l = {
      name = "Develop languages info [lsp treesitter mason]",
      l = {
        name = "Lsp management",
        i = { "<cmd>LspInfo<cr>", "Lsp service info" },
        s = { "<cmd>LspRestart<CR>", "Restart lsp if necessary" },
      },
      m = {
        name = "Mason management",
        t = { "<cmd>Mason<cr>", "Toggle Mason" },
      },
      t = {
        name = "Treesitter management",
        l = { "<cmd>TSInstallInfo<cr>", "Treesitter list supported languages" },
        m = { "<cmd>TSModuleInfo<cr>", "Treesitter show installed info" },
      },
    },
    s = {
      name = "service",
      l = { "<cmd>LiveServer<cr>", "Open / Close live server" },
    },
    t = {
      name = "Terminal",
      p = { "<Cmd>lua _G.python_toggle()<CR>", "Open one python terminal" },
      c = { "<Cmd>lua _G.st_custome_toogle()<CR>", "Open one python terminal" },
      f = { "<cmd>lua _G.st_custome_float_term()<CR>", "Open one float terminal" },
    },
    w = {
      name = "window management",
      a = { "<cmd>lua require'telescope.builtin'.colorscheme()<cr>", "Appearance colorscheme list" },
      b = { "<c-w>v", "Vertically split window" },
      v = { "<c-w>s", "Horizontally split window" },
      d = { "<c-c><cmd>Startup display<cr>", "Show Dashboard" },
      e = { "<c-w>=", "Make split windows equal width & height" },
      c = { "<cmd>close<cr>", "Close current split window" },
      h = { "<C-w><c-h>", "Foucus the left split window" },
      l = { "<C-w><c-l>", "Foucus the right split window" },
      k = { "<C-w><c-k>", "Foucus the top split window" },
      j = { "<C-w><c-j>", "Foucus the bottom split window" },
      o = { "<C-w><c-o>", "Close other split windows" },
      m = { "<cmd>MaximizerToggle<cr>", "Make split window maximization" },
      n = { "<cmd>tabnew %<cr>", "Make current cursor tab to new" },
      q = { "<cmd>FineCmdline<CR>", "Enter cmd mode" },
    },
  },
  {
    prefix = "<leader>",
  },
}


return mappings
end

return {
  common_key_setup = common_key_setup,
which_key_common_map_register = which_key_common_map_register,
}
