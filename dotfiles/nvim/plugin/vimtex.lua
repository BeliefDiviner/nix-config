if vim.loop.os_uname().sysname == "Darwin" then
	vim.g.vimtex_view_general_viewer = "Skim"
elseif vim.loop.os_uname().sysname == "Linux" then
	vim.g.vimtex_view_general_viewer = "SumatraPDF"
	vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
end
