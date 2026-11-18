
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
vim.opt.scrolloff = 5

vim.g.mapleader = " "
vim.g.diagnostics_active = true

require "paq" {
	{ "savq/paq-nvim" },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "windwp/nvim-autopairs" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope.nvim" },
	{ "gelguy/wilder.nvim" },
	{ "nvim-lualine/lualine.nvim" },
	{ "akinsho/toggleterm.nvim" },
	{ "romgrk/barbar.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "mason-org/mason.nvim" },
	{ "mason-org/mason-lspconfig.nvim" },
	{ "Saghen/blink.cmp", branch = "v1.7.0" },
	{ "rachartier/tiny-inline-diagnostic.nvim" },
	{ "ray-x/lsp_signature.nvim" },
	{ "stevearc/oil.nvim" },
	{ "MeanderingProgrammer/render-markdown.nvim" },
	{ "Mofiqul/vscode.nvim" },
}

-- =========== basic plugins ===========

require("nvim-autopairs").setup()

local wilder = require("wilder")
wilder.setup({modes = {":", "/", "?"}})
wilder.set_option("renderer", wilder.popupmenu_renderer({
	highlighter = wilder.basic_highlighter(),
}))

require("telescope").setup()

require("vscode").setup()
vim.cmd([[set termguicolors]])
vim.cmd([[colorscheme vscode]])

require("lualine").setup({
	options = {
		theme = "vscode",
		section_separators = { left = "", right = "" },
		component_separators = { left = '|', right = '|' },
	},
})

require("oil").setup({
	keymaps = {
		["q"] = "actions.close"
	},
})

require("toggleterm").setup({
	open_mapping = { "<A-t>" },
})

-- =========== language server stuff ============

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "clangd", "ocamllsp" },
	automatic_enable = { "lua_ls", "clangd", "ocamllsp" },
})

vim.lsp.config("lua_ls", {
	settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})

require("blink.cmp").setup({
	keymap = {
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
		["<Enter>"] = { "accept", "fallback" },
	},
})

require("tiny-inline-diagnostic").setup({
	preset = "minimal",
	options = {
		show_code = true,
		multilines = {
			enabled = true,
			always_show = true,
		},
	},
})

require("lsp_signature").setup({
	event = "InsertEnter",
})


-- =========== keymaps ===========

vim.keymap.set("n", "<ESC>", ":noh<CR>", { noremap = true })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("n", "<leader>r", "<CMD>:lua vim.lsp.buf.rename()<CR>")

-- barbar
vim.keymap.set("n", "<A-,>", "<CMD>BufferPrevious<CR>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "<A-.>", "<CMD>BufferNext<CR>", { desc = "Go to next buffer" })
-- vim.keymap.set("n", "<A-<>", "<CMD>BufferMovePrevious<CR>", { desc = "Move the current buffer to the position of the previous buffer" })
-- vim.keymap.set("n", "<A->>", "<CMD>BufferMoveNext<CR>", { desc = "Move the current buffer to the position of the next buffer" })
vim.keymap.set("n", "<A-q>", "<CMD>BufferClose<CR>", { desc = "Close the current buffer" })

-- telescope
vim.keymap.set("n", "<leader>f", "<CMD>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>q", "<CMD>Telescope diagnostics<CR>")



