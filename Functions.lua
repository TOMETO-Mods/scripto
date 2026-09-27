here-- [[ term married Alya - Core Functions Module ]]
local Functions = {}
local Workspace = cloneref(game:GetService("Workspace"))
local Players = cloneref(game:GetService("Players"))
local LocalPlayer = Players.LocalPlayer

-- التحقق من جاهزية الأعداء والوحوش في السيرفر
Functions.IsReady = function(target)
    if not target or not target.Parent or not target:IsDescendantOf(Workspace) then
        return false
    end
    local humanoid = target:FindFirstChildOfClass("Humanoid")
    local rootPart = target:FindFirstChild("HumanoidRootPart") or target.PrimaryPart
    if humanoid and humanoid.Health > 0 and rootPart then
        return true
    end
    return false
end

-- ميزة التلفيل التلقائي وضرب الوحوش
Functions.StartFarmLoop = function()
    task.spawn(function()
        while _G.AlyaConfig and _G.AlyaConfig.AutoFarm do
            task.wait(0.1)
            pcall(function()
                local enemies = Workspace:FindFirstChild("Enemies")
                if enemies then
                    for _, enemy in ipairs(enemies:GetChildren()) do
                        if Functions.IsReady(enemy) then
                            local character = LocalPlayer.Character
                            local myRoot = character and character:FindFirstChild("HumanoidRootPart")
                            local enemyRoot = enemy:FindFirstChild("HumanoidRootPart") or enemy.PrimaryPart
                            
                            if myRoot and enemyRoot then
                                -- الانتقال الآني فوق الوحش مباشرة للتلفيل الذكي
                                myRoot.CFrame = enemyRoot.CFrame * CFrame.new(0, 15, 0)
                                
                                -- الهجوم السريع والتلقائي (Fast Attack)
                                if _G.AlyaConfig.AutoAttack then
                                    local tool = character:FindFirstChildOfClass("Tool")
                                    if tool and tool:FindFirstChild("LeftClickRemote") then
                                        tool.LeftClickRemote:FireServer()
                                    end
                                end
                                break
                            end
                        end
                    end
                end
            end)
        end
    end)
end

return Functions
