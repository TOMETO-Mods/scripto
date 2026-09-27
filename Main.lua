-- [[ term married Alya - Main Loader ]]
getgenv().GithubUser = "TOMETO-Mods"
getgenv().GithubRepo = "scripto" 
getgenv().GithubBranch = "main"

local function loadModule(fileName)
    -- هذا هو الرابط الصحيح والمعدل لقراءة الملفات من جيثب مباشرة
    local url = string.format("https://githubusercontent.com", 
        getgenv().GithubUser, getgenv().GithubRepo, getgenv().GithubBranch, fileName)
    
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success and result and not result:find("404") then
        local run, err = loadstring(result)
        if run then
            return run()
        else
            warn("[term married Alya ERROR] Compile error in " .. fileName .. " | Reason: " .. tostring(err))
        end
    else
        warn("[term married Alya ERROR] Failed to fetch module: " .. fileName)
    end
    return nil
end

-- استدعاء الوحدات بالترتيب البرمجي الصحيح
_G.AlyaConfig = loadModule("Config.lua")
_G.AlyaFunctions = loadModule("Functions.lua")
loadModule("UI.lua")

print("[term married Alya] All modules loaded and linked to TOMETO-Mods/scripto successfully!")
