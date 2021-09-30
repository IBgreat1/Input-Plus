local utils = {}
local Cache = {}
Cache.Names = {}
Cache.Middle = {}

utils.GetKeyFromEnum = function(Input)
	if not Cache.Names[Input] then
		local Name = Input and tostring(Input):split('.')[3]
		Cache.Names[Input] = Name
		return Name
	else
		return Cache.Names[Input]
	end
end

utils.GetMiddleFromEnum = function(Input)
	if not Cache.Middle[Input] then
		local Middle = Input and tostring(Input):split('.')[2]
		Cache.Middle[Input] = Middle
		return Middle
	else
		return Cache.Middle[Input]
	end
end

utils.CheckDuplicate = function(List,Delay,GP,Name)
	for _ , v in ipairs(List) do
		if v.Name == Name then
			if v.Delay == Delay and v.GP == GP then
				return true
			end
		end
	end
end

return utils
