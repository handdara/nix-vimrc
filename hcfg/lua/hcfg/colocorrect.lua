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
        vim.cmd [[
        hi markdownLinkDelimiter guifg=#7a7a7a
        hi htmlStrike cterm=strikethrough gui=strikethrough
        hi htmlBoldItalic cterm=bold,italic gui=bold,italic
        hi htmlBold cterm=bold gui=bold
        hi htmlUnderline cterm=underline gui=underline
        hi htmlItalic cterm=italic gui=italic
        hi htmlBoldUnderline cterm=bold,underline gui=bold,underline
        hi htmlUnderlineItalic cterm=underline,italic gui=underline,italic
        hi htmlBoldUnderlineItalic cterm=bold,underline,italic gui=bold,underline,italic
        hi link markdownCode PreProc
        hi link markdownItalic htmlItalic
        hi link markdownBoldItalic htmlBoldItalic
        hi link markdownLinkTextDelimiter @markup.link
        ]]
    end
end

M.correct()

return M
