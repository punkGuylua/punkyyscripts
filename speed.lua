-- PunkGuy_lua Speed Script (Client)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

hum.WalkSpeed = 100
hum.JumpHeight = 50
hum.JumpPower = 150

print("PunkGuy_lua modo cohete activado - loadstring listo")
