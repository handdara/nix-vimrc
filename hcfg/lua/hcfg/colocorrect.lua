local M = {}

function M.correct()
    local function iscolorscheme(x)
        if string.match(vim.g.colors_name, x) then
            return true
        end
        return false
    end
    if vim.iter({"lackluster","delek"}):any(iscolorscheme) then
        vim.cmd [[hi link markdownCode Special]]
    elseif vim.iter({'eva01'}):any(iscolorscheme)  then
        vim.cmd [[hi link markdownCode PreProc]]
    end
end

M.correct()

return M
