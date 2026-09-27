-- [[ term married Alya - Core Functions Module ]]
local Functions = {}
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function safeCloneRef(service)
    return cloneref and cloneref(service) or service
end

local WorkspaceRef = safeCloneRef(Workspace)
local activeThread = nil
local chestThread = nil
local isLoopActive = false

Functions.IsReady = function(target)
    if not target or not target.Parent or not target:IsDescendantOf(WorkspaceRef) then
        return false
    end
    local humanoid = target:FindFirstChildOfClass("Humanoid")
    local rootPart = target:FindFirstChild("HumanoidRootPart") or target.PrimaryPart
    if humanoid and humanoid.Health > 0 and rootPart then
        return true
    end
    return false
end

-- حلقة التلفيل التلقائي المطور
Functions.StartFarmLoop = function()
    if isLoopActive then return end
    isLoopActive = true

    if activeThread then activeThread = nil end
    
    activeThread = task.spawn(function()
        while _G.AlyaConfig and _G.AlyaConfig.AutoFarm do
            task.wait(0.02)
            pcall(function()
                local enemies = WorkspaceRef:FindFirstChild("Enemies")
                if enemies then
                    for _, enemy in ipairs(enemies:GetChildren()) do
                        if Functions.IsReady(enemy) then
                            local character = LocalPlayer.Character
                            if character and character:FindFirstChildOfClass("Humanoid") and character.Humanoid.Health > 0 then
                                local myRoot = character:FindFirstChild("HumanoidRootPart")
                                local enemyRoot = enemy:FindFirstChild("HumanoidRootPart") or enemy.PrimaryPart
                                
                                if myRoot and enemyRoot and enemyRoot:IsA("BasePart") then
                                    myRoot.CFrame = enemyRoot.CFrame * CFrame.new(0, 12, 0)
                                    
                                    if _G.AlyaConfig.AutoAttack then
                                        local tool = character:FindFirstChildOfClass("Tool")
                                        if tool then
                                            tool:Activate()
                                            local remote = tool:FindFirstChild("LeftClickRemote") or tool:FindFirstChildOfClass("RemoteEvent")
                                            if remote and remote:IsA("RemoteEvent") then
                                                remote:FireServer()
                                            end
                                        end
                                    end
                                    break
                                end
                            end
                        end
                    end
                end
            end)
        end
        isLoopActive = false
    end)
end

-- حلقة تجميع الصناديق التلقائي المستخرجة من السورس الخاص بك
Functions.StartChestLoop = function()
    if chestThread then return end
    chestThread = task.spawn(function()
        while _G.AlyaConfig and _G.AlyaConfig.AutoChest do
            task.wait(0.1)
            pcall(function()
                local chestModels = WorkspaceRef:FindFirstChild("ChestModels") or WorkspaceRef
                for _, chest in ipairs(chestModels:GetChildren()) do
                    if chest.Name:lower():find("chest") and chest:FindFirstChild("RootPart") then
                        local character = LocalPlayer.Character
                        local myRoot = character and character:FindFirstChild("HumanoidRootPart")
                        if myRoot and character.Humanoid.Health > 0 then
                            myRoot.CFrame = chest.RootPart.CFrame * CFrame.new(0, 3, 0)
                            task.wait(0.2)
                            break
                        end
                    end
                end
            end)
        end
        chestThread = nil
    end)
end

return Functions
