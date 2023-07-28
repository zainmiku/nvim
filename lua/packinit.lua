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

        -- wilder 弹出式命令行
        use { 'gelguy/wilder.nvim', event = 'CmdlineEnter', config = 'require("pack/wilder").setup()' }

        -- github copilot
        require('pack/copilot').config()
        use { 'github/copilot.vim', config = "require('pack/copilot').setup()", event = 'InsertEnter' }

        -- 浮动终端
        require('pack/vim-floaterm').config()
        use { 'voldikss/vim-floaterm', config = "require('pack/vim-floaterm').setup()" }

        -- fzf
        require('pack/fzf').config()
        use { 'junegunn/fzf', event = "CmdLineEnter" }
        use { 'junegunn/fzf.vim', config = "require('pack/fzf').setup()", run = 'cd ~/.fzf && ./install --all', after = "fzf" }

        -- tree-sitter
        require('pack/tree-sitter').config()
        use { 'nvim-treesitter/nvim-treesitter', config = "require('pack/tree-sitter').setup()", run = ':TSUpdate', event = 'BufRead' }
        use { 'nvim-treesitter/playground', after = 'nvim-treesitter' }

        -- markdown预览插件 导航生成插件
        require('pack/markdown').config()
        use { 'mzlogin/vim-markdown-toc', ft = 'markdown' }
        use { 'iamcco/markdown-preview.nvim', config = "require('pack/markdown').setup()", run = 'cd app && yarn install', cmd = 'MarkdownPreview', ft = 'markdown' }

        -- 文件管理器
        require('pack/nvim-tree').config()
        use { 'kyazdani42/nvim-web-devicons' }
        use { 'kyazdani42/nvim-tree.lua', config = "require('pack/nvim-tree').setup()", cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle' } }

        -- 状态栏 & 标题栏
        require('pack/nvim-lines').config()
        use { 'yaocccc/nvim-lines.lua', config = "require('pack/nvim-lines').setup()" }

        use { 'jbyuki/venn.nvim', cmd = 'VBox', config = function()
            G.map({ { 'v', '<space>', ':VBox<cr>', { noremap = true, silent = true } } })
        end }

        -- 部分个人自写插件
        require('pack/yaocccc').config()                                               -- yaocccc/* 共用一个config
        use { 'yaocccc/vim-comment', cmd = '*ToggleComment' }                          -- 注释插件
        use { 'yaocccc/vim-echo', cmd = "VECHO" }                                      -- 快速echo、print
        use { 'yaocccc/vim-fcitx2en', event = 'InsertLeavePre' }                       -- 退出输入模式时自动切换到英文
        use { 'yaocccc/nvim-hlchunk', event = { 'CursorMoved', 'CursorMovedI' } }      -- 高亮{}范围
        use { 'yaocccc/vim-surround', event = 'ModeChanged' }                          -- 操作成对的 ""  {}  [] 等的插件
        use { 'yaocccc/nvim-foldsign', event = 'CursorHold', config = 'require("nvim-foldsign").setup()' } -- signcolumn显示折叠信息
        use { 'yaocccc/nvim-hl-mdcodeblock.lua', after = 'nvim-treesitter', config = "require('pack/markdown').setup_hlcodeblock()" }
    end,
    config = {
        git = { clone_timeout = 120, depth = 1 },
        display = {
            working_sym = '[ ]', error_sym = '[✗]', done_sym = '[✓]', removed_sym = ' - ', moved_sym = ' → ', header_sym = '─',
            open_fn = function() return require("packer.util").float({ border = "rounded" }) end
        }
    }
})

if packer_bootstrap then
    require('packer').sync()
end
-- 部分个人自写插件
require('config/yaocccc').config()

require("lazy").setup("plugins")
