local Input = require(game.ReplicatedStorage.Input)
local Return = Input.Sequence.new(.5,Enum.KeyCode.W,Enum.KeyCode.W)
local Character

--This is a basic script to teleport 10 studs ahead upon double tapping W to showcase how the module works.

local function Setup(char)
    if not char:FindFirstChild('HumanoidRootPart') then
        char:WaitForChild('HumanoidRootPart')
    end
    Character = char
end
game.Players.LocalPlayer.CharacterAdded:Connect(Setup)

Return.Pressed:Connect(function(inp,gp,index)
    if gp then -- If gameProcessedEvent is true cancel the input 
        Return:Cancel()
    elseif index == 2 and Character then
        Character.HumanoidRootPart.CFrame *= CFrame.new(0,0,-10)
    end
end)

Return.End:Connect(function()
    Return:Toggle(false,2) -- Disabling keybind for two seconds (a sort of cooldown)
end)
