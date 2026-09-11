repeat task.wait() until game:IsLoaded()

-- =================================================================
-- 1. PREVENÇÃO DE DUPLICIDADE & SEGURANÇA
-- =================================================================
if getgenv().AkailHubUltimateLoaded then return end
getgenv().AkailHubUltimateLoaded = true

-- =================================================================
-- 2. SERVIÇOS & CONFIGURAÇÕES GLOBAIS
-- =================================================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

getgenv().Config = {
    AutoFarm = false,
    Weapon = "Melee", -- "Melee", "Sword", "Blox Fruit"
    FastAttack = true,
    FastAttackSpeed = 0.0004,
    BringMob = true,
    AutoHaki = true,
    AutoRejoin = true,
    AntiLag = true,
    AutoEliteHunter = false,
    AutoBossFarm = false,
    AutoSeaBeast = false,
    AutoTerrorShark = false,
    AutoRaid = false,
    AutoBone = false,
    AutoRandomFruit = false,
    AutoStoreFruit = false,
    AutoCollectFruits = false,
    ESPPlayer = false,
    ESPBoss = false,
    ESPFruit = false,
    ESPChest = false,
    AutoStatsMelee = false,
    AutoStatsDefense = false,
    AutoStatsFruit = false,
    AutoStatsGun = false,
    StatsPoints = 3
}

local PlaceId = game.PlaceId
local World1, World2, World3 = false, false, false
if PlaceId == 2753915549 or PlaceId == 85211729168715 then World1 = true
elseif PlaceId == 4442272183 or PlaceId == 79091703265657 then World2 = true
elseif PlaceId == 7449423635 or PlaceId == 100117331123089 then World3 = true end

-- Anti-AFK Avançado
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.zero, workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.zero, workspace.CurrentCamera.CFrame)
end)

-- Auto Reconnect em Erros de Conexão
if CoreGui:FindFirstChild("RobloxPromptGui") then
    CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
        if getgenv().Config.AutoRejoin and child.Name == "ErrorPrompt" then
            TeleportService:Teleport(PlaceId, LocalPlayer)
        end
    end)
end

-- Anti-Lag / Otimização Visual
if getgenv().Config.AntiLag then
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        settings().Rendering.QualityLevel = 1
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(LocalPlayer.Character) then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy()
            end
        end
    end)
end

-- Noclip Dinâmico para Navegação Fluida
RunService.Stepped:Connect(function()
    local activeMoving = getgenv().Config.AutoFarm or getgenv().Config.AutoEliteHunter or getgenv().Config.AutoBossFarm or getgenv().Config.AutoSeaBeast or getgenv().Config.AutoRaid
    if activeMoving and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- =================================================================
-- 3. INTERFACE GRÁFICA (UI PREMIUM REDESENHADA)
-- =================================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AkailHubUltimate_UI"
ScreenGui.ResetOnSpawn = false

pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 52, 0, 52)
ToggleBtn.Position = UDim2.new(0.015, 0, 0.15, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
ToggleBtn.Text = "MAX"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
ToggleBtn.TextSize = 12
ToggleBtn.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
ToggleBtn.Parent = ScreenGui

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(0, 14)
UICornerBtn.Parent = ToggleBtn

local UIBorderBtn = Instance.new("UIStroke")
UIBorderBtn.Color = Color3.fromRGB(0, 255, 128)
UIBorderBtn.Thickness = 2
UIBorderBtn.Parent = ToggleBtn

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 440, 0, 320)
MainFrame.Position = UDim2.new(0.5, -220, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 12)
UICornerMain.Parent = MainFrame

local UIBorderMain = Instance.new("UIStroke")
UIBorderMain.Color = Color3.fromRGB(45, 45, 60)
UIBorderMain.Thickness = 1.5
UIBorderMain.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 38)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Title.Text = "   ⚡ AKAIL HUB ULTIMATE — NÍVEL 2800+"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 11
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Title.Parent = MainFrame

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 12)
UICornerTitle.Parent = Title

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0, 120, 1, -48)
TabBar.Position = UDim2.new(0, 8, 0, 42)
TabBar.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
TabBar.Parent = MainFrame

local UICornerTabBar = Instance.new("UICorner")
UICornerTabBar.CornerRadius = UDim.new(0, 8)
UICornerTabBar.Parent = TabBar

local TabList = Instance.new("UIListLayout")
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Padding = UDim.new(0, 5)
TabList.Parent = TabBar

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -138, 1, -48)
ContentFrame.Position = UDim2.new(0, 132, 0, 42)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local Pages = {}

local function CreatePage(pageName)
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, 400)
    scroll.ScrollBarThickness = 2
    scroll.Visible = false
    scroll.Parent = ContentFrame
    local layout = Instance.new("UIListLayout")
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    layout.Parent = scroll
    Pages[pageName] = scroll
    return scroll
end

local function CreateTabButton(tabName, pageTarget)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0.92, 0, 0, 28)
    tabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    tabBtn.Text = tabName
    tabBtn.TextColor3 = Color3.fromRGB(160, 160, 180)
    tabBtn.TextSize = 10
    tabBtn.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
    tabBtn.Parent = TabBar
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = tabBtn

    tabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(TabBar:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
                b.TextColor3 = Color3.fromRGB(160, 160, 180)
            end
        end
        pageTarget.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
        tabBtn.TextColor3 = Color3.fromRGB(10, 10, 14)
    end)
end

local function AddToggleToPage(page, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.96, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    btn.Text = "  " .. text
    btn.TextColor3 = Color3.fromRGB(225, 225, 235)
    btn.TextSize = 10
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
    btn.Parent = page
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 10, 0, 10)
    indicator.Position = UDim2.new(0.9, -8, 0.5, -5)
    indicator.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    indicator.Parent = btn
    local indCorner = Instance.new("UICorner")
    indCorner.CornerRadius = UDim.new(1, 0)
    indCorner.Parent = indicator

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        indicator.BackgroundColor3 = state and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(50, 50, 65)
        callback(state)
    end)
end

local PageFarm = CreatePage("Farm")
local PageCombat = CreatePage("Combat")
local PageSea = CreatePage("Sea")
local PageESP = CreatePage("ESP")
local PageFruits = CreatePage("Fruits")
local PageStats = CreatePage("Stats")

CreateTabButton("Farm Level", PageFarm)
CreateTabButton("Combate/Boss", PageCombat)
CreateTabButton("Sea & Eventos", PageSea)
CreateTabButton("ESP Visual", PageESP)
CreateTabButton("Frutas", PageFruits)
CreateTabButton("Status", PageStats)
PageFarm.Visible = true

AddToggleToPage(PageFarm, "Auto Farm Level", function(v) getgenv().Config.AutoFarm = v end)
AddToggleToPage(PageFarm, "Fast Attack Power", function(v) getgenv().Config.FastAttack = v end)
AddToggleToPage(PageFarm, "Bring Mobs Pro Max", function(v) getgenv().Config.BringMob = v end)
AddToggleToPage(PageFarm, "Auto Haki Armamento", function(v) getgenv().Config.AutoHaki = v end)

AddToggleToPage(PageCombat, "Auto Elite Hunter", function(v) getgenv().Config.AutoEliteHunter = v end)
AddToggleToPage(PageCombat, "Auto Boss Farm", function(v) getgenv().Config.AutoBossFarm = v end)
AddToggleToPage(PageCombat, "Auto Raid (Dungeon)", function(v) getgenv().Config.AutoRaid = v end)

AddToggleToPage(PageSea, "Auto Sea Beast", function(v) getgenv().Config.AutoSeaBeast = v end)
AddToggleToPage(PageSea, "Auto Terror Shark", function(v) getgenv().Config.AutoTerrorShark = v end)
AddToggleToPage(PageSea, "Auto Bones (Hallow)", function(v) getgenv().Config.AutoBone = v end)

AddToggleToPage(PageESP, "ESP Players", function(v) getgenv().Config.ESPPlayer = v end)
AddToggleToPage(PageESP, "ESP Bosses", function(v) getgenv().Config.ESPBoss = v end)
AddToggleToPage(PageESP, "ESP Frutas", function(v) getgenv().Config.ESPFruit = v end)
AddToggleToPage(PageESP, "ESP Baús", function(v) getgenv().Config.ESPChest = v end)

AddToggleToPage(PageFruits, "Auto Random Fruit", function(v) getgenv().Config.AutoRandomFruit = v end)
AddToggleToPage(PageFruits, "Auto Store Fruit", function(v) getgenv().Config.AutoStoreFruit = v end)
AddToggleToPage(PageFruits, "Coletar Frutas Chão", function(v) getgenv().Config.AutoCollectFruits = v end)

AddToggleToPage(PageStats, "Auto Points Melee", function(v) getgenv().Config.AutoStatsMelee = v end)
AddToggleToPage(PageStats, "Auto Points Defense", function(v) getgenv().Config.AutoStatsDefense = v end)
AddToggleToPage(PageStats, "Auto Points Fruit", function(v) getgenv().Config.AutoStatsFruit = v end)
AddToggleToPage(PageStats, "Auto Points Gun", function(v) getgenv().Config.AutoStatsGun = v end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- =================================================================
-- 4. MOVIMENTAÇÃO POR PIVÔ & TWEEN OTIMIZADO
-- =================================================================
local PartPivot = Instance.new("Part")
PartPivot.Size = Vector3.new(1, 1, 1)
PartPivot.Name = "Akail_Ultimate_Pivot"
PartPivot.Anchored = true
PartPivot.CanCollide = false
PartPivot.Transparency = 1
PartPivot.Parent = workspace

task.spawn(function()
    while task.wait() do
        pcall(function()
            local active = getgenv().Config.AutoFarm or getgenv().Config.AutoEliteHunter or getgenv().Config.AutoBossFarm or getgenv().Config.AutoBone or getgenv().Config.AutoRaid or getgenv().Config.AutoCollectFruits
            if active and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local root = LocalPlayer.Character.HumanoidRootPart
                if (root.Position - PartPivot.Position).Magnitude <= 350 then
                    root.CFrame = PartPivot.CFrame
                else
                    PartPivot.CFrame = root.CFrame
                end
            elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                PartPivot.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        end)
    end
end)

local currentTween = nil
local function ToTarget(TargetCFrame)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local root = LocalPlayer.Character.HumanoidRootPart
        local dist = (TargetCFrame.Position - root.Position).Magnitude
        local speed = dist > 2500 and 650 or 380
        
        if currentTween then currentTween:Cancel() end
        local duration = math.max(dist / speed, 0.05)
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        currentTween = TweenService:Create(PartPivot, tweenInfo, {CFrame = TargetCFrame})
        currentTween:Play()
    end
end

-- =================================================================
-- 5. SUPORTE A HAKI, BRING MOBS & FAST ATTACK
-- =================================================================
local function CheckHaki()
    if not getgenv().Config.AutoHaki then return end
    pcall(function()
        local char = LocalPlayer.Character
        if char and not char:FindFirstChild("HasBuso") then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
        end
    end)
end

local function BringMobsPro(MobName, TargetCFrame)
    if not getgenv().Config.BringMob or not workspace:FindFirstChild("Enemies") then return end
    pcall(function()
        for _, enemy in pairs(workspace.Enemies:GetChildren()) do
            if (enemy.Name == MobName or MobName == "All") and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") then
                if enemy.Humanoid.Health > 0 and (enemy.HumanoidRootPart.Position - TargetCFrame).Magnitude <= 450 then
                    enemy.HumanoidRootPart.CFrame = CFrame.new(TargetCFrame)
                    enemy.HumanoidRootPart.CanCollide = false
                    enemy.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    pcall(function()
                        enemy.Humanoid.WalkSpeed = 0
                        enemy.Humanoid.JumpPower = 0
                    end)
                end
            end
        end
    end)
end

task.spawn(function()
    while task.wait(getgenv().Config.FastAttackSpeed) do
        local activeCombat = getgenv().Config.AutoFarm or getgenv().Config.AutoEliteHunter or getgenv().Config.AutoBossFarm or getgenv().Config.AutoRaid
        if activeCombat and getgenv().Config.FastAttack then
            pcall(function()
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            end)
        end
    end
end)

local function AutoEquip()
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("Humanoid") then return end
        local eq = char:FindFirstChildOfClass("Tool")
        if eq and (eq.ToolTip == getgenv().Config.Weapon or eq.Name:find(getgenv().Config.Weapon)) then return end
        local bp = LocalPlayer:FindFirstChild("Backpack")
        if bp then
            for _, item in pairs(bp:GetChildren()) do
                if item:IsA("Tool") and (item.ToolTip == getgenv().Config.Weapon or item.Name:find(getgenv().Config.Weapon)) then
                    char.Humanoid:EquipTool(item)
                    break
                end
            end
        end
    end)
end

-- =================================================================
-- 6. ESP VISUAL SYSTEM (PLAYERS, BOSSES, FRUITS, CHESTS)
-- =================================================================
local function CreateESP(obj, textName, color)
    if obj:FindFirstChild("Akail_ESP") then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "Akail_ESP"
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = textName
    label.TextColor3 = color
    label.TextSize = 11
    label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    label.TextStrokeTransparency = 0.2
    label.Parent = billboard
    billboard.Parent = obj
end

task.spawn(function()
    while task.wait(1.5) do
        pcall(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    if getgenv().Config.ESPPlayer then
                        CreateESP(p.Character.HumanoidRootPart, p.Name, Color3.fromRGB(255, 60, 60))
                    elseif p.Character.HumanoidRootPart:FindFirstChild("Akail_ESP") then
                        p.Character.HumanoidRootPart.Akail_ESP:Destroy()
                    end
                end
            end
            
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                    if getgenv().Config.ESPBoss and v.Humanoid.MaxHealth > 5000 and not Players:GetPlayerFromCharacter(v) then
                        CreateESP(v.HumanoidRootPart, "👑 " .. v.Name, Color3.fromRGB(255, 215, 0))
                    end
                elseif v:IsA("Tool") and v.Name:find("Fruit") and v:FindFirstChild("Handle") then
                    if getgenv().Config.ESPFruit then
                        CreateESP(v.Handle, "🍎 " .. v.Name, Color3.fromRGB(0, 255, 128))
                    end
                elseif v:IsA("Part") and (v.Name:find("Chest") or v.Name:find("Treasure")) then
                    if getgenv().Config.ESPChest then
                        CreateESP(v, "📦 Chest", Color3.fromRGB(0, 160, 255))
                    end
                end
            end
        end)
    end
end)

-- =================================================================
-- 7. BANCO DE QUESTS (NÍVEL 2800+)
-- =================================================================
local function GetQuestData()
    if not LocalPlayer:FindFirstChild("Data") or not LocalPlayer.Data:FindFirstChild("Level") then return nil end
    local level = LocalPlayer.Data.Level.Value

    if World3 then
        if level >= 2000 and level <= 2024 then return { QuestName = "HauntedQuest1", QuestLevel = 1, MobName = "Reborn Skeleton", QuestCFrame = CFrame.new(-9479, 142, 5566), MobCFrame = CFrame.new(-8797, 142, 6027) }
        elseif level >= 2025 and level <= 2049 then return { QuestName = "HauntedQuest1", QuestLevel = 2, MobName = "Living Zombie", QuestCFrame = CFrame.new(-9479, 142, 5566), MobCFrame = CFrame.new(-10134, 140, 5930) }
        elseif level >= 2050 and level <= 2074 then return { QuestName = "HauntedQuest2", QuestLevel = 1, MobName = "Demonic Soul", QuestCFrame = CFrame.new(-9516, 172, 6078), MobCFrame = CFrame.new(-9506, 172, 6139) }
        elseif level >= 2075 and level <= 2099 then return { QuestName = "NutsIslandQuest", QuestLevel = 1, MobName = "Peanut Scout", QuestCFrame = CFrame.new(-2104, 38, -10194), MobCFrame = CFrame.new(-2143, 47, -10029) }
        elseif level >= 2100 and level <= 2124 then return { QuestName = "NutsIslandQuest", QuestLevel = 2, MobName = "Peanut President", QuestCFrame = CFrame.new(-2104, 38, -10194), MobCFrame = CFrame.new(-2215, 159, -10474) }
        elseif level >= 2125 and level <= 2149 then return { QuestName = "IceCreamIslandQuest", QuestLevel = 1, MobName = "Ice Cream Chef", QuestCFrame = CFrame.new(-820, 65, -10965), MobCFrame = CFrame.new(-877, 118, -11032) }
        elseif level >= 2150 and level <= 2199 then return { QuestName = "IceCreamIslandQuest", QuestLevel = 2, MobName = "Ice Cream Commander", QuestCFrame = CFrame.new(-820, 65, -10965), MobCFrame = CFrame.new(-800, 150, -11250) }
        elseif level >= 2200 and level <= 2224 then return { QuestName = "CakeQuest1", QuestLevel = 1, MobName = "Cookie Crafter", QuestCFrame = CFrame.new(-2020, 37, -12025), MobCFrame = CFrame.new(-2350, 38, -12100) }
        elseif level >= 2225 and level <= 2249 then return { QuestName = "CakeQuest1", QuestLevel = 2, MobName = "Cake Guard", QuestCFrame = CFrame.new(-2020, 37, -12025), MobCFrame = CFrame.new(-1580, 38, -12350) }
        elseif level >= 2250 and level <= 2299 then return { QuestName = "CakeQuest2", QuestLevel = 1, MobName = "Baking Staff", QuestCFrame = CFrame.new(-1925, 37, -12850), MobCFrame = CFrame.new(-1850, 38, -13000) }
        elseif level >= 2300 and level <= 2324 then return { QuestName = "CakeQuest2", QuestLevel = 2, MobName = "Head Baker", QuestCFrame = CFrame.new(-1925, 37, -12850), MobCFrame = CFrame.new(-2100, 38, -13150) }
        elseif level >= 2325 and level <= 2374 then return { QuestName = "ChocQuest1", QuestLevel = 1, MobName = "Cocoa Warrior", QuestCFrame = CFrame.new(230, 24, -12200), MobCFrame = CFrame.new(350, 25, -12350) }
        elseif level >= 2375 and level <= 2399 then return { QuestName = "ChocQuest1", QuestLevel = 2, MobName = "Chocolate Bar Battler", QuestCFrame = CFrame.new(230, 24, -12200), MobCFrame = CFrame.new(150, 25, -12600) }
        elseif level >= 2400 and level <= 2449 then return { QuestName = "CandyQuest1", QuestLevel = 1, MobName = "Candy Rebel", QuestCFrame = CFrame.new(-1150, 14, -14450), MobCFrame = CFrame.new(-1300, 15, -14300) }
        elseif level >= 2450 and level <= 3000 then return { QuestName = "CandyQuest1", QuestLevel = 2, MobName = "Candy Pirate", QuestCFrame = CFrame.new(-1150, 14, -14450), MobCFrame = CFrame.new(-1350, 15, -14700) }
        end
    end
    return nil
end

-- =================================================================
-- 8. LOOPS DE AUTOMAÇÃO PRINCIPAIS
-- =================================================================
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().Config.AutoFarm then
            pcall(function()
                CheckHaki()
                local quest = GetQuestData()
                if quest then
                    local mainGui = LocalPlayer.PlayerGui:FindFirstChild("Main")
                    local hasQuest = mainGui and mainGui:FindFirstChild("Quest") and mainGui.Quest.Visible
                    
                    if not hasQuest then
                        ToTarget(quest.QuestCFrame)
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            if (LocalPlayer.Character.HumanoidRootPart.Position - quest.QuestCFrame.Position).Magnitude <= 18 then
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", quest.QuestName, quest.QuestLevel)
                                task.wait(0.8)
                            end
                        end
                    else
                        ToTarget(quest.MobCFrame * CFrame.new(0, 25, 0))
                        AutoEquip()
                        BringMobsPro(quest.MobName, quest.MobCFrame.Position)
                    end
                end
            end)
        elseif getgenv().Config.AutoEliteHunter and World3 then
            pcall(function()
                CheckHaki()
                ToTarget(CFrame.new(-5863, 15, -738))
                ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter")
                
                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    if (enemy.Name:find("Diablo") or enemy.Name:find("Deandre") or enemy.Name:find("Urban")) and enemy:FindFirstChild("HumanoidRootPart") then
                        ToTarget(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0))
                        AutoEquip()
                    end
                end
            end)
        end
    end
end)

-- Coleta de Frutas e Status Secundários
task.spawn(function()
    while task.wait(3) do
        pcall(function()
            if getgenv().Config.AutoCollectFruits then
                for _, item in pairs(workspace:GetChildren()) do
                    if item:IsA("Tool") and item.Name:find("Fruit") and item:FindFirstChild("Handle") then
                        ToTarget(item.Handle.CFrame)
                    end
                end
            end
            if getgenv().Config.AutoRandomFruit then ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "Buy") end
            if getgenv().Config.AutoStoreFruit and LocalPlayer:FindFirstChild("Backpack") then
                for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if item:IsA("Tool") and item.Name:find("Fruit") then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", item.Name, item)
                    end
                end
            end
            if getgenv().Config.AutoStatsMelee then ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", getgenv().Config.StatsPoints) end
            if getgenv().Config.AutoStatsDefense then ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Defense", getgenv().Config.StatsPoints) end
            if getgenv().Config.AutoStatsFruit then ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", getgenv().Config.StatsPoints) end
            if getgenv().Config.AutoStatsGun then ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Gun", getgenv().Config.StatsPoints) end
        end)
    end
end)

print("Akail Hub Ultimate (Versão Otimizada) carregado com sucesso!")
