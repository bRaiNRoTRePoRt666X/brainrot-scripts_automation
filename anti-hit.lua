-- anti-hit.lua
-- Basic dodge/teleport when attacked

getgenv().AntiHit = true

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:FindFirstChild("HumanoidRootPart")

print("👻 Anti-Hit initialized by R2-D2")

local function dodge()
    if root and getgenv().AntiHit then
        local randomOffset = Vector3.new(
            math.random(-20, 20),
            math.random(0, 10),
            math.random(-20, 20)
        )
        root.CFrame = root.CFrame + randomOffset
        print("🙃 Dodged!")
    end
end

-- Simple damage detection
character.ChildAdded:Connect(function(child)
    if child.Name == "ForceField" then
        -- Already protected
    end
end)

-- Listen for humanoid state changes (basic hit detection)
local humanoid = character:FindFirstChild("Humanoid")
if humanoid then
    humanoid.HealthChanged:Connect(function(health)
        if health < humanoid.MaxHealth and getgenv().AntiHit then
            dodge()
        end
    end)
end

print("✅ Anti-Hit monitoring active")
