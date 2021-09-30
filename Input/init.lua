local TypeDefinitions = require(script:WaitForChild("TypeDefinitions"));
type InputType = TypeDefinitions.Input;

local Input : InputType = {}
local Ignore = {'Settings','Utils', 'TypeDefinitions'}

local Folder = Instance.new('Folder')
Folder.Name = 'EventStorage'
Folder.Parent = game.ReplicatedStorage

local UIS = game:GetService('UserInputService')

for _ , v in ipairs(script:GetChildren()) do
	if v:IsA('ModuleScript') and not table.find(Ignore,v.Name) then
		Input[v.Name] = require(v)
	end
end

UIS.InputBegan:Connect(function(...)
	Input.Sequence.Hook(...)
	Input.Hold.HookStart(...)
end)

UIS.InputEnded:Connect(function(...)
	Input.Hold.HookEnd(...)
end)

return Input
