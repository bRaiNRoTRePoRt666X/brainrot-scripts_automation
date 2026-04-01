-- auto-sell.lua (drop-in extra)
getgenv().AutoSell = true
while getgenv().AutoSell do
    wait(15)
    local sellNPC = workspace:FindFirstChild("SellNPC") or game.ReplicatedStorage:FindFirstChild("SellEvent")
    if sellNPC then
        fireproximityprompt(sellNPC.ProximityPrompt)
        print("💰 Sold all brainrot. Cha-ching.")
    end
end
