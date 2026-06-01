local select_one_or_multi = function(prompt_bufnr)
	local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
	local multi = picker:get_multi_selection()
	if not vim.tbl_isempty(multi) then
		require("telescope.actions").close(prompt_bufnr)
		for _, j in pairs(multi) do
			if j.path ~= nil then
				vim.cmd(string.format("%s %s", "edit", j.path))
			end
		end
	else
		require("telescope.actions").select_default(prompt_bufnr)
	end
end

local mm = {
	["<CR>"] = select_one_or_multi,
}

require("telescope").setup({
	defaults = {
		initial_mode = "insert",
		mappings = {
			i = mm,
			n = mm,
		},
	},
	pickers = {
		buffers = {
			mappings = {
				i = { ["<C-D>"] = require("telescope.actions").delete_buffer },
				n = { ["<C-D>"] = require("telescope.actions").delete_buffer },
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		file_browser = {
			initial_mode = "insert",
			hijack_netrw = true,
			mappings = {
				["i"] = mm,
				["n"] = mm,
			},
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")

-- Keymap.
local builtin = require("telescope.builtin")
local bufmap = function(keys, func)
	vim.keymap.set("n", keys, func, {})
end

bufmap("<leader>ff", builtin.find_files)
bufmap("<leader>fg", builtin.live_grep)
bufmap("<leader>fb", builtin.buffers)
bufmap("<leader>fh", builtin.help_tags)
bufmap("<leader>fs", require("telescope").extensions.file_browser.file_browser)
