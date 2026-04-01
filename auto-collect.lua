-- auto-collect.lua
-- Standalone auto-collect script for orbs/money

getgenv().AutoCollect = true

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:FindFirstChild("HumanoidRootPart")

print("🔵 Auto-Collect initialized by R2-D2")

while getgenv().AutoCollect do
    wait(0.3)
    local orbsFolder = workspace:FindFirstChild("Orbs")
    if orbsFolder then
        for _, orb in pairs(orbsFolder:GetChildren()) do
            if orb:IsA("BasePart") and root then
                orb.CFrame = root.CFrame
                print("✨ Collected orb")
            end
        end
    end
end
