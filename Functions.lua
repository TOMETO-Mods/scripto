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
local isFarmLoopActive = false
local isChestLoopActive = false

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

-- حلقة التلفيل التلقائي - حماية قصوى ضد تكرار الـ Threads وهبوط الـ FPS وتجميد اللعبة
Functions.StartFarmLoop = function()
    if isFarmLoopActive then return end
    isFarmLoopActive = true

    if activeThread then
        _G.AlyaConfig.AutoFarm = false
        task.wait(0.05)
        activeThread = nil
    end

    _G.AlyaConfig.AutoFarm = true
    
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
                                
                                -- فحص أمان معزز لحماية موقع اللاعب ومنع الكراش تماماً عند الموت أو إعادة الرسبنة
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
        isFarmLoopActive = false
        activeThread = nil
    end)
end

-- حلقة تجميع الصناديق التلقائي - حماية كاملة ضد أخطاء المراجع المنعدمة أثناء التنقل السريع
Functions.StartChestLoop = function()
    if isChestLoopActive then return end
    isChestLoopActive = true

    if chestThread then
        _G.AlyaConfig.AutoChest = false
        task.wait(0.05)
        chestThread = nil
    end

    _G.AlyaConfig.AutoChest = true

    chestThread = task.spawn(function()
        while _G.AlyaConfig and _G.AlyaConfig.AutoChest do
            task.wait(0.05)
            pcall(function()
                local chestModels = WorkspaceRef:FindFirstChild("ChestModels") or WorkspaceRef
                for _, chest in ipairs(chestModels:GetChildren()) do
                    if chest.Name:lower():find("chest") and chest:FindFirstChild("RootPart") then
                        local character = LocalPlayer.Character
                        if character and character:FindFirstChildOfClass("Humanoid") and character.Humanoid.Health > 0 then
                            local myRoot = character:FindFirstChild("HumanoidRootPart")
                            if myRoot then
                                myRoot.CFrame = chest.RootPart.CFrame * CFrame.new(0, 3, 0)
                                task.wait(0.15)
                                break
                            end
                        end
                    end
                end
            end)
        end
        isChestLoopActive = false
        chestThread = nil
    end)
end

return Functions
