local slow_format_filetypes = {}
require("conform").setup({
	formatters_by_ft = {
		latex = { "latexindent", "bibtex-tidy" },
		lua = { "stylua" },
		makrdown = { "mdformat" },
		python = { "ruff", "black" },
	},

	format_on_save = function(bufnr)
		-- Add ability to disable autoformat.
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end

		-- Automatically detect and run slow formatters async-ly.
		if slow_format_filetypes[vim.bo[bufnr].filetype] then
			return
		end
		local function on_format(err)
			if err and err:match("timeout$") then
				slow_format_filetypes[vim.bo[bufnr].filetype] = true
			end
		end

		return { timeout_ms = 200, lsp_fallback = true }, on_format
	end,

	format_after_save = function(bufnr)
		if not slow_format_filetypes[vim.bo[bufnr].filetype] then
			return
		end
		return { lsp_fallback = true }
	end,
})

-- conform settings for formatting injected languages
require("conform").formatters.injected = {
	-- Set the options field
	options = {
		-- Set individual option values
		ignore_errors = false,
		lang_to_formatters = {},
		lang_to_ext = {
			bash = "sh",
			latex = "tex",
			lua = "lua",
			markdown = "md",
			python = "py",
		},
	},
}

-- conform function setup
vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer.
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function(args)
	if args.bang then
		vim.b.disable_autoformat = false
	else
		vim.g.disable_autoformat = false
		vim.b.disable_autoformat = false
	end
end, {
	desc = "Re-enable autoformat-on-save",
	bang = true,
})
