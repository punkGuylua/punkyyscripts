local Players = game:GetService("Players")

local TARGET_USER = "punkGuy_lua"
local RADIUS = 30

local function createTool(player)

	local tool = Instance.new("Tool")
	tool.Name = "GreenReaper"
	tool.RequiresHandle = true
	tool.CanBeDropped = false

	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(1,1,3)
	handle.Color = Color3.fromRGB(0,255,0)
	handle.Material = Enum.Material.Neon
	handle.Parent = tool

	local cooldown = false

	tool.Activated:Connect(function()

		if cooldown then return end
		cooldown = true

		local character = player.Character
		if not character then return end

		local root = character:FindFirstChild("HumanoidRootPart")
		if not root then return end

		local origin = root.Position

		for _,target in pairs(Players:GetPlayers()) do

			if target ~= player and target.Character then

				local hrp = target.Character:FindFirstChild("HumanoidRootPart")
				local humanoid = target.Character:FindFirstChild("Humanoid")

				if hrp and humanoid then

					local dist = (hrp.Position - origin).Magnitude

					if dist <= RADIUS then

						humanoid.Health = 0

						for _,part in pairs(target.Character:GetDescendants()) do
							if part:IsA("BasePart") then

								part.Color = Color3.fromRGB(0,255,0)

								local fire = Instance.new("Fire")
								fire.Color = Color3.fromRGB(0,255,0)
								fire.SecondaryColor = Color3.fromRGB(0,255,0)
								fire.Size = 8
								fire.Heat = 10
								fire.Parent = part

							end
						end

					end

				end

			end

		end

		task.wait(1)
		cooldown = false

	end)

	return tool
end


local function makeGreenOnRespawn(character)
	task.wait(0.5)

	for _,part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Color = Color3.fromRGB(0,255,0)
		end
	end
end


Players.PlayerAdded:Connect(function(player)

	player.CharacterAdded:Connect(function(character)

		makeGreenOnRespawn(character)

		if player.Name == TARGET_USER then

			local tool = createTool(player)
			tool.Parent = player.Backpack

		end

	end)

end)
