local G = require('G')
local packer_bootstrap = false
local install_path = G.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local compiled_path = G.fn.stdpath('config')..'/plugin/packer_compiled.lua'
if G.fn.empty(G.fn.glob(install_path)) > 0 then
    print('Installing packer.nvim...')
    G.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    -- G.fn.system({'rm', '-rf', compiled_path})
    G.cmd [[packadd packer.nvim]]
    packer_bootstrap = true
end

require('packer').startup({
    function(use)
        -- packer
        use { 'wbthomason/packer.nvim' }

        -- themes
        use 'folke/tokyonight.nvim'
        use 'Mofiqul/dracula.nvim'
        use { "ellisonleao/gruvbox.nvim" }

        -- coc-nvim
        require('pack/coc').config()
        use { 'neoclide/coc.nvim', config = "require('pack/coc').setup()", branch = 'release' }
 
        -- fzf
        require('pack/fzf').config()
        use { 'junegunn/fzf', event = "CmdLineEnter" }
        use { 'junegunn/fzf.vim', config = "require('pack/fzf').setup()", run = 'cd ~/.fzf && ./install --all', after = "fzf" }

        -- markdown
        require('pack/markdown').config()
        use { 'mzlogin/vim-markdown-toc', ft = 'markdown' }
        use { 'iamcco/markdown-preview.nvim', config = "require('pack/markdown').setup()", run = 'cd app && yarn install', cmd = 'MarkdownPreview', ft = 'markdown' }
 
        -- file system
        require('pack/nvim-tree').config()
        use { 'kyazdani42/nvim-tree.lua', config = "require('pack/nvim-tree').setup()", cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle' } }

        -- markdown
        use {'dhruvasagar/vim-table-mode'}

        -- airline
        use 'vim-airline/vim-airline'


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

