-- =========================================================
-- 🚀 ROBLOX OPTIMIZER LITE - AN TOÀN, KHÔNG VĂNG
-- Bật/Tắt tính năng qua console, không can thiệp sâu
-- =========================================================

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- ========== CHỈ BẬT NHỮNG TÍNH NĂNG AN TOÀN ==========

-- 1. GIẢM CHẤT LƯỢNG ĐỒ HỌA (AN TOÀN)
pcall(function()
    settings().Rendering.QualityLevel = 1
end)

-- 2. TẮT HIỆU ỨNG KHÔNG CẦN THIẾT (CHỈ LIGHTING)
pcall(function()
    Lighting.GlobalShadows = false
    Lighting.FogStart = 999999
    Lighting.FogEnd = 999999
    Lighting.EnvironmentDiffuseScale = 0.1
    Lighting.EnvironmentSpecularScale = 0.1
end)

-- 3. TẮT CÁC HIỆU ỨNG HẠT GẦN NHÂN VẬT (KHÔNG QUÉT TOÀN BỘ)
task.spawn(function()
    while Character and Character.Parent do
        for _, obj in ipairs(Character:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") then
                obj.Enabled = false
            end
        end
        task.wait(1)
    end
end)

-- 4. GIỚI HẠN FPS (NẾU CÓ HỖ TRỢ)
pcall(function()
    if setfpscap then
        setfpscap(60)
    end
end)

-- 5. TỐI ƯU TERRAIN (CHỈ KHI CÓ TERRAIN)
pcall(function()
    local Terrain = workspace:FindFirstChildOfClass("Terrain")
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
    end
end)

print("✅ Optimizer Lite đã kích hoạt! (Không văng)")
