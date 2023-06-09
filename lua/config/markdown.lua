local G = require('G')
local M = {}

function M.config()
    G.g.mkdp_browser = 'wyeb'
    G.g.mkdp_markdown_css = '~/.config/nvim/colors/markdown.css'
    G.g.mkdp_page_title = '${name}'
    G.g.mkdp_preview_options = { hide_yaml_meta = 1, disable_filename = 1 }
    G.g.mkdp_theme = 'dark'
    G.g.vmt_fence_text = 'markdown-toc'
end

function M.setup()
    -- do nothing
end

function M.setup_hlcodeblock()
    G.hi({ ["MDCodeBlock"] = { bg = 234 }, })
    require('hl-mdcodeblock').setup({
        minumum_len = 80,
    })
        minumum_len = function() return math.max(math.floor(G.api.nvim_win_get_width(0) * 0.8), 100) end })
end

return M
