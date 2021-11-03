--[[ 
  	DisasterBehavior
	@author Garantae

	Determines if a match will have a special event and carries out the selected event's function.
	
--]]

--// Variables
local SendDisasterDetails = game.ReplicatedStorage.CORE_RemoteEvents.SendDisasterDetails
local StatusHeader = game.ReplicatedStorage.CORE_GameValues.StatusHeader
local ChosenMap = game.ReplicatedStorage.CORE_GameValues.ChosenMap
local ChosenSky = game.ReplicatedStorage.CORE_GameValues.ChosenSky
local RedSky = game.ServerStorage.CORE_Skyboxes.RedSky
local WhiteSky = game.ServerStorage.CORE_Skyboxes.WhiteSky
local DisasterDetails

--// Configurables
local StartingWait = 8
local NextLavaRain = 2
local NextBlizzard = 1


StatusHeader.Changed:Connect(function()
	if StatusHeader.Value == "GAME IN PROGRESS" then
		
		wait(StartingWait)
		
		-- Check if the map is compatible
		if workspace.CurrentMap:FindFirstChild(ChosenMap.Value):FindFirstChild("MapTileFloor") then
			
			-- Check if a disaster will occur
			math.randomseed(tick())
			math.random()
			
			wait(1)
			
			local range = math.random(1, 4) 
			
			--// Lava Rain Disaster
			if range == 1 and workspace.CurrentMap:FindFirstChild(ChosenMap.Value):FindFirstChild("LavaRainParticles") then
				
				-- Fire client
				DisasterDetails = "LAVA RAIN! Avoid all lava-covered tiles!"
				game.ReplicatedStorage.CORE_RemoteEvents.SendDisasterDetails:FireAllClients(DisasterDetails)
				
				-- Change the sky
				if game.Lighting:FindFirstChild(ChosenSky.Value) then
					RedSky:Clone().Parent = game.Lighting
					game.Lighting:FindFirstChild(ChosenSky.Value):Destroy()
				end
				
				-- Enable the particles
				if workspace.CurrentMap:FindFirstChild(ChosenMap.Value):FindFirstChild("LavaRainParticles") then
					for _, ParticlePart in pairs(workspace.CurrentMap:FindFirstChild(ChosenMap.Value):FindFirstChild("LavaRainParticles"):GetChildren()) do
						if ParticlePart then
							if ParticlePart:FindFirstChild("ParticleEmitter") then
								ParticlePart:FindFirstChild("ParticleEmitter").Enabled = true
							end
						end
					end
				end
				
				-- START THE DISASTER!
				while StatusHeader.Value == "GAME IN PROGRESS" do
					wait(NextLavaRain)
					
					local FloorParts = workspace.CurrentMap:FindFirstChild(ChosenMap.Value):FindFirstChild("MapTileFloor"):GetChildren()
					local RandomFloorPart = FloorParts[math.random(1,#FloorParts)]
					
					if not RandomFloorPart:FindFirstChild("LavaDamage") then
						local BurnScript = script.LavaDamage:Clone()
						BurnScript.Disabled = false
						BurnScript.Parent = RandomFloorPart
					end
				end
			end
			
			--// Blizzard Disaster
			if range == 2 and workspace.CurrentMap:FindFirstChild(ChosenMap.Value):FindFirstChild("IceRainParticles") then

				-- Fire client
				DisasterDetails = "BLIZZARD! Avoid all ice-covered tiles!"
				game.ReplicatedStorage.CORE_RemoteEvents.SendDisasterDetails:FireAllClients(DisasterDetails)

				-- Change the sky
				if game.Lighting:FindFirstChild(ChosenSky.Value) then
					WhiteSky:Clone().Parent = game.Lighting
					game.Lighting:FindFirstChild(ChosenSky.Value):Destroy()
				end

				-- Enable the particles
				if workspace.CurrentMap:FindFirstChild(ChosenMap.Value):FindFirstChild("IceRainParticles") then
					for _, ParticlePart in pairs(workspace.CurrentMap:FindFirstChild(ChosenMap.Value):FindFirstChild("IceRainParticles"):GetChildren()) do
						if ParticlePart then
							if ParticlePart:FindFirstChild("ParticleEmitter") then
								ParticlePart:FindFirstChild("ParticleEmitter").Enabled = true
							end
						end
					end
				end

				-- START THE DISASTER!
				while StatusHeader.Value == "GAME IN PROGRESS" do
					wait(NextBlizzard)

					local FloorParts = workspace.CurrentMap:FindFirstChild(ChosenMap.Value):FindFirstChild("MapTileFloor"):GetChildren()
					local RandomFloorPart = FloorParts[math.random(1,#FloorParts)]

					if not RandomFloorPart:FindFirstChild("BlizzardDamage") then
						local SlowScript = script.BlizzardDamage:Clone()
						SlowScript.Disabled = false
						SlowScript.Parent = RandomFloorPart
					end
				end
			end
			
		end
		
	end
end)
