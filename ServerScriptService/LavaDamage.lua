--// Variables
local Debounce = false
local LavaGlow = script.LavaGlow
local LavaTexture = script.LavaTexture

--// Configurables
local BurnTime = 1.2
local BurnDamage = 25

if script.Parent:IsA("Part") then
	script.Parent.BrickColor = BrickColor.new("Neon orange")
	script.Parent.Material = Enum.Material.Neon
	LavaGlow:Clone().Parent = script.Parent	
	LavaTexture:Clone().Parent = script.Parent
end

script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and Debounce == false then
		Debounce = true
		if hit.Parent:FindFirstChild("Humanoid").Health > 0 then
			
			hit.Parent:FindFirstChild("Humanoid").Health = hit.Parent:FindFirstChild("Humanoid").Health - BurnDamage
			
			
			-- Add the fire effect
			if hit.Parent:FindFirstChild("HumanoidRootPart") then
				local FireInstance = Instance.new("Fire")
				FireInstance:Clone()
				FireInstance.Name = "FireFromLava"
				FireInstance.Parent = hit.Parent:FindFirstChild("HumanoidRootPart")
			end
			
			wait(BurnTime)
			
			-- Delete the fire effect
			if hit.Parent:FindFirstChild("HumanoidRootPart") then
				if hit.Parent:FindFirstChild("HumanoidRootPart"):FindFirstChild("FireFromLava") then
					hit.Parent:FindFirstChild("HumanoidRootPart"):FindFirstChild("FireFromLava").Enabled = false
					wait(1)
					hit.Parent:FindFirstChild("HumanoidRootPart"):FindFirstChild("FireFromLava"):Destroy()
				end
			end
			
		end
		Debounce = false
	end
	
end)
