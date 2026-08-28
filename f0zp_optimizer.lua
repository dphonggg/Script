-- =========================================================
-- 🚀 ROBLOX OPTIMIZER f0zp EDITION
-- Giao diện Neon, tối ưu FPS, không văng
-- Nhấn F10 để mở/tắt menu
-- =========================================================

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- ========== TẠO UI ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "f0zpBooster"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 400)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
MainFrame.Visible = false

-- Viền Neon
local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 0, 1, 0)
Border.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
Border.BackgroundTransparency = 0.5
Border.BorderSizePixel = 0
Border.Parent = MainFrame

-- Tiêu đề
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
TitleBar.BackgroundTransparency = 0.85
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ f0zp BOOSTER ⚡"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -32, 0, 4)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.BackgroundTransparency = 0.8
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar

-- ========== CÁC TOGGLE ==========
local toggles = {
    {Name = "🌙 Tắt bóng đổ", Key = "Shadow"},
    {Name = "💧 Tắt hiệu ứng nước", Key = "Water"},
    {Name = "🔥 Tắt hiệu ứng hạt", Key = "Particle"},
    {Name = "📦 Vật liệu đơn giản", Key = "Material"},
    {Name = "🔄 Giới hạn FPS 60", Key = "FPS"},
}

local toggleStates = {}
local toggleRefs = {}

local function CreateToggle(parent, name, key, yPos)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.9, 0, 0, 30)
    Frame.Position = UDim2.new(0.05, 0, 0, yPos)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Frame.BackgroundTransparency = 0.6
    Frame.BorderSizePixel = 0
    Frame.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(200, 200, 220)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.Parent = Frame

    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 40, 0, 22)
    Toggle.Position = UDim2.new(0.75, 0, 0.1, 0)
    Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    Toggle.Text = "OFF"
    Toggle.TextColor3 = Color3.fromRGB(200, 200, 220)
    Toggle.TextScaled = true
    Toggle.Font = Enum.Font.GothamBold
    Toggle.BorderSizePixel = 0
    Toggle.Parent = Frame

    local State = false
    toggleStates[key] = false
    toggleRefs[key] = Toggle

    Toggle.MouseButton1Click:Connect(function()
        State = not State
        toggleStates[key] = State
        if State then
            Toggle.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
            Toggle.Text = "ON"
        else
            Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            Toggle.Text = "OFF"
        end
        ApplyOptimizations()
    end)
end

for i, v in ipairs(toggles) do
    CreateToggle(MainFrame, v.Name, v.Key, 44 + (i-1)*38)
end

-- ========== HÀM TỐI ƯU ==========
function ApplyOptimizations()
    if toggleStates["Shadow"] then
        Lighting.GlobalShadows = false
        Lighting.FogStart = 999999
        Lighting.FogEnd = 999999
    else
        Lighting.GlobalShadows = true
    end

    pcall(function()
        local Terrain = workspace:FindFirstChildOfClass("Terrain")
        if Terrain and toggleStates["Water"] then
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 1
        end
    end)

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") then
            obj.Enabled = not toggleStates["Particle"]
        end
        if obj:IsA("BasePart") and toggleStates["Material"] then
            obj.Material = Enum.Material.Plastic
            obj.Reflectance = 0
        end
    end

    pcall(function()
        if setfpscap and toggleStates["FPS"] then
            setfpscap(60)
        end
    end)
end

-- ========== KÉO THẢ ==========
local dragging, dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ========== ĐÓNG ==========
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- ========== PHÍM TẮT F10 ==========
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F10 then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- ========== BẬT TẤT CẢ MẶC ĐỊNH ==========
task.wait(0.5)
for _, v in ipairs(toggles) do
    toggleStates[v.Key] = true
    toggleRefs[v.Key].BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    toggleRefs[v.Key].Text = "ON"
end
ApplyOptimizations()

print("✅ f0zp Booster đã sẵn sàng! Nhấn F10 để mở menu.")
