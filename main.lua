-- main.lua
-- R2-D2 certified brainrot automation hub
-- Paste this into executor and hit execute

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/SaveManager.lua"))()

local Window = Library:CreateWindow({
    Title = "🧠 brainrot-scripts_automation | R2-D2 Edition",
    Center = true,
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab("Main"),
    Misc = Window:AddTab("Misc"),
}

-- AUTO STEAL
local stealToggle = Tabs.Main:AddToggle("StealToggle", {Text = "Auto Steal EVERYTHING", Default = false})
stealToggle:OnChanged(function(state)
    getgenv().AutoSteal = state
end)

spawn(function()
    while wait(0.1) do
        if getgenv().AutoSteal then
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name:find("Brainrot") or v:FindFirstChild("StealPart") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 5, 0)
                    wait(0.05)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
                end
            end
        end
    end
end)

-- AUTO COLLECT
local collectToggle = Tabs.Main:AddToggle("CollectToggle", {Text = "Auto Collect Orbs", Default = true})
collectToggle:OnChanged(function(state)
    getgenv().AutoCollect = state
end)

spawn(function()
    while wait(0.3) do
        if getgenv().AutoCollect then
            for _, orb in pairs(workspace:FindFirstChild("Orbs") and workspace.Orbs:GetChildren() or {}) do
                if orb:IsA("BasePart") then
                    orb.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end
end)

-- ANTI AFK
game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
Library:Notify("Anti-AFK enabled forever. You're welcome.", 5)

-- GUI SETTINGS
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:BuildConfigSection(Tabs.Misc)
ThemeManager:ApplyToTab(Tabs.Misc)

Library:Notify("🚀 brainrot-scripts loaded. Go steal some brains.", 3)
print("R2-D2 here — scripts online. *whirrrr*")
