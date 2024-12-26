local pre_ok, pre_err = pcall(function()
	include("extload.lua")
	extload.PreInit()
end)
if not pre_ok then
	ErrorNoHalt(pre_err)
end

AddCSLuaFile("includes/_init.lua")
include("includes/_init.lua")

if extload then
	local post_ok, post_err = pcall(extload.PostInit)
	if not post_ok then
		ErrorNoHalt(post_err)
	end
end
