-- =========================================================
-- 🔥 ROBLOX OPTIMIZER PRO ULTIMATE – f0zp EDITION (FINAL FIX)
-- 5 tab ngang, 12+ tính năng tối ưu mạnh mẽ
-- Nhấn F10 để mở/tắt menu
-- =========================================================

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ========== BIẾN TOÀN CỤC ==========
local menuVisible = false
local currentTab = 1
local toggles = {}
local tabFrames = {}
local tabButtons = {}

-- ========== TẠO UI ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "f0zpUltimateMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
MainFrame.Visible = false

-- Viền Neon
local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 0, 1, 0)
Border.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
Border.BackgroundTransparency = 0.4
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
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ OPTIMIZER ULTIMATE ⚡"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Nút đóng
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -34, 0, 3)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
CloseBtn.BackgroundTransparency = 0.6
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar

-- ========== TAB BAR NGANG ==========
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 38)
TabBar.Position = UDim2.new(0, 0, 0, 36)
TabBar.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
TabBar.BackgroundTransparency = 0.4
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 2)
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.Parent = TabBar

-- ========== MÀU TAB ==========
local tabColors = {
    Color3.fromRGB(0, 200, 255),
    Color3.fromRGB(255, 150, 0),
    Color3.fromRGB(150, 255, 0),
    Color3.fromRGB(255, 50, 150),
    Color3.fromRGB(200, 100, 255)
}

-- ========== HÀM TẠO TAB ==========
local function CreateTabButton(name, tabIndex, icon)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 85, 1, 0)
    Button.BackgroundColor3 = Color3.fromRGB(25, 25, 42)
    Button.BackgroundTransparency = 0.3
    Button.Text = icon .. " " .. name
    Button.TextColor3 = Color3.fromRGB(180, 180, 200)
    Button.TextScaled = true
    Button.Font = Enum.Font.GothamBold
    Button.BorderSizePixel = 0
    Button.Parent = TabBar
    tabButtons[tabIndex] = Button

    local Content = Instance.new("ScrollingFrame")
    Content.Size = UDim2.new(1, 0, 1, -74)
    Content.Position = UDim2.new(0, 0, 0, 74)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 4
    Content.Visible = (tabIndex == 1)
    Content.Parent = MainFrame
    tabFrames[tabIndex] = Content

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Padding = UDim.new(0, 6)
    ContentLayout.FillDirection = Enum.FillDirection.Vertical
    ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ContentLayout.Parent = Content

    Button.MouseButton1Click:Connect(function()
        for i, frame in pairs(tabFrames) do
            frame.Visible = (i == tabIndex)
        end
        for i, btn in pairs(tabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(25, 25, 42)
            btn.TextColor3 = Color3.fromRGB(180, 180, 200)
        end
        Button.BackgroundColor3 = tabColors[tabIndex]
        Button.BackgroundTransparency = 0.15
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        currentTab = tabIndex
    end)

    if tabIndex == 1 then
        Button.BackgroundColor3 = tabColors[1]
        Button.BackgroundTransparency = 0.15
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

-- ========== ĐỊNH NGHĨA HÀM TỐI ƯU TRƯỚC ==========
function ApplyOptimizations()
    -- Shadow
    Lighting.GlobalShadows = not toggles["Shadow"]
    if toggles["Shadow"] then
        Lighting.FogStart = 999999
        Lighting.FogEnd = 999999
    end

    -- Material
    if toggles["Material"] then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
            end
        end
    end

    -- Mesh Quality
    if toggles["MeshQuality"] then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("MeshPart") then
                obj.RenderFidelity = Enum.RenderFidelity.Automatic
            end
        end
    end

    -- Post Process
    if toggles["PostProcess"] then
        for _, effect in ipairs(Lighting:GetChildren()) do
            if effect:IsA("PostEffect") then
                effect.Enabled = false
            end
        end
    end

    -- Particle
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") then
            obj.Enabled = not toggles["Particle"]
        end
    end

    -- Fire & Smoke
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Fire") or obj:IsA("Smoke") then
            obj.Enabled = not toggles["FireSmoke"]
        end
    end

    -- Water
    pcall(function()
        local Terrain = workspace:FindFirstChildOfClass("Terrain")
        if Terrain then
            if toggles["Water"] then
                Terrain.WaterWaveSize = 0
                Terrain.WaterWaveSpeed = 0
                Terrain.WaterReflectance = 0
                Terrain.WaterTransparency = 1
            else
                Terrain.WaterWaveSize = 4
                Terrain.WaterWaveSpeed = 2
                Terrain.WaterReflectance = 0.5
                Terrain.WaterTransparency = 0.6
            end
        end
    end)

    -- Cull
    if toggles["Cull"] then
        task.spawn(function()
            local Character = LocalPlayer.Character
            if Character and Character:FindFirstChild("HumanoidRootPart") then
                local rootPos = Character.HumanoidRootPart.Position
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and (obj.Position - rootPos).Magnitude > 400 then
                        obj.Transparency = 1
                    end
                end
            end
        end)
    end

    -- Decal
    if toggles["Decal"] then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 1
            end
        end
    end

    -- Terrain
    pcall(function()
        local Terrain = workspace:FindFirstChildOfClass("Terrain")
        if Terrain and toggles["TerrainOpt"] then
            Terrain.Material = Enum.TerrainMaterial.Grass
            Terrain.WaterReflectance = 0
        end
    end)

    -- Mesh Resolution
    if toggles["MeshRes"] then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("MeshPart") then
                obj.RenderFidelity = Enum.RenderFidelity.Automatic
            end
        end
    end

    -- Diffuse
    if toggles["Diffuse"] then
        Lighting.EnvironmentDiffuseScale = 0.1
        Lighting.EnvironmentSpecularScale = 0.1
    else
        Lighting.EnvironmentDiffuseScale = 1
        Lighting.EnvironmentSpecularScale = 1
    end

    -- Lights
    if toggles["Lights"] then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                obj.Enabled = false
            end
        end
    end

    -- Fog
    if toggles["Fog"] then
        Lighting.FogStart = 999999
        Lighting.FogEnd = 999999
    end

    -- CPU Load
    if toggles["CPULoad"] then
        task.spawn(function()
            while toggles["CPULoad"] do
                task.wait(5)
                collectgarbage()
            end
        end)
    end

    -- Memory Clean
    if toggles["MemoryClean"] then
        collectgarbage()
    end

    -- Animation Off
    if toggles["AnimOff"] then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Animation") then
                obj:Stop()
            end
        end
    end
end

-- ========== HÀM TẠO TOGGLE (ĐÃ SỬA LỖI) ==========
local function CreateToggle(parent, name, key, color)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.92, 0, 0, 38)
    Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
    Frame.BackgroundTransparency = 0.2
    Frame.BorderSizePixel = 0
    Frame.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0.04, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 240)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.Parent = Frame

    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(0, 50, 0, 28)
    Track.Position = UDim2.new(0.83, 0, 0.13, 0)
    Track.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    Track.BorderSizePixel = 0
    Track.Parent = Frame

    local Thumb = Instance.new("Frame")
    Thumb.Size = UDim2.new(0, 22, 0, 22)
    Thumb.Position = UDim2.new(0, 3, 0, 3)
    Thumb.BackgroundColor3 = Color3.fromRGB(180, 180, 200)
    Thumb.BorderSizePixel = 0
    Thumb.Parent = Track

    local state = true
    toggles[key] = state
    local toggleColor = color or Color3.fromRGB(0, 200, 255)

    -- Hàm cập nhật toggle
    local function UpdateToggle(animate)
        if not Track or not Thumb then
            return
        end

        local targetPos = state and 25 or 3
        local targetColor = state and toggleColor or Color3.fromRGB(40, 40, 60)
        local thumbColor = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 200)

        if animate and TweenService then
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local trackTween = TweenService:Create(Track, tweenInfo, {BackgroundColor3 = targetColor})
            local thumbTween = TweenService:Create(Thumb, tweenInfo, {
                Position = UDim2.new(0, targetPos, 0, 3),
                BackgroundColor3 = thumbColor
            })
            trackTween:Play()
            thumbTween:Play()
        else
            Track.BackgroundColor3 = targetColor
            Thumb.Position = UDim2.new(0, targetPos, 0, 3)
            Thumb.BackgroundColor3 = thumbColor
        end

        -- Gọi hàm tối ưu sau khi cập nhật
        ApplyOptimizations()
    end

    local function Toggle()
        state = not state
        toggles[key] = state
        UpdateToggle(true)
    end

    -- Sự kiện click
    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Toggle()
        end
    end)

    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Toggle()
        end
    end)

    -- Khởi tạo trạng thái ban đầu
    UpdateToggle(false)
end

-- ========== TẠO CÁC TAB ==========
CreateTabButton("Đồ họa", 1, "🎨")
local gfxTab = tabFrames[1]
CreateToggle(gfxTab, "🌙 Tắt bóng đổ", "Shadow", Color3.fromRGB(0, 200, 255))
CreateToggle(gfxTab, "📦 Vật liệu đơn giản", "Material", Color3.fromRGB(0, 200, 255))
CreateToggle(gfxTab, "🔲 Giảm chi tiết Mesh", "MeshQuality", Color3.fromRGB(0, 200, 255))
CreateToggle(gfxTab, "🌀 Tắt hiệu ứng Post-Processing", "PostProcess", Color3.fromRGB(0, 200, 255))

CreateTabButton("Hiệu ứng", 2, "✨")
local effectTab = tabFrames[2]
CreateToggle(effectTab, "🔥 Tắt hiệu ứng hạt", "Particle", Color3.fromRGB(255, 150, 0))
CreateToggle(effectTab, "💨 Tắt lửa & khói", "FireSmoke", Color3.fromRGB(255, 150, 0))
CreateToggle(effectTab, "💧 Tắt hiệu ứng nước", "Water", Color3.fromRGB(255, 150, 0))
CreateToggle(effectTab, "👻 Ẩn vật thể xa", "Cull", Color3.fromRGB(255, 150, 0))

CreateTabButton("Vật thể", 3, "🧱")
local objectTab = tabFrames[3]
CreateToggle(objectTab, "🔹 Ẩn Decal & Texture", "Decal", Color3.fromRGB(150, 255, 0))
CreateToggle(objectTab, "⬜ Tối ưu Terrain", "TerrainOpt", Color3.fromRGB(150, 255, 0))
CreateToggle(objectTab, "📐 Giảm độ phân giải Mesh", "MeshRes", Color3.fromRGB(150, 255, 0))

CreateTabButton("Ánh sáng", 4, "💡")
local lightTab = tabFrames[4]
CreateToggle(lightTab, "🔆 Tắt ánh sáng khuếch tán", "Diffuse", Color3.fromRGB(255, 50, 150))
CreateToggle(lightTab, "💡 Tắt bóng đèn Point/Spot", "Lights", Color3.fromRGB(255, 50, 150))
CreateToggle(lightTab, "🌥️ Giảm Fog", "Fog", Color3.fromRGB(255, 50, 150))

CreateTabButton("Nâng cao", 5, "🚀")
local advTab = tabFrames[5]
CreateToggle(advTab, "⚡ Giảm tải CPU (vòng lặp)", "CPULoad", Color3.fromRGB(200, 100, 255))
CreateToggle(advTab, "🧹 Dọn dẹp bộ nhớ", "MemoryClean", Color3.fromRGB(200, 100, 255))
CreateToggle(advTab, "🛡️ Vô hiệu hóa Animation", "AnimOff", Color3.fromRGB(200, 100, 255))

-- ========== KÉO THẢ ==========
local dragging, dragStart, startPos

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

-- ========== ĐÓNG & PHÍM TẮT ==========
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F10 then
        menuVisible = not menuVisible
        MainFrame.Visible = menuVisible
    end
end)

-- ========== KHỞI TẠO ==========
task.wait(0.5)
ApplyOptimizations()

print("✅ f0zp Ultimate Optimizer đã sẵn sàng! Nhấn F10 để mở menu.")
print("📌 5 tab: Đồ họa | Hiệu ứng | Vật thể | Ánh sáng | Nâng cao")
