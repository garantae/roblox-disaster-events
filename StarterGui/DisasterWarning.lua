--[[
	DisasterWarning
	@author Garantae

	When a disaster occurs within a match, send the player a warning.

--]]

--// Variables
local SendDisasterDetails = game.ReplicatedStorage.CORE_RemoteEvents.SendDisasterDetails
local WarningDescription = script.Parent.MainFrame.WarningFrame.WarningDescription
local MainFrame = script.Parent.MainFrame
local WarningSFX = script.WarningSFX

--// Configurables
local ViewTime = 5

--// OnClient event
SendDisasterDetails.OnClientEvent:Connect(function(DisasterDetails)
	
	if DisasterDetails then
		WarningDescription.Text = DisasterDetails
	end
	
	--// Tween (animate the warning)
	if MainFrame.Visible == false then
		WarningSFX:Play()
		MainFrame.Position = UDim2.new(-0.3, 0,0.125, 0)
		MainFrame.Visible = true
		MainFrame:TweenPosition(UDim2.new(0.353, 0,0.125, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Bounce)
		
		wait(ViewTime)
		
		MainFrame:TweenPosition(UDim2.new(-0.3, 0, 0.125, 0), 0.25)
		wait(1)
		MainFrame.Visible = false
	end
	
end)
