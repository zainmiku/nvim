local G = require('G')
local lazypath = G.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not G.loop.fs_stat(lazypath) then
    G.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
G.opt.rtp:prepend(lazypath)
-- vv 快速选中内容插件
require('config/vim-expand-region').config()

-- ff 高亮光标下的word
require('config/vim-interestingwords').config()

-- 多光标插件
require('config/vim-visual-multi').config()

-- 浮动终端
require('config/vim-floaterm').config()

require('config/fzf').config()

require('config/markdown').config()

-- tree-sitter
require('config/tree-sitter').config()

-- 文件管理器
require('config/nvim-tree').config()

-- 状态栏 & 标题栏
require('config/nvim-lines').config()

-- 部分个人自写插件
require('config/yaocccc').config()

require("lazy").setup("plugins")
