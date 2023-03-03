local G = require('G')
local M = {}

function M.config()
    G.g.mkdp_browser = 'C:/Users/JKevin/scoop/apps/googlechrome/current/chrome.exe'
    G.g.mkdp_page_title = '${name}'
    G.g.vmt_fence_text = 'markdown-toc'
end

function M.setup()
    -- do nothing
end

return M
