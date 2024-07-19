local nmmap = function(keys, func)
	vim.keymap.set("n", keys, func)
end

local vmmap = function(keys, func)
	vim.keymap.set("v", keys, func)
end

nmmap("<esc>", ":noh<CR>")
nmmap("Y", "y$")
nmmap("<C-c>", ":b#<CR>")
nmmap("<C-x>", ":close<CR>")

-- Save file
nmmap("<C-s>", ":w<CR>")

-- Window movement
nmmap("<C-h>", "<C-w>h")
nmmap("<C-j>", "<C-w>j")
nmmap("<C-k>", "<C-w>k")
nmmap("<C-l>", "<C-w>l")

-- Resize window
nmmap("<C-Up>", ":resize -2<CR>")
nmmap("<C-Down>", ":resize +2<CR>")
nmmap("<C-Left>", ":vertical resize +2<CR>")
nmmap("<C-Right>", ":vertical resize -2<CR>")

-- Move line
nmmap("<M-k>", ":move-2<CR>")
nmmap("<M-j>", ":move+<CR>")

-- Barbar remaps
local barbar = require("barbar.api")
nmmap("<Tab>", function()
	barbar.goto_buffer_relative(1)
end)
nmmap("<S-Tab>", function()
	barbar.goto_buffer_relative(-1)
end)
nmmap("<A-a>", function()
	barbar.move_current_buffer(1)
end)
nmmap("<A-<>", function()
	barbar.move_current_buffer(-1)
end)
nmmap("<leader>x", ":BufferClose<CR>")
nmmap("<leader>p", function()
	barbar.toggle_pin()
end)

-- ToggleTerm remaps
local toggleterm = require("toggleterm")
nmmap("<leader>h", function()
	toggleterm.toggle(nil, nil, nil, "horizontal")
end)
nmmap("<leader>v", function()
	toggleterm.toggle(nil, nil, nil, "vertical")
end)

-- Neotree toggle
nmmap("<C-n>", ":Neotree toggle<CR>")

-- Telescope remaps
local builtin = require("telescope.builtin")
nmmap("<leader>ff", builtin.find_files)
nmmap("<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true<CR>")
nmmap("<leader>b", builtin.buffers)
nmmap("<leader>fh", builtin.help_tags)
nmmap("<leader>gf", builtin.git_files)
nmmap("<leader>fo", builtin.oldfiles)
nmmap("<leader>fg", builtin.live_grep)
nmmap("<leader>fp", builtin.diagnostics)
nmmap("<leader>fz", builtin.current_buffer_fuzzy_find)
nmmap("<leader>cm", builtin.git_commits)
nmmap("<leader>gt", builtin.git_status)
nmmap("<leader>ma", builtin.marks)

-- Format file
nmmap("<leader>fm", require("conform").format)

-- oil.nvim
nmmap("<leader>o", require("oil").open)

-- persistence.nvim
nmmap("<leader>qs", function()
	require("persistence").load()
end)
nmmap("<leader>qS", function()
	require("persistence").select()
end)
nmmap("<leader>ql", function()
	require("persistence").load({ last = true })
end)
nmmap("<leader>qd", function()
	require("persistence").stop()
end)

-- Visual mode move line
vmmap("K", ":m '<-2<CR>gv=gv")
vmmap("J", ":m '>+1<CR>gv=gv")
