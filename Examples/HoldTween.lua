local TWS = game:GetService('TweenService')
local Input = require(game.ReplicatedStorage.Input)
local Hold = Input.Hold.new(Enum.UserInputType.MouseButton1)
local Up 
local Part = Instance.new('Part')
Part.Anchored = true
Part.Parent = workspace


Hold.Start:Connect(function(gp) -- Fires gp if the there is only single keybind to prevent confusion (this hasn't happened so far but checking for this would be good)
	if gp then return end
	print('Start')
	Up = TWS:Create(Part,TweenInfo.new(3),{Size = Vector3.new(4,10,2),CFrame = Part.CFrame * CFrame.new(0,4.5,0)})
	Up:Play()
	Up.Completed:Connect(function(Base)
		if Base == Enum.PlaybackState.Completed then
			print('Complete')
			Hold:Destroy()
			Up:Destroy()
		end
	end)
end)

Hold.Hold:Connect(function(Input,gp)
	if gp then
		Hold:Cancel(Input)
	end
end)

Hold.End:Connect(function()
	print('End')
	Up:Cancel()
	Part.Size = Vector3.new(4,1,2)
	Part.Position = Vector3.new()
	Up:Destroy()
end)

