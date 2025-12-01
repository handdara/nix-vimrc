local function iscolorscheme(x)
    return x==vim.g.colors_name
end
if vim.iter({"lackluster","delek"}):any(iscolorscheme) then
    vim.cmd [[hi link markdownCode Special]]
end
