-- auto-steal.lua
-- Standalone auto-steal script
-- Execute independently or as part of main.lua

getgenv().AutoSteal = true

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:FindFirstChild("HumanoidRootPart")

print("🤖 Auto-Steal initialized by R2-D2")

while getgenv().AutoSteal do
    wait(0.1)
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:find("Brainrot") or v:FindFirstChild("StealPart") then
            if root then
                root.CFrame = v.CFrame + Vector3.new(0, 5, 0)
                wait(0.05)
                firetouchinterest(root, v, 0)
                firetouchinterest(root, v, 1)
                print("💀 Stole: " .. v.Name)
            end
        end
    end
end
