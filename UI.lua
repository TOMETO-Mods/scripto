-- [[ term married Alya - User Interface Module via Orion ]]
local OrionLib = loadstring(game:HttpGet("https://githubusercontent.com"))()

local Window = OrionLib:MakeWindow({
    Name = "term married Alya", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "AlyaHubConfig",
    IntroEnabled = true,
    IntroText = "Welcome to term married Alya",
    IntroIcon = "rbxassetid://4483345998"
})

local TabMain = Window:MakeTab({ Name = "Main Farm", Icon = "rbxassetid://4483345998" })
local TabSub = Window:MakeTab({ Name = "Sub Farm", Icon = "rbxassetid://4483346048" })
local TabSea = Window:MakeTab({ Name = "Sea Event", Icon = "rbxassetid://4483346101" })
local TabESP = Window:MakeTab({ Name = "Visuals (ESP)", Icon = "rbxassetid://4483346175" })
local TabMisc = Window:MakeTab({ Name = "Misc Menu", Icon = "rbxassetid://4483346256" })

-- تبويب Main Farm
local FarmSec = TabMain:AddSection({ Name = "Level Farming" })
FarmSec:AddToggle({
    Name = "Auto Farm Level",
    Default = false,
    Callback = function(Value)
        if _G.AlyaConfig then
            _G.AlyaConfig.AutoFarm = Value
            if Value and _G.AlyaFunctions and _G.AlyaFunctions.StartFarmLoop then
                _G.AlyaFunctions.StartFarmLoop()
            elseif not Value then
                _G.AlyaConfig.AutoFarm = false
            end
        end
    end    
})

FarmSec:AddToggle({
    Name = "Fast Attack",
    Default = true,
    Callback = function(Value)
        if _G.AlyaConfig then _G.AlyaConfig.AutoAttack = Value end
    end    
})

-- تبويب Sub Farm
local SubSec = TabSub:AddSection({ Name = "Chest Grinding" })
SubSec:AddToggle({
    Name = "Auto Farm Chests ( تجميع الصناديق تلقائياً )",
    Default = false,
    Callback = function(Value)
        if _G.AlyaConfig then
            _G.AlyaConfig.AutoChest = Value
            if Value and _G.AlyaFunctions and _G.AlyaFunctions.StartChestLoop then
                _G.AlyaFunctions.StartChestLoop()
            elseif not Value then
                _G.AlyaConfig.AutoChest = false
            end
        end
    end    
})

-- تبويب Sea Event
local SeaSec = TabSea:AddSection({ Name = "Sea Operations" })
SeaSec:AddToggle({
    Name = "Auto Sail ( قيادة القارب تلقائياً )",
    Default = false,
    Callback = function(Value)
        if _G.AlyaConfig then _G.AlyaConfig.AutoSail = Value end
    end    
})

-- تبويب Visuals (ESP)
local ESPSec = TabESP:AddSection({ Name = "Render Settings" })
ESPSec:AddToggle({ Name = "Player ESP", Default = false, Callback = function(v) if _G.AlyaConfig then _G.AlyaConfig.ESPPlayer = v end end })
ESPSec:AddToggle({ Name = "Chest ESP", Default = false, Callback = function(v) if _G.AlyaConfig then _G.AlyaConfig.ESPChest = v end end })
ESPSec:AddToggle({ Name = "Devil Fruit ESP", Default = false, Callback = function(v) if _G.AlyaConfig then _G.AlyaConfig.DevilFruitESP = v end end })

-- تبويب Misc
local MyMiscSec = TabMisc:AddSection({ Name = "Performance & Client" })
MyMiscSec:AddButton({ Name = "Destroy UI", Callback = function() OrionLib:Destroy() end })

OrionLib:Init()
print("[term married Alya] Single-Sycled Perfect Execution Deployed Successfully!")
