---@diagnostic disable: undefined-global -- actually fix later

vim.o.number = true
vim.o.relativenumber = false
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.swapfile = false
vim.o.clipboard = "unnamedplus"
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.undofile = true
vim.opt.showmode = false
vim.opt.scrolloff = 3

vim.g.mapleader = " "
vim.g.diagnostics_active = true
vim.cmd([[set termguicolors]])
-- vim.cmd([[set guicursor=a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]])

vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
})

-- local statusline = {
--   ' %t',
--   '%r',
--   '%m',
--   '%=',
--   '%{&filetype}',
--   ' %2p%%',
--   ' %3l:%-2c '
-- }
--
-- vim.o.statusline = table.concat(statusline, '')

require "paq" {
	{"savq/paq-nvim" },
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	{ "stevearc/oil.nvim" },
	{ "ellisonleao/gruvbox.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope.nvim" },
	{ "Saghen/blink.cmp" },
	{ "akinsho/toggleterm.nvim" },
	{ "lewis6991/gitsigns.nvim" },
	{ "windwp/nvim-autopairs" },
	{ "ray-x/lsp_signature.nvim" },
	{ "gelguy/wilder.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "romgrk/barbar.nvim" },
	{ "rmagatti/goto-preview" },
	{ "rmagatti/auto-session" },
	{ "nvim-lualine/lualine.nvim" },
	{ "kylechui/nvim-surround" },
	{ "mfussenegger/nvim-dap" },
	{ "nvim-neotest/nvim-nio" },
	{ "rcarriga/nvim-dap-ui" },
	{ "jay-babu/mason-nvim-dap.nvim" },
	{ "goolord/alpha-nvim" },
}


require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "clangd" },
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({})
        end,
    }
})

require("oil").setup({
	default_file_explorer = true,
	delete_to_trash = true,
	view_options = {
		show_hidden = true,
		natural_order = true,
	}
})

require("gruvbox").setup({
	terminal_colors = true,
	undercurl = true,
	underline = true,
	bold = true,
	italic = {
		strings = false,
		emphasis = true,
		comments = true,
		operators = false,
		folds = true,
	},
	contrast = "hard",
	palette_overrides = {},
})
vim.cmd([[colorscheme gruvbox]])


require("blink.cmp").setup({
	fuzzy = { implementation = "lua" },
	keymap = {
		['<Tab>'] = { 'select_next', 'fallback' },
    	['<S-Tab>'] = { 'select_prev', 'fallback' },
		['<CR>'] = { 'accept', 'fallback' },
	},
})


require("toggleterm").setup({
	insert_mappings = false,
	open_mapping = [[<A-t>]],
	direction = "float",
})

require("gitsigns").setup()

require("nvim-autopairs").setup()

require("lsp_signature").setup({
	hint_prefix = "H - ",
})

require("wilder").setup({modes = {':', '/', '?'}})

require("goto-preview").setup()

require("auto-session").setup({
	suppressed_dirs = {"~/"}
})

require("lualine").setup({
	options = {
		component_separators = {left = "|", right = "|"},
		section_separators = {}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
})

require("nvim-surround").setup()

local dap = require("dap")

dap.configurations.cpp = {
	{
    	name = "Launch file",
    	type = "codelldb",
    	request = "launch",
    	program = function()
      		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    	end,
    	cwd = "${workspaceFolder}",
    	stopOnEntry = false,
  	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require("mason-nvim-dap").setup({
  ensure_installed = { "codelldb" },
  automatic_installation = true,
  handlers = {},
})


local dapui = require("dapui")
dapui.setup()


local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
"												   ",
"												   ",
"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
}
dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":tabnew<CR>"),
    dashboard.button( "s", "  > Sessions", ":AutoSession search<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "c", "  > Config" , ":e $HOME/.config/nvim/init.lua<CR>"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}
alpha.setup(dashboard.opts)
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])


-- ========== KEYMAPS ===========


-- clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function()
        vim.keymap.set("n", "q", "<CMD>bd!<CR>", { buffer = true, desc = "Close Oil" })
    end,
})

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.current_buffer_fuzzy_find, { desc = 'Telescope current buffer fuzzy find' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope keymaps' })
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Telescope document symbols' })
vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope man pages' })
vim.keymap.set('n', '<leader>q', builtin.diagnostics, { desc = 'Telescope diagnostics' })

-- barbar
vim.keymap.set("n", "<C-Right>", ":BufferNext<CR>", { desc = "Move to next buffer" })
vim.keymap.set("n", "<C-Left>", ":BufferPrevious<CR>", { desc = "Move to previous buffer" })
vim.keymap.set("n", "<C-S-Right>", ":BufferMoveNext<CR>", { desc = "Move buffer forwards" })
vim.keymap.set("n", "<C-S-Left>", ":BufferMovePrevious<CR>", { desc = "Move buffer back" })
vim.keymap.set("n", "<C-Q>", ":BufferClose<CR>", { desc = "Close current buffer" })

-- goto-preview
vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})

-- diagnostics
vim.keymap.set("n", "<S-q>", vim.diagnostic.open_float, { desc = "Show diagnostic details" })

-- rename function that i defnitely wrote
vim.keymap.set("n", "<leader>r", function()
local cmdId
cmdId = vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
	callback = function()
	  local key = vim.api.nvim_replace_termcodes("<C-f>", true, false, true)
	  vim.api.nvim_feedkeys(key, "c", false)
	  vim.api.nvim_feedkeys("0", "n", false)
	  cmdId = nil
	  return true
	end,
  })
vim.lsp.buf.rename()
vim.defer_fn(function()
	if cmdId then
	  vim.api.nvim_del_autocmd(cmdId)
	end
  end, 500)
end)

-- debugging
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/Continue Debugging" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })

vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<Leader>B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Set Conditional Breakpoint" })

vim.keymap.set("n", "<Leader>lp", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Set Log Point" })

vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run Last Debug Session" })

vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Toggle DAP UI" })


-- helper for C++ namespaces
local function insert_namespace()
  -- prompt for namespace name
  local namespace = vim.fn.input("Namespace name: ")
  if namespace == "" then return end

  -- get current cursor position
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  -- lines to insert
  local lines = {
    "namespace " .. namespace .. " {",
    "",
    "} // namespace " .. namespace,
  }

  -- insert lines at cursor
  vim.api.nvim_buf_set_lines(0, row, row, false, lines)

  -- move cursor inside namespace block
  vim.api.nvim_win_set_cursor(0, {row + 1, 0})
end

vim.keymap.set("n", "<leader>ns", insert_namespace, { desc = "Insert C++ namespace" })


-- helper for deleting C++ class copy constructor and operator
local function insert_deleted_copy_ops()
  local class_name = vim.fn.input("Class name: ")
  if class_name == "" then return end

  local lines = {
	class_name .. "(const " .. class_name .. "&) = delete;",
	class_name .. "& operator=(const " .. class_name .. "&) = delete;",
  }

  local row = vim.api.nvim_win_get_cursor(0)[1] -- current line
  vim.api.nvim_buf_set_lines(0, row, row, false, lines)
end

vim.keymap.set("n", "<leader>dc", insert_deleted_copy_ops, { noremap = true, silent = true })


