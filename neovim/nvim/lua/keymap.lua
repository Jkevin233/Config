local G = require('G')

G.map({
    -- change key
    { 'n', 's',           '<nop>',   {} },
    { 'n', ';',           ':',       {} },
    { 'v', ';',           ':',       {} },
    { 'i', 'jk',          '<esc>',   {} },
    { 'n', 'j',          'gj',       { noremap = true } },
    { 'n', 'k',          'gk',       { noremap = true } },
    { 'n', 'J',          '5j',       { noremap = true } },
    { 'n', 'K',          '5k',       { noremap = true } },

    -- quick use
    { 'n', '<LEADER><CR>',          ':nohlsearch<CR>', {} },


    -- shift wrap
    { 'n', '<leader>w',         "&wrap == 1 ? ':set nowrap<cr>' : ':set wrap<cr>'", { noremap = true, expr = true } },
})

-- 光标在$ 0 ^依次跳转
function MagicMove()
    local first = 1
    local head = #G.fn.getline('.') - #G.fn.substitute(G.fn.getline('.'), '^\\s*', '', 'G') + 1
    local before = G.fn.col('.')
    G.fn.execute(before == first and first ~= head and 'norm! ^' or 'norm! $')
    local after = G.fn.col('.')
    if before == after then
        G.fn.execute('norm! 0')
    end
end

-- 1 当目录不存在时 先创建目录, 2 当前文件是acwrite时, 用sudo保存
function MagicSave()
    if G.fn.empty(G.fn.glob(G.fn.expand('%:p:h'))) then G.fn.system('mkdir -p ' .. G.fn.expand('%:p:h')) end
    if G.o.buftype == 'acwrite' then
        G.fn.execute('w !sudo tee > /dev/null %')
    else
        G.fn.execute('w')
    end
end

-- 驼峰转换 MagicToggleHump(true) 首字母大写 MagicToggleHump(false) 首字母小写
function MagicToggleHump(upperCase)
    G.fn.execute('normal! gv"tx')
    local w = G.fn.getreg('t')
    local toHump = w:find('_') ~= nil
    if toHump then
        w = w:gsub('_(%w)', function(c) return c:upper() end)
    else
        w = w:gsub('(%u)', function(c) return '_' .. c:lower() end)
    end
    if w:sub(1, 1) == '_' then w = w:sub(2) end
    if upperCase then w = w:sub(1,1):upper() .. w:sub(2) end
    G.fn.setreg('t', w)
    G.fn.execute('normal! "tP')
end
