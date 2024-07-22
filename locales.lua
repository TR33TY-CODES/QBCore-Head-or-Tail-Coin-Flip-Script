Locale = {}

function _(str, ...)
    if Config.Locale[str] then
        return string.format(Config.Locale[str], ...)
    else
        return 'Translation [' .. str .. '] does not exist'
    end
end
