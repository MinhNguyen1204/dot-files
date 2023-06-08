local cmd = vim.cmd
local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})
 cmd('vmap < <gv')
cmd('vmap > >gv')
cmd("vmap J :m '>+1<CR>gv=gvzz'")
cmd("vmap K :m '<-2<CR>gv=gvzz'")
cmd('nnoremap <c-n> :%s///g<left><left>')
cmd('nnoremap <c-m> :%s///gc<left><left><left>')

---Navigation Panel---
cmd('nnoremap <C-h> <C-w>h')
cmd('nnoremap <C-j> <C-w>j')
cmd('nnoremap <C-k> <C-w>k')
cmd('nnoremap <C-l> <C-w>l')
cmd('nnoremap <C-v> <C-w>v')
cmd('nnoremap <C-s> <C-w>s')

---Resize Panel---
cmd('nnoremap <leader>u :vertical resize +10<CR>')
cmd('nnoremap <leader>d :vertical resize -10<CR>')

---Visual mode---
cmd('vmap < <gv')
cmd('vmap > >gv')
cmd("vmap J :m '>+1<CR>gv=gvzz'")
cmd("vmap K :m '<-2<CR>gv=gvzz'")
