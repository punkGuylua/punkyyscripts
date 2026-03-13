local plr = game.Players.LocalPlayer
if plr.Name ~= "PunkGuy_lua" then return end

local backpack = plr:WaitForChild("Backpack")

-- Crear la tool
local tool = Instance.new("Tool")
tool.Name = "punkTool"
tool.RequiresHandle = true
tool.Parent = backpack

local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(1.2, 6, 1.2)
handle.BrickColor = BrickColor.new("Lime green")
handle.Material = Enum.Material.Neon
handle.Parent = tool

-- LocalScript dentro de la tool (esto hace que funcione al clickear)
local localScript = Instance.new("LocalScript")
localScript.Parent = tool

localScript.Source = [[
    local tool = script.Parent
    local plr = game.Players.LocalPlayer

    tool.Activated:Connect(function()
        local char = plr.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= plr and v.Character then
                local vRoot = v.Character:FindFirstChild("HumanoidRootPart")
                local vHum = v.Character:FindFirstChild("Humanoid")
                if vRoot and vHum and (vRoot.Position - root.Position).Magnitude <= 30 then
                    
                    vHum.Health = 0   -- instakill

                    -- Efectos verdes
                    for _, part in pairs(v.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.BrickColor = BrickColor.new("Lime green")
                            
                            local fire = Instance.new("ParticleEmitter")
                            fire.Texture = "rbxassetid://243660364"
                            fire.Color = ColorSequence.new(Color3.fromRGB(0, 255, 100))
                            fire.Size = NumberSequence.new(2)
                            fire.Lifetime = NumberRange.new(3, 6)
                            fire.Rate = 120
                            fire.Speed = NumberRange.new(4, 10)
                            fire.Parent = part
                            game.Debris:AddItem(fire, 7)
                        end
                    end
                end
            end
        end
    end)
]]

print("✅ punkTool creada correctamente - Equipála y clickeá para matar en 30 studs")
