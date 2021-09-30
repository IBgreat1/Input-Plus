local Input = require(game.ReplicatedStorage.Input)
local Return = Input.Sequence.new(.5,Enum.KeyCode.Space,Enum.KeyCode.Space)
local Player = game.Players.LocalPlayer
local Character
local Humanoid 
local Jumped = false

--This is a very basic script to showcase how the module functions can be improved.

local function Setup(char)
    Character = char
    Humanoid = Character:WaitForChild('Humanoid')
    if Humanoid then
        Humanoid.StateChanged:Connect(function(old,new)
            if new == Enum.HumanoidStateType.Freefall and not Jumped then
                Return:Toggle(true)
            elseif new == Enum.HumanoidStateType.Landed then
                Return:Toggle(false)
                Jumped = false
            end
        end)
    end
end

Player.CharacterAdded:Connect(Setup)

Return.Pressed:Connect(function(inp,gp,index)
    if gp then
        Return:Cancel()
    else
        if Character and Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

Return.End:Connect(function()
    Return:Toggle(false)
    Jumped = true
end)
