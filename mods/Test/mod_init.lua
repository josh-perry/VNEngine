local mod_path = "mods/Test"
local mod = {}

local function load_assets(toAdd, toPath)
    local filesTable = love.filesystem.getDirectoryItems(toPath)
    for i,v in ipairs(filesTable) do
        local file = toPath.."/"..v
        if love.filesystem.isFile(file) then
        	if string.find(file, ".lua") then
				local sfile = string.gsub(file, ".lua", "")
				local afile = string.gsub(string.gsub(file, toPath.."/", ""), ".lua", "")
				toAdd[afile] = require(sfile)
				print("Including '"..sfile..".lua'")
			end
		elseif love.filesystem.isDirectory(file) then
			load_assets(toAdd, file)
		end
	end
end

local function mod_init()
	mod.name = "Last Chance HD"
	mod.paths = {}
	mod.paths.root = mod_path
	mod.script = require(mod_path.."/script")

	mod.characters = {}
	mod.locations = {}
	mod.saves = {}

	mod.paths.characters = mod_path.."/characters"
	mod.paths.saves = mod_path.."/saves"
	mod.paths.locations = mod_path.."/locations"

	load_assets(mod.characters, mod.paths.characters)
	load_assets(mod.locations, mod.paths.locations)
	load_assets(mod.saves, mod.paths.saves)

	mod.save_file = mod.saves["1"]

	return true
end

if mod_init() then
	return mod
else
	return false
end
