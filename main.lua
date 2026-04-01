-- main.lua v0.2.1
-- R2-D2 Optimized Brainrot Automation
-- Enhancements: task library utilization, distance safety, and cleaner loops.

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/SaveManager.lua"))()

local Window = Library:CreateWindow({
    Title = "🧠 brainrot-scripts v0.2.1 | R2-D2 Optimized",
    Center = true,
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab("Main"),
    Misc = Window:AddTab("Misc"),
}

-- CONFIGS
getgenv().Config = {
    StealRange = 50, -- Safety first!
    CollectSpeed = 0.3
}

-- AUTO STEAL (Optimized with task.spawn)
local stealToggle = Tabs.Main:AddToggle("StealToggle", {Text = "Auto Steal (Radius)", Default = false})
stealToggle:OnChanged(function()
    getgenv().AutoSteal = stealToggle.Value
end)

task.spawn(function()
    while true do
        if getgenv().AutoSteal then
            local p = game.Players.LocalPlayer
            local char = p.Character or p.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")

            for _, v in pairs(workspace:GetChildren()) do
                if (v.Name:find("Brainrot") or v:FindFirstChild("StealPart")) and v:IsA("BasePart") then
                    -- Only steal if within range to avoid "Teleport Bans"
                    if (hrp.Position - v.Position).Magnitude < getgenv().Config.StealRange then
                        firetouchinterest(hrp, v, 0)
                        firetouchinterest(hrp, v, 1)
                    end
                end
            end
        end
        task.wait(0.1)
    end
end)

-- AUTO COLLECT (Magnet Mode)
local collectToggle = Tabs.Main:AddToggle("CollectToggle", {Text = "Orb Magnet", Default = true})
collectToggle:OnChanged(function()
    getgenv().AutoCollect = collectToggle.Value
end)

task.spawn(function()
    while true do
        if getgenv().AutoCollect then
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local orbs = workspace:FindFirstChild("Orbs")
                if orbs then
                    for _, orb in pairs(orbs:GetChildren()) do
                        if orb:IsA("BasePart") then
                            orb.CFrame = hrp.CFrame -- Bring the loot to me!
                        end
                    end
                end
            end
        end
        task.wait(getgenv().Config.CollectSpeed)
    end
end)

-- ANTI-AFK (The "No-Kick" Special)
local Players = game:GetService("Players")
Players.LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

-- THEME & SAVING
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:BuildConfigSection(Tabs.Misc)
ThemeManager:ApplyToTab(Tabs.Misc)

Library:Notify("BEEP! Automation online. Braincells offline.", 5)
