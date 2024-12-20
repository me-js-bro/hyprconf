return {
    {
        "rcarriga/nvim-notify",
        config = function()
            -- Set nvim-notify as the default notification handler
            vim.notify = require("notify")

            -- Optional: Configure nvim-notify
            require("notify").setup({
                stages = "fade_in_slide_out", -- Animation style
                timeout = 3000,               -- Notification timeout in ms
                background_colour = "#000000", -- Background color
                icons = {
                    ERROR = "",
                    WARN = "",
                    INFO = "",
                    DEBUG = "",
                    TRACE = "✎",
                },
            })

            -- Example: Test nvim-notify
            -- vim.notify("nvim-notify is installed!", "info", { title = "Success" })
        end,
    }
}
