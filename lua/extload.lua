AddCSLuaFile()
local TAG = "extload"
local active_gamemode = engine.ActiveGamemode()

extload = extload or {}

local function loader(prefix)
	local files_sh = file.Find(prefix .. "*.lua", "LUA")
	local files_cl = file.Find(prefix .. "client/*.lua", "LUA")
	local files_sv = file.Find(prefix .. "server/*.lua", "LUA")

	for _, path in ipairs(files_sh) do
		if SERVER then
			AddCSLuaFile(prefix .. path)
		end
		include(prefix .. path)
	end
	for _, path in ipairs(files_cl) do
		if SERVER then
			AddCSLuaFile(prefix .. "client/" .. path)
		elseif CLIENT then
			include(prefix .. "client/" .. path)
		end
	end

	if SERVER then
		for _, path in ipairs(files_sv) do
			include(prefix .. "server/" .. path)
		end
	end
end

function extload.PreInit()
	loader("preinit/")
	loader("preinit/" .. active_gamemode .. "/")
end

function extload.PostInit()
	loader("postinit/")
	loader("postinit/" .. active_gamemode .. "/")
end

function extload.GamemodeAutorun()
	loader("autorun/" .. active_gamemode .. "/")
end

if hook then
	hook.Add("DoPostAutorun", TAG, function()
		loader("postautorun/")
	end)
end
