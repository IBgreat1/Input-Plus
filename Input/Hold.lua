local hold = {}
local ActiveHolds = {}
local utils = require(script.Parent.Utils)
local Settings = require(script.Parent.Settings)

local HoldTable = {
	Destroy = function(self)
		local Info = ActiveHolds[self.Index]
		if Info then
			Info.Start:Destroy()
			Info.End:Destroy()
			table.remove(ActiveHolds,self.Index)
		end
	end,
	Cancel = function(self,input)
		local Info = ActiveHolds[self.Index]
		if Info then
			local Index = table.find(Info.Keys,input)
			if Index then
				Info.Progress[Index] = nil
			end
		end
	end,
}

hold.new = function(...)
	local Keys = {...}
	if #Keys == 0 then warn('Atleast one key required for the holder') return end
	local Name = ''
	for i , v in ipairs(Keys) do
		Name ..= utils.GetKeyFromEnum(v)
		if i ~= #Keys then
			Name ..= '+'
		end
	end
	
	if utils.CheckDuplicate(ActiveHolds,nil,Name) then warn('A holder with the same keys already exist') return end
	

	local Start = Instance.new('BindableEvent')
	Start.Name = 'Hold'..Name..'Start'
	Start.Parent = Settings.BindableStorage

	local End = Instance.new('BindableEvent')
	End.Name = 'Hold'..Name..'End'
	End.Parent = Settings.BindableStorage
	
	local Hold = Instance.new('BindableEvent')
	Hold.Name = 'Hold'..Name..'Hold'
	Hold.Parent = Settings.BindableStorage
	
	table.insert(ActiveHolds,{
		Name = Name,
		Keys = Keys,
		Progress = {},
		Enabled = true,
		Index = #ActiveHolds + 1,
		Holding = false,
		Start = Start,
		End = End,
		Hold = Hold
	})
	local Clone = {}
	
	Clone.Start = Start.Event
	Clone.End = End.Event
	Clone.Hold = Hold.Event
	Clone.Index = #ActiveHolds
	
	for i,v in pairs(HoldTable) do
		Clone[i] = v
	end
	
	return Clone
end

hold.HookStart = function(Input,gp)
	for _ , v in ipairs(ActiveHolds) do
		if v.Enabled then
			local Index = table.find(v.Keys,Input.KeyCode) or table.find(v.Keys,Input.UserInputType)
			if Index then
				table.insert(v.Progress,true)
				v.Hold:Fire(v.Keys[Index],gp)
				if #v.Progress == #v.Keys and not v.Holding then
					v.Holding = true
					v.Start:Fire()
				end
			end
		end
	end
end

hold.HookEnd = function(Input)
	for _ , v in ipairs(ActiveHolds) do
		if v.Enabled then
			local Index = table.find(v.Keys,Input.KeyCode) or table.find(v.Keys,Input.UserInputType)
			if Index then
				if v.Progress[1] then
					table.remove(v.Progress,1)
				end
				if v.Holding then
					v.Holding = false
					v.End:Fire()
				end
			end
		end
	end
end


return hold
