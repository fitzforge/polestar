-- Load-on-demand data packs from real files (Polestar_QuestDB, Polestar_Codex,
-- Polestar_ItemDB...), the way the client loads them: LoadAddOn(name) runs the
-- pack's files once, then fires ADDON_LOADED. Load after wow_stub.lua and any
-- stub that wraps LoadAddOn itself (stub_quests.lua).
--
--   stub.packs.Polestar_Codex = { "/abs/Meta.lua", ... }   -- files, in TOC order
--   stub.packLoads.Polestar_Codex                         -- times it was loaded (0 or 1)

stub.packs = stub.packs or {}
stub.packLoads = {}

local base = C_AddOns.LoadAddOn
function C_AddOns.LoadAddOn(name)
	local files = stub.packs[name]
	if not files then return base(name) end
	if stub.addonsLoaded[name] then return true end
	local ns = {}
	for _, f in ipairs(files) do
		local chunk, err = loadfile(f)
		if not chunk then error(err, 0) end
		-- Addon code, as the runner's __load marks it (wow_stub.lua's frame guards tell addon frames from the game's).
		stub.addonSources["@" .. f] = name
		chunk(name, ns)
	end
	stub.packLoads[name] = (stub.packLoads[name] or 0) + 1
	stub.addonLoaded(name)
	return true
end
LoadAddOn = C_AddOns.LoadAddOn
