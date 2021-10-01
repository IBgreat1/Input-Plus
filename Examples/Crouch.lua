local Input = require(game.ReplicatedStorage.Input)
-- Taking control as key for crouching/proning
local Return = Input.Sequence.new(nil,Enum.KeyCode.LeftControl,Enum.KeyCode.LeftControl,Enum.KeyCode.LeftControl,Enum.KeyCode.LeftControl)
local State = {'Crouch','Prone','Crouch','Stand'}
-- Order : Standing - Crouching - Proning - Crouching - Standing

Return.Pressed:Connect(function(Input,gp,index)
	if gp then Return:Cancel() return end 
	print(State[index]) -- Returns the current state of crouch/prone/stand
end)
