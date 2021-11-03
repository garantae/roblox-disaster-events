--// Variables
local Debounce = false
local IceGlow = script.IceGlow
local IceTexture = script.IceTexture

--// Configurables
local SlowTime = 1.5
local IceDamage = 15
local IceSlow = 10

if script.Parent:IsA("Part") then
	script.Parent.BrickColor = BrickColor.new("Cyan")
	script.Parent.Material = Enum.Material.Ice
	IceGlow:Clone().Parent = script.Parent	
	IceTexture:Clone().Parent = script.Parent
end

script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and Debounce == false then
		Debounce = true
		if hit.Parent:FindFirstChild("Humanoid").Health > 0 then
			hit.Parent:FindFirstChild("Humanoid").WalkSpeed = hit.Parent:FindFirstChild("Humanoid").WalkSpeed - IceSlow
			hit.Parent:FindFirstChild("Humanoid").Health = hit.Parent:FindFirstChild("Humanoid").Health - IceDamage
			wait(SlowTime)
			hit.Parent:FindFirstChild("Humanoid").WalkSpeed = hit.Parent:FindFirstChild("Humanoid").WalkSpeed + IceSlow
		end
		Debounce = false
	end
	
end)
