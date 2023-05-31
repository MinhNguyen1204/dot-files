
call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'mhinz/vim-startify'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'voldikss/vim-floaterm' | Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'ryenguyen7411/any-jump.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'JoosepAlviste/nvim-ts-context-commentstring' | Plug 'tpope/vim-commentary'
Plug 'neovim/nvim-lspconfig'
Plug 'f-person/git-blame.nvim' | Plug 'tpope/vim-fugitive' | Plug 'airblade/vim-gitgutter', {'branch': 'master'} | Plug 'axkirillov/easypick.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim' | Plug 'sindrets/diffview.nvim'

call plug#end()

let mapleader = ' '

set mouse +=a

nmap <leader>w :w<CR>
nmap <leader>e :q!<CR>
nmap <leader>k :noa w<CR>



let g:startify_change_to_dir = 0
let g:any_jump_references_enabled = 0

set backspace=indent,eol,start
set noshowmode
set cmdheight=0
set clipboard+=unnamedplus
set whichwrap+=<,>,h,l,[,]
"--Encoding
set encoding=utf-8

set number
set relativenumber
set cursorline
set tabstop=2
set shiftwidth=2
set expandtab
"--Enable hidden buffers
set hidden
"--Status bar
set laststatus=2
set updatetime=100
set autoread
set signcolumn=number
"--Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
" set termguicolors
"--vim faster configs
set lazyredraw
set ttyfast
" set mmp=500000
" set modeline
" set re=2
" set synmaxcol=128
" syntax sync minlines=256
syntax enable

"---Transparent background
au ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
nnoremap <silent> <leader>h :noh<CR>
lua << EOF

-- local actions = require('telescope.actions')
-- local fb_actions = require("telescope").extensions.file_browser.actions
-- local previewers = require('telescope.previewers')
-- local preview_maker = function (filepath, bufnr, opts)
--   local bad_files = function (filepath)
--     local _bad = { 'metadata/.*%.json', 'html2pdf.bundle.min' } -- Put all filetypes that slow you down in this array
--     for _, v in ipairs(_bad) do
--       if filepath:match(v) then
--         return false
--       end
--     end
--     return true
--   end

--   opts = opts or {}
--   if opts.use_ft_detect == nil then opts.use_ft_detect = true end
--   opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
--   previewers.buffer_previewer_maker(filepath, bufnr, opts)
-- end

require("mappings")
require("tokyonight").setup({
  transparent = true,
  on_colors = function(c)
    c.border = c.border_highlight
  end,
  on_highlights = function(hl, c)
    hl.rainbowcol1 = { fg = c.red1 }
    hl.rainbowcol2 = { fg = c.orange }
    hl.rainbowcol3 = { fg = '#e0d60d' }
    hl.rainbowcol4 = { fg = c.teal }
    hl.rainbowcol5 = { fg = '#326bc7' }
    hl.rainbowcol6 = { fg = c.blue1 }
    hl.rainbowcol7 = { fg = c.purple }

    hl['@variable'] = hl['@property']
    hl['@keyword.operator'] = hl['@keyword']
    hl['@constant.builtin'] = hl['@constant']
  end,
})

vim.cmd("colorscheme tokyonight")
local transparents = {
  "Normal",
  "NormalNC",
  "Comment",
  "Constant",
  "Special",
  "Identifier",
  "Statement",
  "PreProc",
  "Type",
  "Underlined",
  "Todo",
  "String",
  "Function",
  "Conditional",
  "Repeat",
  "Operator",
  "Structure",
  "LineNr",
  "NonText",
  "SignColumn",
  "CursorLineNr",
  "EndOfBuffer",

  'NormalFloat',
  'FloatBorder',
  'TelescopeNormal',
  'TelescopeBorder',
  'TelescopeMultiSelection',
}

for _, part in pairs(transparents) do
  vim.cmd('au VimEnter * highlight ' .. part .. ' ctermbg=NONE guibg=NONE')

end

vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#<cr>", {desc="Close all buffers but the current one"})

local treesitter = require("plugins.treesitter")
treesitter.setup()


local telescope = require("plugins.telescope")
telescope.setup()

require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  }
}
-- local lspconfig = require('plugins.lspconfig')
-- lspconfig.setup()

local lualine = require("plugins.lualine")
lualine.setup()

local diffview = require("plugins.diffview")
diffview.setup()
EOF

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>bf <cmd>Telescope buffers<cr>
nnoremap <leader>gf :Easypick changed_files<cr>
nnoremap <leader>gh :Easypick conflicts<cr>
nnoremap <leader>fb :Telescope file_browser path=%:p:h<cr>
"---Any jump---
" Normal mode: Jump to definition under cursor
nnoremap <leader>j :AnyJump<CR>
" Visual mode: jump to selected text in visual mode
xnoremap <leader>j :AnyJumpVisual<CR>
" Normal mode: open previous opened file (after jump)
nnoremap <leader>jj :AnyJumpBack<CR>
" Normal mode: open last closed search window again
nnoremap <leader>al :AnyJumpLastResults<CR>

let g:coc_global_extensions = [
  \ 'coc-ultisnips',
  \ 'coc-emmet',
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-yaml',
  \ 'coc-highlight',
  \ 'coc-eslint',
  \ 'coc-git',
  \ 'coc-prettier',
  \ ]
