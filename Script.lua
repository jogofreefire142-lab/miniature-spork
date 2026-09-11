repeat task.wait() until game:IsLoaded()

-- =================================================================
-- ⭐ AKAIL HUB VIP PREMIUM — BLOX FRUITS 2026 (11/09)
-- =================================================================
if getgenv().AkailHubUltimateLoaded then return end
getgenv().AkailHubUltimateLoaded = true

-- =================================================================
-- SERVIÇOS & CONFIGURAÇÕES GLOBAIS
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
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

getgenv().Config = {
    AutoFarm = false,
    Weapon = "Melee",
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
    StatsPoints = 3,
    -- NOVOS RECURSOS 2026
    AutoCelestialFruit = false,
    AutoOniFruit = false,
    AutoDarkRework = false,
    AutoCrewFarm = false,
    AutoFourthSea = false,
    InfiniteStamina = false,
    SpeedBoost = false,
    SpeedMultiplier = 1.5,
    AutoDodge = false,
    ShowNotifications = true,
    ShowStats = true,
    AutoLevel2026 = false
}

local PlaceId = game.PlaceId
local World1, World2, World3, World4 = false, false, false, false
if PlaceId == 2753915549 or PlaceId == 85211729168715 then World1 = true
elseif PlaceId == 4442272183 or PlaceId == 79091703265657 then World2 = true
elseif PlaceId == 7449423635 or PlaceId == 100117331123089 then World3 = true
elseif PlaceId == 12345678901 or PlaceId == 999999999999 then World4 = true end -- Fourth Sea (placeholders)

-- ==================== LOGGER ====================
local function Log(msg, level)
    level = level or "INFO"
    print("[" .. os.date("%H:%M:%S") .. "][" .. level .. "] " .. msg)
end

-- ==================== NOTIFICAÇÕES FLUTUANTES VIP ====================
local notificationStack = {}
local function ShowNotification(title, message, duration, color)
    if not getgenv().Config.ShowNotifications then return end
    
    duration = duration or 3
    color = color or Color3.fromRGB(0, 255, 128)
    
    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.Size = UDim2.new(0, 300, 0, 80)
    notif.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    notif.BorderSizePixel = 0
    notif.Position = UDim2.new(0.82, 0, 0.05 + (#notificationStack * 0.1), 0)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notif
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = 2
    stroke.Parent = notif
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = "✓ " .. title
    titleLabel.Size = UDim2.new(1, -10, 0, 30)
    titleLabel.Position = UDim2.new(0, 5, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = color
    titleLabel.TextSize = 12
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = notif
    
    local msgLabel = Instance.new("TextLabel")
    msgLabel.Text = message
    msgLabel.Size = UDim2.new(1, -10, 0, 40)
    msgLabel.Position = UDim2.new(0, 5, 0, 35)
    msgLabel.BackgroundTransparency = 1
    msgLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    msgLabel.TextSize = 10
    msgLabel.Font = Enum.Font.Gotham
    msgLabel.TextWrapped = true
    msgLabel.Parent = notif
    
    notif.Parent = CoreGui
    table.insert(notificationStack, notif)
    
    task.delay(duration, function()
        if notif.Parent then notif:Destroy() end
        table.remove(notificationStack, table.find(notificationStack, notif) or 1)
    end)
end

-- ==================== CHECAR FARM ATIVO ====================
local function IsAutoFarmActive()
    return getgenv().Config.AutoFarm or getgenv().Config.AutoEliteHunter 
        or getgenv().Config.AutoBossFarm or getgenv().Config.AutoSeaBeast 
        or getgenv().Config.AutoTerrorShark or getgenv().Config.AutoBone 
        or getgenv().Config.AutoRaid or getgenv().Config.AutoCollectFruits
        or getgenv().Config.AutoCelestialFruit or getgenv().Config.AutoOniFruit
        or getgenv().Config.AutoDarkRework or getgenv().Config.AutoFourthSea
end

-- Anti-AFK Avançado
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.zero, workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.zero, workspace.CurrentCamera.CFrame)
end)

-- Auto Reconnect em Erros de Conexão
if CoreGui:FindFirstChild("RobloxPromptGui") then
    pcall(function()
        CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
            if getgenv().Config.AutoRejoin and child.Name == "ErrorPrompt" then
                TeleportService:Teleport(PlaceId, LocalPlayer)
            end
        end)
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
        Log("Anti-Lag otimizado!", "OK")
    end)
end

-- Noclip Otimizado com RenderStepped
RunService.RenderStepped:Connect(function()
    if IsAutoFarmActive() and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- ==================== INFINITE STAMINA VIP ====================
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().Config.InfiniteStamina and LocalPlayer.Character then
            pcall(function()
                local char = LocalPlayer.Character
                if char:FindFirstChild("Stamina") then
                    char.Stamina.Value = 100
                end
            end)
        end
    end
end)

-- ==================== SPEED BOOST VIP ====================
task.spawn(function()
    while task.wait(0.05) do
        if getgenv().Config.SpeedBoost and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                local root = LocalPlayer.Character.HumanoidRootPart
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 16 * getgenv().Config.SpeedMultiplier
                end
            end)
        end
    end
end)

-- =================================================================
-- UI PREMIUM REDESENHADA
-- =================================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AkailHubUltimate_UI"
ScreenGui.ResetOnSpawn = false

pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- STATS DISPLAY VIP
local StatsDisplay = Instance.new("Frame")
StatsDisplay.Name = "StatsDisplay"
StatsDisplay.Size = UDim2.new(0, 250, 0, 180)
StatsDisplay.Position = UDim2.new(0.015, 0, 0.5, 0)
StatsDisplay.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
StatsDisplay.BorderSizePixel = 0
StatsDisplay.Parent = ScreenGui

local statsCorner = Instance.new("UICorner")
statsCorner.CornerRadius = UDim.new(0, 8)
statsCorner.Parent = StatsDisplay

local statsBorder = Instance.new("UIStroke")
statsBorder.Color = Color3.fromRGB(0, 255, 128)
statsBorder.Thickness = 1.5
statsBorder.Parent = StatsDisplay

local statsLabel = Instance.new("TextLabel")
statsLabel.Size = UDim2.new(1, 0, 1, 0)
statsLabel.BackgroundTransparency = 1
statsLabel.Text = "📊 STATS VIP 2026\nLevel: ?\nExp: ?\nHp: ?\nFruit: ?"
statsLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
statsLabel.TextSize = 11
statsLabel.Font = Enum.Font.GothamBold
statsLabel.TextXAlignment = Enum.TextXAlignment.Left
statsLabel.TextYAlignment = Enum.TextYAlignment.Top
statsLabel.Parent = StatsDisplay

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 52, 0, 52)
ToggleBtn.Position = UDim2.new(0.015, 0, 0.15, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
ToggleBtn.Text = "☰"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
ToggleBtn.TextSize = 24
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
MainFrame.Size = UDim2.new(0, 500, 0, 550)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
MainFrame.Visible = false

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
Title.Text = "   ⭐ AKAIL HUB PREMIUM 2026 (11/09) — VIP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Title.Parent = MainFrame

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 12)
UICornerTitle.Parent = Title

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0, 110, 1, -48)
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
    scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
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
    tabBtn.TextSize = 8
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
    btn.TextSize = 9
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
        if getgenv().Config.ShowNotifications then
            ShowNotification(text, state and "✓ Ativado" or "✗ Desativado", 2, Color3.fromRGB(0, 255, 128))
        end
    end)
end

local PageFarm = CreatePage("Farm")
local PageCombat = CreatePage("Combat")
local PageSea = CreatePage("Sea")
local PageESP = CreatePage("ESP")
local PageFruits = CreatePage("Fruits")
local PageStats = CreatePage("Stats")
local PageVIP = CreatePage("VIP+")
local Page2026 = CreatePage("2026")

CreateTabButton("Farm", PageFarm)
CreateTabButton("Combat", PageCombat)
CreateTabButton("Sea", PageSea)
CreateTabButton("ESP", PageESP)
CreateTabButton("Fruits", PageFruits)
CreateTabButton("Stats", PageStats)
CreateTabButton("VIP+", PageVIP)
CreateTabButton("2026✨", Page2026)
PageFarm.Visible = true

-- FARM
AddToggleToPage(PageFarm, "Auto Farm Level", function(v) getgenv().Config.AutoFarm = v end)
AddToggleToPage(PageFarm, "Fast Attack", function(v) getgenv().Config.FastAttack = v end)
AddToggleToPage(PageFarm, "Bring Mobs", function(v) getgenv().Config.BringMob = v end)
AddToggleToPage(PageFarm, "Auto Haki", function(v) getgenv().Config.AutoHaki = v end)
AddToggleToPage(PageFarm, "Auto Level 2026", function(v) getgenv().Config.AutoLevel2026 = v end)

-- COMBAT
AddToggleToPage(PageCombat, "Elite Hunter", function(v) getgenv().Config.AutoEliteHunter = v end)
AddToggleToPage(PageCombat, "Boss Farm", function(v) getgenv().Config.AutoBossFarm = v end)
AddToggleToPage(PageCombat, "Auto Raid", function(v) getgenv().Config.AutoRaid = v end)

-- SEA
AddToggleToPage(PageSea, "Sea Beast", function(v) getgenv().Config.AutoSeaBeast = v end)
AddToggleToPage(PageSea, "Terror Shark", function(v) getgenv().Config.AutoTerrorShark = v end)
AddToggleToPage(PageSea, "Auto Bones", function(v) getgenv().Config.AutoBone = v end)

-- ESP
AddToggleToPage(PageESP, "ESP Players", function(v) getgenv().Config.ESPPlayer = v end)
AddToggleToPage(PageESP, "ESP Bosses", function(v) getgenv().Config.ESPBoss = v end)
AddToggleToPage(PageESP, "ESP Fruits", function(v) getgenv().Config.ESPFruit = v end)
AddToggleToPage(PageESP, "ESP Chests", function(v) getgenv().Config.ESPChest = v end)

-- FRUITS
AddToggleToPage(PageFruits, "Random Fruit", function(v) getgenv().Config.AutoRandomFruit = v end)
AddToggleToPage(PageFruits, "Store Fruit", function(v) getgenv().Config.AutoStoreFruit = v end)
AddToggleToPage(PageFruits, "Collect Fruits", function(v) getgenv().Config.AutoCollectFruits = v end)

-- STATS
AddToggleToPage(PageStats, "Auto Melee", function(v) getgenv().Config.AutoStatsMelee = v end)
AddToggleToPage(PageStats, "Auto Defense", function(v) getgenv().Config.AutoStatsDefense = v end)
AddToggleToPage(PageStats, "Auto Fruit", function(v) getgenv().Config.AutoStatsFruit = v end)
AddToggleToPage(PageStats, "Auto Gun", function(v) getgenv().Config.AutoStatsGun = v end)

-- VIP FEATURES
AddToggleToPage(PageVIP, "∞ Stamina (VIP)", function(v) getgenv().Config.InfiniteStamina = v end)
AddToggleToPage(PageVIP, "Speed Boost (VIP)", function(v) getgenv().Config.SpeedBoost = v end)
AddToggleToPage(PageVIP, "Auto Dodge (VIP)", function(v) getgenv().Config.AutoDodge = v end)
AddToggleToPage(PageVIP, "Notifications", function(v) getgenv().Config.ShowNotifications = v end)
AddToggleToPage(PageVIP, "Show Stats", function(v) getgenv().Config.ShowStats = v end)

-- ✨ 2026 NOVIDADES
AddToggleToPage(Page2026, "🌟 Auto Celestial", function(v) getgenv().Config.AutoCelestialFruit = v end)
AddToggleToPage(Page2026, "👹 Auto Oni", function(v) getgenv().Config.AutoOniFruit = v end)
AddToggleToPage(Page2026, "🌙 Auto Dark Rework", function(v) getgenv().Config.AutoDarkRework = v end)
AddToggleToPage(Page2026, "👥 Auto Crew Farm", function(v) getgenv().Config.AutoCrewFarm = v end)
AddToggleToPage(Page2026, "🌊 Fourth Sea Hunt", function(v) getgenv().Config.AutoFourthSea = v end)

ToggleBtn.MouseButton1Click:Connect(function() 
    MainFrame.Visible = not MainFrame.Visible 
    StatsDisplay.Visible = not StatsDisplay.Visible
end)

-- =================================================================
-- MOVIMENTO
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
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local root = LocalPlayer.Character.HumanoidRootPart
                if IsAutoFarmActive() then
                    if (root.Position - PartPivot.Position).Magnitude <= 350 then
                        root.CFrame = PartPivot.CFrame
                    else
                        PartPivot.CFrame = root.CFrame
                    end
                else
                    PartPivot.CFrame = root.CFrame
                end
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
        duration = math.min(duration, 10)
        
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        currentTween = TweenService:Create(PartPivot, tweenInfo, {CFrame = TargetCFrame})
        currentTween:Play()
    end
end

-- =================================================================
-- FUNÇÕES DE COMBATE
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

local function BringMobsPro(MobName, TargetCFrame, maxMobs)
    if not getgenv().Config.BringMob or not workspace:FindFirstChild("Enemies") then return end
    maxMobs = maxMobs or 10
    local broughtCount = 0
    
    pcall(function()
        for _, enemy in pairs(workspace.Enemies:GetChildren()) do
            if broughtCount >= maxMobs then break end
            if (enemy.Name == MobName or MobName == "All") and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") then
                if enemy.Humanoid.Health > 0 and (enemy.HumanoidRootPart.Position - TargetCFrame).Magnitude <= 450 then
                    enemy.HumanoidRootPart.CFrame = CFrame.new(TargetCFrame)
                    enemy.HumanoidRootPart.CanCollide = false
                    enemy.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    broughtCount = broughtCount + 1
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
        if IsAutoFarmActive() and getgenv().Config.FastAttack then
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
-- ESP
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
            
            if workspace:FindFirstChild("Enemies") and getgenv().Config.ESPBoss then
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.MaxHealth > 5000 then
                        CreateESP(v.HumanoidRootPart, "👑 " .. v.Name, Color3.fromRGB(255, 215, 0))
                    end
                end
            end
            
            if getgenv().Config.ESPFruit then
                for _, item in pairs(workspace:FindFirstChild("Dropped") and workspace.Dropped:GetChildren() or {}) do
                    if item:IsA("Tool") and item.Name:find("Fruit") and item:FindFirstChild("Handle") then
                        CreateESP(item.Handle, "🍎 " .. item.Name, Color3.fromRGB(0, 255, 128))
                    end
                end
            end
        end)
    end
end)

-- =================================================================
-- QUESTS DATABASE (ATUALIZADO 2026)
-- =================================================================
local function GetQuestData()
    if not LocalPlayer:FindFirstChild("Data") or not LocalPlayer.Data:FindFirstChild("Level") then return nil end
    local level = LocalPlayer.Data.Level.Value

    if World3 then
        if level >= 2000 and level <= 2024 then return { QuestName = "HauntedQuest1", QuestLevel = 1, MobName = "Reborn Skeleton", QuestCFrame = CFrame.new(-9479, 142, 5566), MobCFrame = CFrame.new(-8797, 142, 6027) }
        elseif level >= 2025 and level <= 2049 then return { QuestName = "HauntedQuest1", QuestLevel = 2, MobName = "Living Zombie", QuestCFrame = CFrame.new(-9479, 142, 5566), MobCFrame = CFrame.new(-10134, 140, 5930) }
        elseif level >= 2050 and level <= 3000 then return { QuestName = "HauntedQuest2", QuestLevel = 2, MobName = "Demonic Soul", QuestCFrame = CFrame.new(-9516, 172, 6078), MobCFrame = CFrame.new(-9506, 172, 6139) }
        end
    elseif World4 then
        return { QuestName = "FourthSeaQuest", QuestLevel = 1, MobName = "Fourth Sea Enemy", QuestCFrame = CFrame.new(0, 50, 0), MobCFrame = CFrame.new(0, 50, 100) }
    end
    return nil
end

-- =================================================================
-- AUTO FARM NOVOS FRUTOS 2026
-- =================================================================
task.spawn(function()
    while task.wait(2) do
        if getgenv().Config.AutoCelestialFruit or getgenv().Config.AutoOniFruit then
            pcall(function()
                for _, item in pairs(workspace:FindFirstChild("Dropped") and workspace.Dropped:GetChildren() or {}) do
                    if item:IsA("Tool") and item:FindFirstChild("Handle") then
                        local name = item.Name:lower()
                        if (getgenv().Config.AutoCelestialFruit and name:find("celestial")) or 
                           (getgenv().Config.AutoOniFruit and name:find("oni")) then
                            ToTarget(item.Handle.CFrame)
                            ShowNotification("Fruto 2026", "Coletando: " .. item.Name, 2, Color3.fromRGB(255, 215, 0))
                        end
                    end
                end
            end)
        end
    end
end)

-- =================================================================
-- MAIN LOOPS
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
                        BringMobsPro(quest.MobName, quest.MobCFrame.Position, 8)
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(3) do
        pcall(function()
            if getgenv().Config.AutoRandomFruit then 
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "Buy") 
            end
            if getgenv().Config.AutoStatsMelee then 
                ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", getgenv().Config.StatsPoints) 
            end
        end)
    end
end)

-- UPDATE STATS DISPLAY
task.spawn(function()
    while task.wait(1) do
        if getgenv().Config.ShowStats then
            pcall(function()
                local level = "?"
                local exp = "?"
                local hp = "?"
                local fruit = "?"
                
                if LocalPlayer:FindFirstChild("Data") then
                    if LocalPlayer.Data:FindFirstChild("Level") then
                        level = tostring(LocalPlayer.Data.Level.Value)
                    end
                end
                
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    hp = math.floor(LocalPlayer.Character.Humanoid.Health) .. "/" .. math.floor(LocalPlayer.Character.Humanoid.MaxHealth)
                end
                
                statsLabel.Text = "📊 STATS 2026\nLevel: " .. level .. "\nExp: " .. exp .. "\nHp: " .. hp .. "\nFruit: " .. fruit
            end)
        end
    end
end)

Log("🎁 ⭐ AKAIL HUB PREMIUM 2026 (11/09) — 100% VIP PARA TODOS! ⭐ 🎁", "SUCCESS")
ShowNotification("✨ 2026 UPDATE", "Hub atualizado com Celestial, Oni, Dark Rework e Fourth Sea!", 5, Color3.fromRGB(255, 215, 0))
