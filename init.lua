
vim.o.number = true
vim.o.relativenumber = false
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
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

vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
})


-- vim.cmd([[colorscheme retrobox]])
-- vim.cmd([[highlight Normal guibg=#1E211E
-- 		  highlight LineNr guibg=#1E211E
-- 		  highlight SignColumn guibg=#1E211E
-- 		  highlight FoldColumn guibg=#1E211E
-- 		  highlight CursorLineNr guibg=#1E211E]])


vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/gelguy/wilder.nvim",
	"https://github.com/saghen/blink.cmp",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/romgrk/barbar.nvim",
    "https://github.com/akinsho/toggleterm.nvim",
    "https://github.com/Mofiqul/vscode.nvim",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    "https://github.com/echasnovski/mini.pairs",
    "https://github.com/ray-x/lsp_signature.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
})
vim.cmd([[colorscheme vscode]])

vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("gopls")
vim.lsp.enable("hls")

-- local ts = require("nvim-treesitter")
-- ts.install({ "lua", "c", "cpp", "go" })

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "elixir", "heex", "surface" },
--   callback = function()
--     vim.treesitter.start()
--   end,
-- })

require("wilder").setup({ modes = { ":", "/", "?" } })

require("oil").setup({
	default_file_explorer = true,
	delete_to_trash = true,
	view_options = {
		show_hidden = true,
		natural_order = true,
	}
})

require("mini.pairs").setup()

require("blink.cmp").setup({
	fuzzy = { implementation = "lua" },
	keymap = {
		["<Tab>"] = { "select_next", "fallback" },
    	["<S-Tab>"] = { "select_prev", "fallback" },
		["<CR>"] = { "accept", "fallback" },
	},
    completion = {
        ghost_text = { enabled = false },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
})

require("toggleterm").setup({
	insert_mappings = false,
	open_mapping = [[<A-t>]],
	direction = "float",
})

require("lsp_signature").setup({
    hint_prefix = "H - ",
})

require('lualine').setup({})


-- ========== KEYMAPS ==========

-- misc
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>up", vim.pack.update, { desc = "Update plugins" })
vim.keymap.set("n", "<esc>", "<CMD>noh<CR>")


-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function()
        vim.keymap.set("n", "q", "<CMD>bd!<CR>", { buffer = true, desc = "Close Oil" })
    end,
})


-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.current_buffer_fuzzy_find, { desc = "Telescope current buffer fuzzy find" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope keymaps" })
vim.keymap.set("n", "<M-s>", builtin.lsp_document_symbols, { desc = "Telescope document symbols" })
vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Telescope man pages" })
vim.keymap.set("n", "<leader>q", builtin.diagnostics, { desc = "Telescope diagnostics" })


-- barbar
vim.keymap.set("n", "<C-Right>", ":BufferNext<CR>", { desc = "Move to next buffer" })
vim.keymap.set("n", "<C-Left>", ":BufferPrevious<CR>", { desc = "Move to previous buffer" })
vim.keymap.set("n", "<C-S-Right>", ":BufferMoveNext<CR>", { desc = "Move buffer forwards" })
vim.keymap.set("n", "<C-S-Left>", ":BufferMovePrevious<CR>", { desc = "Move buffer back" })
vim.keymap.set("n", "<C-Q>", ":BufferClose<CR>", { desc = "Close current buffer" })



