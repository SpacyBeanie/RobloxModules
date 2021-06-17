--GiantBomb API module made by SSM230
--Lets you access GiantBomb's videogame database trough a module
local module = {}
local HTTP = game:GetService("HttpService")
local APIKey = nil --get yours at https://www.giantbomb.com/api/

function module:UpdateAPIKey(NewKey,silent)
	APIKey = NewKey
	if not silent then
		print("Updated.")
	end
end
local SpecialPlurals = {
	accessory = "accessories",
	company = "companies",
	concept = "concepts",
	person = "people",

}
if APIKey == nil then
	warn("There's no API key! Get yours at https://www.giantbomb.com/api/")
end
function module.SearchByGUID(Category,SearchTerm)
	local request = {
		Url = "https://www.giantbomb.com/api/"..Category.."/"..SearchTerm.."/?api_key="..APIKey.."&format=json",
		Method = "GET",
		Headers = {
			referers = "https://www.roblox.com"
		}
	}
	local Request = HTTP:JSONDecode(HTTP:RequestAsync(request).Body)
	return Request.results 
end
function module.SearchByName(Category,SearchTerm)
	local request = {
		Url = nil,
		Method = "GET",
		Headers = {
			referers = "https://www.roblox.com"
		}
	}
	local Request = nil
	if SpecialPlurals[Category] then
		request.Url = "https://www.giantbomb.com/api/"..SpecialPlurals[Category].."/?api_key="..APIKey.."&format=json&filter=name:"..SearchTerm
	else
		request.Url = "https://www.giantbomb.com/api/"..Category.."s/?api_key="..APIKey.."&format=json&filter=name:"..SearchTerm
	end
	local endres = HTTP:JSONDecode(HTTP:RequestAsync(request).Body)
	return endres.results
end



return module

