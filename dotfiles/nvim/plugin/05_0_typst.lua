vim.pack.add({
    {
        src = "https://github.com/chomosuke/typst-preview.nvim",
        version = vim.version.range("1.*"),
    },
})

require("typst-preview").setup({
    invert_colors = "auto",
    follow_cursor = false,
    dependencies_bin = { -- Use binaries already in path.
        tinymist = "tinymist",
        websocat = "websocat",
    },
})

-- TypstPreview keymap
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typst",
    group = vim.api.nvim_create_augroup("TypstPreviewKeymap", { clear = true }),
    callback = function(ev)
        vim.keymap.set(
            "n",
            "<localleader>v",
            "<cmd>TypstPreviewSyncCursor<cr>",
            {
                buffer = ev.buf,
                noremap = true,
                silent = true,
                desc = "Typst forward search",
            }
        )
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typst",
    group = "TypstPreviewKeymap",
    callback = function(ev)
        vim.keymap.set("n", "<localleader>p", "<cmd>TypstPreviewToggle<cr>", {
            buffer = ev.buf,
            noremap = true,
            silent = true,
            desc = "TypstPreview toggle",
        })
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typst",
    group = "TypstPreviewKeymap",
    callback = function(ev)
        vim.keymap.set(
            "n",
            "<localleader>f",
            "<cmd>TypstPreviewFollowCursorToggle<cr>",
            {
                buffer = ev.buf,
                noremap = true,
                silent = true,
                desc = "Typst continuous forward search",
            }
        )
    end,
})
