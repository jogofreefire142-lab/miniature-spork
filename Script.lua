local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local ContentProvider = game:GetService("ContentProvider")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

-- Espera o jogo carregar com segurança
if not game:IsLoaded() then 
    game.Loaded:Wait() 
end

-- CONFIGURAÇÕES DO KEY SYSTEM
local GET_LINK = "https://seulinkdekey.com"
local SECRET_KEY = "12345"
local savedKeyFile = "KEYSYSTEM.txt"
local DISCORD_LINK = "https://discord.gg/SXtfYJSPny"

local function saveKey(key)
    if not key then return end
    if writefile then pcall(function() writefile(savedKeyFile, key) end) end
end

local function loadSavedKey()
    if isfile and isfile(savedKeyFile) then
        local ok, res = pcall(function() return readfile(savedKeyFile) end)
        if ok and res then return res end
    end
    return nil
end

local function CoreGuiAdd(gui)
    repeat task.wait() until pcall(function()
        gui.Parent = CoreGui
    end)
end

-- LÓGICA PRINCIPAL DO SCRIPT
local function ExecuteMainScript()
    local LocalPlayer = Players.LocalPlayer
    local Backpack = LocalPlayer:WaitForChild("Backpack")

    local World1, World2, World3 = false, false, false

    if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then
        World1 = true
    elseif game.PlaceId == 4442272183 or game.PlaceId == 79091703265657 then
        World2 = true
    elseif game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then
        World3 = true
    end

    local function EquipWeapon(ToolName)
        if not ToolName then return end
        local tool = LocalPlayer.Backpack:FindFirstChild(ToolName)
        if tool and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:EquipTool(tool)
        end
    end

    -- Limpeza de mapa (Anti-Lag)
    local Rocks = workspace:FindFirstChild("Rocks")
    if Rocks then Rocks:Destroy() end

    pcall(function()
        local d = Lighting:FindFirstChild("LightingLayers")
        if d and d:FindFirstChild("DarkFog") then
            d.DarkFog:Destroy()
        end
        if workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Foam;") then
            workspace._WorldOrigin["Foam;"]:Destroy()
        end
    end)

    -- PartPivot e Noclip (Corrigido Instance.new)
    local PartPivot = Instance.new("Part")
    PartPivot.Size = Vector3.new(1, 1, 1)
    PartPivot.Name = "Rip_Indra"
    PartPivot.Anchored = true
    PartPivot.CanCollide = false
    PartPivot.Transparency = 1
    PartPivot.Parent = workspace

    task.spawn(function()
        repeat task.wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        PartPivot.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
        
        while task.wait() do
            pcall(function()
                if getgenv().OnFarm then
                    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if root and (root.Position - PartPivot.Position).Magnitude <= 200 then
                        root.CFrame = PartPivot.CFrame
                    else
                        PartPivot.CFrame = root.CFrame
                    end
                    for _, v in pairs(LocalPlayer.Character:GetChildren()) do
                        if v:IsA("BasePart") then v.CanCollide = false end
                    end
                else
                    if LocalPlayer.Character then
                        for _, v in pairs(LocalPlayer.Character:GetChildren()) do
                            if v:IsA("BasePart") then v.CanCollide = true end
                        end
                    end
                end
            end)
        end
    end)

    -- Função de Movimentação por Tween
    getgenv()._tp = function(TargetCFrame)
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        
        local distance = (TargetCFrame.Position - char.HumanoidRootPart.Position).Magnitude
        local tweenInfo = TweenInfo.new(distance / 300, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(PartPivot, tweenInfo, { CFrame = TargetCFrame })
        
        tween:Play()
    end

    -- Checagem de Quests
    getgenv().CheckQuest = function()
        if not LocalPlayer:FindFirstChild("Data") or not LocalPlayer.Data:FindFirstChild("Level") then return end
        local MyLevel = LocalPlayer.Data.Level.Value
        if World3 then
            if MyLevel >= 2075 and MyLevel <= 2099 then
                return { Mon = "Peanut Scout", LevelQuest = 1, NameQuest = "NutsIslandQuest", NameMon = "Peanut Scout", CFrameQuest = CFrame.new(-2104.39, 38.10, -10194.21), CFrameMon = CFrame.new(-2143.24, 47.72, -10029.99) }
            elseif MyLevel >= 2100 and MyLevel <= 2124 then
                return { Mon = "Peanut President", LevelQuest = 2, NameQuest = "NutsIslandQuest", NameMon = "Peanut President", CFrameQuest = CFrame.new(-2104.39, 38.10, -10194.21), CFrameMon = CFrame.new(-2215, 159, -10474) }
            elseif MyLevel >= 2125 then
                return { Mon = "Ice Cream Chef", LevelQuest = 1, NameQuest = "IceCreamIslandQuest", NameMon = "Ice Cream Chef", CFrameQuest = CFrame.new(-820, 65, -10965), CFrameMon = CFrame.new(-877, 118, -11032) }
            end
        end
    end
end

-- INTERFACE HOHO HUB (KEY SYSTEM)
local INFO_DOT25_QUAD = TweenInfo.new(.25, Enum.EasingStyle.Quad)

local PreloadID = {
    "rbxassetid://4560909609",
    "rbxassetid://12187376174",
}

local HOHO_Passcheck = Instance.new("ScreenGui")
local INTRO = Instance.new("CanvasGroup")
local Wallpaper = Instance.new("ImageLabel")
local TextHolder = Instance.new("Frame")
local Status = Instance.new("TextLabel")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local Gradient = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local Pattern = Instance.new("ImageLabel")
local Logo = Instance.new("ImageLabel")
local Main = Instance.new("ImageLabel")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local Loader = Instance.new("Frame")
local Content = Instance.new("Frame")
local UIStroke = Instance.new("UIStroke")
local ImageLabel = Instance.new("ImageLabel")
local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
local UICorner = Instance.new("UICorner")
local GET_KEY = Instance.new("CanvasGroup")
local UICorner_1 = Instance.new("UICorner")
local Logo_1 = Instance.new("ImageLabel")
local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
local Get = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local UIStroke_1 = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local Submit = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local UIStroke_2 = Instance.new("UIStroke")
local Title_1 = Instance.new("TextLabel")
local Pfp = Instance.new("ImageLabel")
local UICorner_4 = Instance.new("UICorner")
local Support = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local UIStroke_3 = Instance.new("UIStroke")
local Title_2 = Instance.new("TextLabel")
local Credit = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local Title_3 = Instance.new("TextLabel")
local UIStroke_4 = Instance.new("UIStroke")
local UICorner_6 = Instance.new("UICorner")
local Frame = Instance.new("Frame")
local UIStroke_5 = Instance.new("UIStroke")
local UIGradient_2 = Instance.new("UIGradient")
local UIGradient_3 = Instance.new("UIGradient")
local UICorner_7 = Instance.new("UICorner")
local Frame_1 = Instance.new("TextLabel")
local Frame_2 = Instance.new("TextBox")
local UIStroke_6 = Instance.new("UIStroke")
local UICorner_8 = Instance.new("UICorner")
local UICorner_9 = Instance.new("UICorner")
local Gradient_1 = Instance.new("Frame")
local UIGradient_1 = Instance.new("UIGradient")
local Pattern_1 = Instance.new("ImageLabel")
local Hover = Instance.new("ImageLabel")
local Gradient_Frame = Instance.new("Frame")
local UIGradient_4 = Instance.new("UIGradient")

HOHO_Passcheck.IgnoreGuiInset = true
HOHO_Passcheck.ResetOnSpawn = false
HOHO_Passcheck.Name = "Hоhо_раssсhесk"
HOHO_Passcheck.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
HOHO_Passcheck.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
CoreGuiAdd(HOHO_Passcheck)

INTRO.BorderSizePixel = 0
INTRO.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
INTRO.AnchorPoint = Vector2.new(0.5, 0.5)
INTRO.Size = UDim2.new(0.455271, 0, 0.46186, 0)
INTRO.ZIndex = 990
INTRO.Name = "INTRO"
INTRO.Position = UDim2.new(0.5, 0, 0.5, 0)
INTRO.Parent = HOHO_Passcheck

Hover.ImageColor3 = Color3.fromRGB(255, 51, 51)
Hover.BorderSizePixel = 0
Hover.SliceCenter = Rect.new(205, 197, 828, 828)
Hover.ScaleType = Enum.ScaleType.Slice
Hover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Hover.ImageTransparency = 1
Hover.Position = UDim2.new(0.5, 0, 0.5, 0)
Hover.Name = "Hover"
Hover.AnchorPoint = Vector2.new(0.5, 0.5)
Hover.Image = "rbxassetid://16261022724"
Hover.Size = UDim2.new(1.055, 0, 1.45, 0)
Hover.BackgroundTransparency = 1
Hover.Parent = Get

local Hover_2 = Hover:Clone()
Hover_2.Parent = Submit

Wallpaper.BorderSizePixel = 0
Wallpaper.ScaleType = Enum.ScaleType.Fit
Wallpaper.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Wallpaper.Position = UDim2.new(-0.0361702, 0, -0.158876, 0)
Wallpaper.Name = "Wallpaper"
Wallpaper.Image = "rbxassetid://16073585738"
Wallpaper.Size = UDim2.new(1.11064, 0, 1.59989, 0)
Wallpaper.Parent = INTRO

TextHolder.BorderSizePixel = 0
TextHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TextHolder.Size = UDim2.new(1, 0, 0.284847, 0)
TextHolder.Name = "TextHolder"
TextHolder.Position = UDim2.new(0, 0, 0.753631, 0)
TextHolder.Parent = INTRO

Status.TextWrapped = true
Status.BorderSizePixel = 0
Status.TextScaled = true
Status.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Status.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Italic)
Status.Position = UDim2.new(0.120042, 0, 0.254529, 0)
Status.Name = "Status"
Status.TextSize = 20
Status.Size = UDim2.new(0.79993, 0, 0.464041, 0)
Status.ZIndex = 2
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.Text = "Preparing your HUB for an amazing experience."
Status.BackgroundTransparency = 1
Status.Parent = TextHolder

UITextSizeConstraint.MaxTextSize = 20
UITextSizeConstraint.Parent = Status

Gradient.BorderSizePixel = 0
Gradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Gradient.Size = UDim2.new(1, 0, 1, 0)
Gradient.Name = "Gradient"
Gradient.Position = UDim2.new(0, 0, 0, 0)
Gradient.Parent = TextHolder

UIGradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0.9),
    NumberSequenceKeypoint.new(1, 0.9)
}
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(157, 2, 31)),
    ColorSequenceKeypoint.new(0.466, Color3.fromRGB(139, 6, 31)),
    ColorSequenceKeypoint.new(0.797, Color3.fromRGB(46, 28, 31)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
}
UIGradient.Rotation = -90
UIGradient.Parent = Gradient

Pattern.SliceCenter = Rect.new(0, 256, 0, 256)
Pattern.ScaleType = Enum.ScaleType.Tile
Pattern.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pattern.ImageTransparency = 0.6
Pattern.Name = "Pattern"
Pattern.Image = "rbxassetid://2151741365"
Pattern.TileSize = UDim2.new(0, 250, 0, 250)
Pattern.Size = UDim2.new(1, 0, 1, 0)
Pattern.BackgroundTransparency = 1
Pattern.Parent = Gradient

Logo.ImageColor3 = Color3.fromRGB(0, 0, 0)
Logo.BorderSizePixel = 0
Logo.ScaleType = Enum.ScaleType.Fit
Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Logo.Position = UDim2.new(0.271609, 0, 0.122057, 0)
Logo.Name = "Logo"
Logo.Image = "rbxassetid://16073594682"
Logo.Size = UDim2.new(0.453191, 0, 0.550704, 0)
Logo.ZIndex = 2
Logo.BackgroundTransparency = 1
Logo.Parent = INTRO

Main.BorderSizePixel = 0
Main.ScaleType = Enum.ScaleType.Fit
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Image = "rbxassetid://16073594682"
Main.Size = UDim2.new(0.95, 0, 0.95, 0)
Main.BackgroundTransparency = 1
Main.Parent = Logo

UIAspectRatioConstraint.AspectRatio = 2.08357
UIAspectRatioConstraint.Parent = INTRO

Loader.BorderSizePixel = 0
Loader.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
Loader.Size = UDim2.new(0.999948, 0, 0.0285966, 0)
Loader.Name = "Loader"
Loader.Position = UDim2.new(0, 0, 0.751682, 0)
Loader.ZIndex = 2
Loader.Parent = INTRO

Content.BorderSizePixel = 0
Content.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
Content.Size = UDim2.new(0, 0, 1, 0)
Content.Name = "Content"
Content.Parent = Loader

UIStroke.Transparency = 0.5
UIStroke.Parent = Content

ImageLabel.ImageColor3 = Color3.fromRGB(255, 46, 46)
ImageLabel.BorderSizePixel = 0
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.Position = UDim2.new(1, 0, .5, 0)
ImageLabel.AnchorPoint = Vector2.new(.5, .5)
ImageLabel.Image = "rbxassetid://16073652319"
ImageLabel.Size = UDim2.new(0.671884, 0, 15.1201, 0)
ImageLabel.BackgroundTransparency = 1
ImageLabel.Parent = Content

UIAspectRatioConstraint_1.AspectRatio = 1.49814
UIAspectRatioConstraint_1.Parent = ImageLabel

UICorner.CornerRadius = UDim.new(0, 30)
UICorner.Parent = INTRO

GET_KEY.BorderSizePixel = 0
GET_KEY.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
GET_KEY.AnchorPoint = Vector2.new(0.5, 0.5)
GET_KEY.Size = UDim2.new(0.359117, 0, 0.665296, 0)
GET_KEY.ZIndex = 990
GET_KEY.Name = "GET_KEY"
GET_KEY.Position = UDim2.new(0.5, 0, 0.5, 0)
GET_KEY.Parent = HOHO_Passcheck

UICorner_1.CornerRadius = UDim.new(0.075, 0)
UICorner_1.Parent = GET_KEY

Logo_1.BorderSizePixel = 0
Logo_1.ScaleType = Enum.ScaleType.Fit
Logo_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Logo_1.Position = UDim2.new(0.256362, 0, 0.0700547, 0)
Logo_1.Name = "Logo"
Logo_1.Image = "rbxassetid://16073594682"
Logo_1.Size = UDim2.new(0.481145, 0, 0.133585, 0)
Logo_1.ZIndex = 2
Logo_1.BackgroundTransparency = 1
Logo_1.Parent = GET_KEY

UIAspectRatioConstraint_2.AspectRatio = 1.14096
UIAspectRatioConstraint_2.Parent = GET_KEY

Get.TextWrapped = true
Get.ZIndex = 2
Get.BorderSizePixel = 0
Get.AutoButtonColor = false
Get.TextScaled = true
Get.BackgroundColor3 = Color3.fromRGB(194, 3, 38)
Get.Position = UDim2.new(0.50063, 0, 0.45377, 0)
Get.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Get.Name = "Get"
Get.AnchorPoint = Vector2.new(0.5, 0.5)
Get.Size = UDim2.new(0.838618, 0, 0.095, 0)
Get.TextColor3 = Color3.fromRGB(255, 255, 255)
Get.Text = ""
Get.Parent = GET_KEY

UICorner_2.CornerRadius = UDim.new(0, 7)
UICorner_2.Parent = Get

UIStroke_1.Color = Color3.fromRGB(253, 1, 12)
UIStroke_1.Transparency = 0.5
UIStroke_1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_1.Parent = Get

Title.TextWrapped = true
Title.BorderSizePixel = 0
Title.TextScaled = true
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Title.Position = UDim2.new(0.5, 0, 0.5, 0)
Title.Name = "Title"
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.Size = UDim2.new(1, 0, 0.546077, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "GET KEY"
Title.BackgroundTransparency = 1
Title.Parent = Get

Submit.TextWrapped = true
Submit.ZIndex = 2
Submit.BorderSizePixel = 0
Submit.AutoButtonColor = false
Submit.TextScaled = true
Submit.BackgroundColor3 = Color3.fromRGB(194, 3, 38)
Submit.Position = UDim2.new(0.50063, 0, 0.578448, 0)
Submit.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Submit.Name = "Submit"
Submit.AnchorPoint = Vector2.new(0.5, 0.5)
Submit.Size = UDim2.new(0.838618, 0, 0.095, 0)
Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
Submit.Text = ""
Submit.Parent = GET_KEY

UICorner_3.CornerRadius = UDim.new(0, 7)
UICorner_3.Parent = Submit

UIStroke_2.Color = Color3.fromRGB(253, 1, 12)
UIStroke_2.Transparency = 0.5
UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_2.Parent = Submit

Title_1.TextWrapped = true
Title_1.BorderSizePixel = 0
Title_1.TextScaled = true
Title_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Title_1.Position = UDim2.new(0.5, 0, 0.48, 0)
Title_1.Name = "Title"
Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
Title_1.Size = UDim2.new(1, 0, 0.546, 0)
Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_1.Text = "SUBMIT KEY"
Title_1.BackgroundTransparency = 1
Title_1.Parent = Submit

Pfp.BorderSizePixel = 0
Pfp.ScaleType = Enum.ScaleType.Fit
Pfp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pfp.Position = UDim2.new(0.0810142, 0, 0.652851, 0)
Pfp.Name = "Pfp"
Pfp.Image = "rbxassetid://16165550572"
Pfp.Size = UDim2.new(0.229672, 0, 0.261163, 0)
Pfp.ZIndex = 2
Pfp.BackgroundTransparency = 1
Pfp.Parent = GET_KEY

UICorner_4.CornerRadius = UDim.new(0.075, 0)
UICorner_4.Parent = Pfp

Support.TextWrapped = true
Support.ZIndex = 2
Support.BorderSizePixel = 0
Support.AutoButtonColor = false
Support.TextScaled = true
Support.BackgroundColor3 = Color3.fromRGB(248, 4, 46)
Support.Position = UDim2.new(0.626422, 0, 0.765503, 0)
Support.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Support.Name = "Support"
Support.AnchorPoint = Vector2.new(0.5, 0.5)
Support.Size = UDim2.new(0.58195, 0, 0.0811856, 0)
Support.TextColor3 = Color3.fromRGB(255, 255, 255)
Support.Text = ""
Support.BackgroundTransparency = 1
Support.Parent = GET_KEY

UICorner_5.CornerRadius = UDim.new(0, 7)
UICorner_5.Parent = Support

UIStroke_3.Color = Color3.fromRGB(253, 1, 12)
UIStroke_3.Thickness = 1.25
UIStroke_3.Transparency = 0.25
UIStroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_3.Parent = Support

Title_2.TextWrapped = true
Title_2.BorderSizePixel = 0
Title_2.TextScaled = true
Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
Title_2.Position = UDim2.new(0.5, 0, 0.5, 0)
Title_2.Name = "Title"
Title_2.AnchorPoint = Vector2.new(0.5, 0.5)
Title_2.Size = UDim2.new(1, 0, 0.6, 0)
Title_2.TextColor3 = Color3.fromRGB(100,149,237)
Title_2.Text = "DISCORD"
Title_2.BackgroundTransparency = 1
Title_2.Parent = Support

Credit.TextWrapped = true
Credit.BorderSizePixel = 0
Credit.RichText = true
Credit.TextScaled = true
Credit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Credit.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
Credit.Position = UDim2.new(0.627693, 0, 0.67966, 0)
Credit.Name = "Credit"
Credit.AnchorPoint = Vector2.new(0.5, 0.5)
Credit.Size = UDim2.new(0.584491, 0, 0.0536177, 0)
Credit.ZIndex = 2
Credit.TextColor3 = Color3.fromRGB(255, 255, 255)
Credit.Text = [[<font color="#f8042e">YT</font> @gtvzmodded-7 | <font color="#5d6af2">DISCORD</font> .gg/SXtfYJSPny]]
Credit.BackgroundTransparency = 1
Credit.Parent = GET_KEY

Close.TextWrapped = true
Close.ZIndex = 2
Close.BorderSizePixel = 0
Close.AutoButtonColor = false
Close.TextScaled = true
Close.BackgroundColor3 = Color3.fromRGB(248, 4, 46)
Close.Position = UDim2.new(0.626422, 0, 0.871296, 0)
Close.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Close.Name = "Close"
Close.AnchorPoint = Vector2.new(0.5, 0.5)
Close.Size = UDim2.new(0.582, 0, 0.081, 0)
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.Text = ""
Close.BackgroundTransparency = 1
Close.Parent = GET_KEY

Title_3.TextWrapped = true
Title_3.BorderSizePixel = 0
Title_3.TextScaled = true
Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
Title_3.Position = UDim2.new(0.5, 0, 0.5, 0)
Title_3.Name = "Title"
Title_3.AnchorPoint = Vector2.new(0.5, 0.5)
Title_3.Size = UDim2.new(1, 0, 0.6, 0)
Title_3.TextColor3 = Color3.fromRGB(248, 4, 46)
Title_3.Text = "CLOSE UI"
Title_3.BackgroundTransparency = 1
Title_3.Parent = Close

UIStroke_4.Color = Color3.fromRGB(253, 1, 12)
UIStroke_4.Thickness = 1.25
UIStroke_4.Transparency = 0.25
UIStroke_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_4.Parent = Close

UICorner_6.CornerRadius = UDim.new(0, 7)
UICorner_6.Parent = Close

Frame.BorderSizePixel = 0
Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Size = UDim2.new(0.838618, 0, 0.11308, 0)
Frame.Position = UDim2.new(0.50063, 0, 0.308795, 0)
Frame.ZIndex = 2
Frame.Parent = GET_KEY

UIStroke_5.Color = Color3.fromRGB(255, 255, 255)
UIStroke_5.Thickness = 2
UIStroke_5.Transparency = 0.5
UIStroke_5.Parent = Frame

UIGradient_2.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.9, 0.995),
    NumberSequenceKeypoint.new(1, 1)
}
UIGradient_2.Rotation = -90
UIGradient_2.Color = ColorSequence.new(Color3.fromRGB(248, 4, 46))
UIGradient_2.Parent = UIStroke_5

UICorner_7.CornerRadius = UDim.new(0, 7)
UICorner_7.Parent = Frame

Frame_1.TextWrapped = true
Frame_1.BorderSizePixel = 0
Frame_1.TextScaled = true
Frame_1.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
Frame_1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
Frame_1.Position = UDim2.new(0.265781, 0, 0.485383, 0)
Frame_1.Name = "Title"
Frame_1.AnchorPoint = Vector2.new(0.5, 0.5)
Frame_1.Size = UDim2.new(0.393164, 0, 0.523336, 0)
Frame_1.TextColor3 = Color3.fromRGB(255, 255, 255)
Frame_1.Text = "ENTER KEY HERE"
Frame_1.BackgroundTransparency = 1
Frame_1.TextXAlignment = Enum.TextXAlignment.Left
Frame_1.Parent = Frame

Frame_2.TextWrapped = true
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0.780933, 0, 0.498203, 0)
Frame_2.TextScaled = true
Frame_2.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
Frame_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
Frame_2.PlaceholderText = "..."
Frame_2.Size = UDim2.new(0.302255, 0, 0.600259, 0)
Frame_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Frame_2.Text = ""
Frame_2.Name = "Textbox"
Frame_2.Parent = Frame

UIStroke_6.Color = Color3.fromRGB(248, 4, 46)
UIStroke_6.Thickness = 1.25
UIStroke_6.Transparency = 0.5
UIStroke_6.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_6.Parent = Frame_2

UIGradient_3.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.9, 0.995),
    NumberSequenceKeypoint.new(1, 1)
}
UIGradient_3.Rotation = -90
UIGradient_3.Parent = UIStroke_6

UICorner_8.CornerRadius = UDim.new(0, 7)
UICorner_8.Parent = Frame_2

Gradient_1.BorderSizePixel = 0
Gradient_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Gradient_1.Size = UDim2.new(1, 0, 1, 0)
Gradient_1.Name = "Gradient"
Gradient_1.Position = UDim2.new(0, 0, 0, 0)
Gradient_1.Parent = GET_KEY

UIGradient_1.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0.9),
    NumberSequenceKeypoint.new(1, 0.9)
}
UIGradient_1.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(157, 2, 31)),
    ColorSequenceKeypoint.new(0.468, Color3.fromRGB(46, 28, 31)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
}
UIGradient_1.Rotation = -90
UIGradient_1.Parent = Gradient_1

Pattern_1.SliceCenter = Rect.new(0, 256, 0, 256)
Pattern_1.ScaleType = Enum.ScaleType.Tile
Pattern_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pattern_1.ImageTransparency = 0.6
Pattern_1.Name = "Pattern"
Pattern_1.Image = "rbxassetid://2151741365"
Pattern_1.TileSize = UDim2.new(0, 250, 0, 250)
Pattern_1.Size = UDim2.new(1, 0, 1, 0)
Pattern_1.BackgroundTransparency = 1
Pattern_1.Parent = Gradient_1

Gradient_Frame.BorderSizePixel = 0
Gradient_Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Gradient_Frame.Size = UDim2.new(1, 0, 1, 0)
Gradient_Frame.Name = "Gradient"
Gradient_Frame.Position = UDim2.new(0, 0, 0, 0)
Gradient_Frame.ZIndex = 0
Gradient_Frame.BackgroundTransparency = 1
Gradient_Frame.Parent = Frame

UIGradient_4.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(109, 1, 23)),
    ColorSequenceKeypoint.new(0.531, Color3.fromRGB(39, 18, 22)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(24, 18, 19))
}
UIGradient_4.Rotation = -90
UIGradient_4.Parent = Gradient_Frame

GET_KEY.Visible = false
INTRO.GroupTransparency = 1
GET_KEY.GroupTransparency = 1

-- ANIMAÇÕES E EVENTOS
for _, button in pairs({Get, Submit, Close, Support}) do
    if button == Get or button == Submit then
        button.MouseEnter:Connect(function()
            TweenService:Create(button.Hover, INFO_DOT25_QUAD, {ImageTransparency = 0.25}):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(button.Hover, INFO_DOT25_QUAD, {ImageTransparency = 1}):Play()
        end)
    else
        button.MouseEnter:Connect(function()
            TweenService:Create(button, INFO_DOT25_QUAD, {BackgroundTransparency = 0.1}):Play()
            TweenService:Create(button["Title"], INFO_DOT25_QUAD, {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(button, INFO_DOT25_QUAD, {BackgroundTransparency = 1}):Play()
            TweenService:Create(button["Title"], INFO_DOT25_QUAD, {TextColor3 = Color3.fromRGB(248, 4, 46)}):Play()
        end)
    end
end

-- CARREGAMENTO DE ASSETS (PRELOAD)
local preload_content = {}
for _, v in pairs(HOHO_Passcheck:GetDescendants()) do
    table.insert(preload_content, v)
end
for _, v in pairs(PreloadID) do
    table.insert(preload_content, v)
end

ContentProvider:PreloadAsync(preload_content)

-- ANIMAÇÃO DE ENTRADA
TweenService:Create(INTRO, INFO_DOT25_QUAD, {GroupTransparency = 0}):Play()
task.wait(0.5)

for i = 1, #preload_content do
    local progress = i / #preload_content
    TweenService:Create(Content, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(progress, 0, 1, 0)}):Play()
    task.wait(math.random(1, 3) / 50)
end

TweenService:Create(INTRO, INFO_DOT25_QUAD, {GroupTransparency = 1}):Play()
task.wait(0.5)

GET_KEY.Visible = true
TweenService:Create(GET_KEY, INFO_DOT25_QUAD, {GroupTransparency = 0}):Play()

-- VALIDAÇÃO DA KEY
local function do_check_key(key)
    if key == SECRET_KEY then
        saveKey(key)
        TweenService:Create(GET_KEY, INFO_DOT25_QUAD, {GroupTransparency = 1}):Play()
        task.wait(0.3)
        HOHO_Passcheck:Destroy()
        ExecuteMainScript()
    else
        Frame_2.Text = ""
        Frame_2.PlaceholderText = "Invalid Key!"
        task.wait(1)
        Frame_2.PlaceholderText = "..."
    end
end

Submit.MouseButton1Click:Connect(function()
    do_check_key(Frame_2.Text)
end)

Get.MouseButton1Click:Connect(function()
    if setclipboard then 
        pcall(function() setclipboard(GET_LINK) end) 
    end
end)

Support.MouseButton1Click:Connect(function()
    if setclipboard then 
        pcall(function() setclipboard(DISCORD_LINK) end) 
    end
end)

Close.MouseButton1Click:Connect(function()
    TweenService:Create(GET_KEY, INFO_DOT25_QUAD, {GroupTransparency = 1}):Play()
    task.wait(0.2)
    HOHO_Passcheck:Destroy()
end)

-- VERIFICAÇÃO AUTOMÁTICA DE KEY SALVA
local savedKey = loadSavedKey()
if savedKey and savedKey == SECRET_KEY then
    Frame_2.Text = savedKey
    do_check_key(savedKey)
end
