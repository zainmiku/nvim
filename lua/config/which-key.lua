local G = require('G')
local M = {}

function M.config()
    -- do nothing
end

function M.setup()
    local wk = require("which-key")

    wk.register({
    }, {
        prefix = "<leader>",
        mode = "x"
    });
end

return M
