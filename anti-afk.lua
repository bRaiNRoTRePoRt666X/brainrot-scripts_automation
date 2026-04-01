-- anti-afk.lua
-- Never get kicked for idling

print("🛡️ Anti-AFK initialized by R2-D2")

game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

print("✅ Anti-AFK active forever. You're welcome.")
