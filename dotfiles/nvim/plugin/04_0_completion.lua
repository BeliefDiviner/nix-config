vim.pack.add({
    {
        src = "ghh://saghen/blink.cmp",
        version = vim.version.range("1.*"), -- Version 2.* is in beta.
    },
    "ghh://saghen/blink.compat",
    "ghh://micangl/cmp-vimtex",
})

require("blink.cmp").setup({
    keymap = {
        preset = "enter",

        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "accept", "fallback" },

        ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-j>"] = { "select_next", "fallback_to_mappings" },

        ["<C-b>"] = {
            function(cmp)
                return cmp.select_prev({ count = 4 })
            end,
            "fallback_to_mappings",
        },
        ["<C-f>"] = {
            function(cmp)
                return cmp.select_next({ count = 4 })
            end,
            "fallback_to_mappings",
        },

        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },

    completion = {
        documentation = { auto_show = true },
        menu = { auto_show = true },
        list = {
            selection = { preselect = true, auto_insert = false },
            cycle = { from_top = true },
        },
    },

    cmdline = {
        keymap = {
            preset = "inherit",
            ["<CR>"] = false,
            ["<Tab>"] = { "show", "accept", "fallback" },
        },
        completion = {
            menu = { auto_show = false },
            list = {
                selection = { preselect = true, auto_insert = false },
            },
        },
    },

    appearance = { nerd_font_variant = "mono" },

    sources = {
        default = { "lsp", "path", "snippets", "buffer", "vimtex" },
        providers = {
            vimtex = {
                name = "vimtex",
                module = "blink.compat.source",
                score_offset = 1,
            },
        },
    },

    fuzzy = { implementation = "rust" },
})
