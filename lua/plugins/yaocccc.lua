local M = {
    {
        "yaocccc/vim-comment" -- 注释插件
    }, {
    'yaocccc/vim-fcitx2en',   -- 退出输入模式时自动切换到英文
    event = 'InsertLeavePre',
    }, {
        'yaocccc/nvim-hlchunk', -- 高亮{}范围
        event = { 'CursorMoved', 'CursorMovedI' }

    }, {
        'yaocccc/vim-surround', -- 操作成对的 ""  {}  [] 等的插件
        event = 'ModeChanged'
    }, {
        "yaocccc/nvim-hl-mdcodeblock.lua",
        enabled = false,
        ft = 'markdown',
        after = 'nvim-treesitter',
        config = function()
            require('config/markdown').setup_hlcodeblock()
        end

    }
}

return M
