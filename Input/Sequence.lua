local sequence = {}
local utils = require(script.Parent.Utils)
local ActiveSequences = {}

local SequenceTable = {
	Destroy = function(self)
		local Info = ActiveSequences[self.Index]
		if Info then
			Info.End:Destroy()
			Info.Pressed:Destroy()
			table.remove(ActiveSequences,self.Index)
		end
	end,
	Cancel = function(self)
		local Info = ActiveSequences[self.Index]
		if Info then
			Info.Current -= 1
			if Info.Current < 0 then
				Info.Current = 0
				Info.Previous = Info.PreviouseBefore
			end
		end
	end,
	Reset = function(self)
		local Info = ActiveSequences[self.Index]
		if Info then
			Info.Current = 0
			Info.Previous = nil
			Info.PreviouseBefore = nil
		end
	end,
	Toggle = function(self,Value,Duration)
		local Info = ActiveSequences[self.Index]
		if Info then
			Info.Enabled = Value
		end
		if Duration then
			coroutine.wrap(function()
				task.wait(Duration)
				if Info.Enabled == Value then
					Info.Enabled = not Value
				end
			end)()
		end
	end,
}

sequence.new = function(Delay,...) -- Delay between each key - set to nil for no delay ; All the keys in the combo in an order
	local Keys = {...}
	if #Keys == 0 then warn('Atleast one key required for the sequence') return end
	local Name = ''
	for i , v in ipairs(Keys) do
		Name ..= utils.GetKeyFromEnum(v)
		if i ~= #Keys then
			Name ..= '+'
		end
	end

	if utils.CheckDuplicate(ActiveSequences,Delay,Name) then warn('A sequence with the same keys already exist') return end
	
	local End = Instance.new('BindableEvent')
	End.Name = 'Sequence'..Name..'End'
	End.Parent = game.ReplicatedStorage.EventStorage
	
	local Pressed = Instance.new('BindableEvent')
	Pressed.Name = 'Sequence'..Name..'Pressed'
	Pressed.Parent = game.ReplicatedStorage.EventStorage
	
	table.insert(ActiveSequences,{
		Delay = Delay,
		Keys = Keys,
		Progress = {},
		End = End,
		Pressed = Pressed,
		Name = Name,
		Index = #ActiveSequences + 1,
		Current = 0,
		Enabled = true
	})
	
	local Clone = {}
	
	Clone.End = End.Event
	Clone.Pressed = Pressed.Event
	Clone.Index = #ActiveSequences
	
	for i , v in pairs(SequenceTable) do
		Clone[i] = v
	end
	
	return Clone
end

sequence.Hook = function(Input,gp)
	for i , v in ipairs(ActiveSequences) do
		if v.Enabled then
			if v.Delay then
				local CanCheck = not v.Previous or (os.clock()-v.Previous) <= v.Delay
				if not CanCheck then
					v.Current = 0
					v.Progress = {}
					v.Previous = nil
					v.PreviouseBefore = nil
				end
				local Key = v.Keys[v.Current+1]
				if Key == Input[utils.GetMiddleFromEnum(Key)] then
					v.PreviouseBefore = v.Previous
					v.Current += 1 
					v.Previous = os.clock()
					v.Pressed:Fire(Key,gp,v.Current)
					if v.Current >= #v.Keys then
						v.End:Fire()
						v.Current = 0
						v.Previous = nil
					end
				end
			else
				local Key = v.Keys[v.Current+1]
				if Key == Input[utils.GetMiddleFromEnum(Key)] then
					v.Current += 1 
					v.Pressed:Fire(Key,gp,v.Current)
					if v.Current >= #v.Keys then
						v.End:Fire()
						v.Current = 0
					end
				end
			end
		end
	end
end


return sequence
