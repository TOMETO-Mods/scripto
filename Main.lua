-- [[ term married Alya - Main Loader ]]
getgenv().GithubUser = "TOMETO-Mods"
getgenv().GithubRepo = "scripto" -- تم التحديث لاسم مستودعك الحالي
getgenv().GithubBranch = "main"

local function loadModule(fileName)
    local url = string.format("https://githubusercontent.com", 
        getgenv().GithubUser, getgenv().GithubRepo, getgenv().GithubBranch, fileName)
    
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    
    if not success then
        warn("[term married Alya ERROR] Failed to load module: " .. fileName .. " | Reason: " .. tostring(result))
    end
    return result
end

-- استدعاء الوحدات بالترتيب البرمجي الصحيح
_G.AlyaConfig = loadModule("Config.lua")
_G.AlyaFunctions = loadModule("Functions.lua")
loadModule("UI.lua")

print("[term married Alya] All modules loaded and linked to TOMETO-Mods/scripto successfully!")
