local Input = require(game.ReplicatedStorage.Input)
local Hold = Input.Hold.new(Enum.UserInputType.MouseButton1,Enum.KeyCode.E) -- Hold mouse button1 and E

Hold.Start:Connect(function()
    print('Start')
end)

Hold.Hold:Connect(function(Input,gp)
    if gp then -- If gameProcessedEvent is true cancel the input 
        Hold:Cancel()
    end
end)

Hold.End:Connect(function()
    print('End')
end)
