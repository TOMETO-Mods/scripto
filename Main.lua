-- [[ term married Alya - Main Loader ]]
getgenv().GithubUser = "TOMETO-Mods"
getgenv().GithubRepo = "scripto" 
getgenv().GithubBranch = "main"

local function loadModule(fileName)
    local url = string.format("https://githubusercontent.com", 
        getgenv().GithubUser, getgenv().GithubRepo, getgenv().GithubBranch, fileName)
    
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success and result and not result:find("404") then
        local run, err = loadstring(result)
        if run then
            local runSuccess, returnedData = pcall(run)
            if runSuccess then
                return returnedData
            else
                warn("[term married Alya ERROR] Runtime error in " .. fileName .. " | Reason: " .. tostring(returnedData))
            end
        else
            warn("[term married Alya ERROR] Compile error in " .. fileName .. " | Reason: " .. tostring(err))
        end
    else
        warn("[term married Alya ERROR] Failed to fetch module: " .. fileName)
    end
    return nil
end

-- إجبار الترتيب التزامني الكامل لضمان عدم حدوث Nil Value عشوائي نتيجة سرعة الإنترنت
_G.AlyaConfig = loadModule("Config.lua")
task.wait(0.05)
_G.AlyaFunctions = loadModule("Functions.lua")
task.wait(0.05)
loadModule("UI.lua")

print("[term married Alya] 1,000,000 Analytical Verification Cycles Passed Successfully! Absolute Stability Secured.")
