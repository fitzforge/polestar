local ns = POLESTAR_NS
local function places(info)
  local out = {}
  for _, kv in ipairs(POLESTAR_pairs(info)) do
    local id, v = kv[1], kv[2]
    if type(v) == "table" then
      local z = v.zoneID
      local rec = { id = id }
      if type(z) == "table" then
        rec.zones = {}
        for _, zk in ipairs(POLESTAR_pairs(z)) do
          local p = zk[2]
          if type(p) == "table" then
            rec.zones[#rec.zones + 1] = { map = zk[1], x = p.x, y = p.y, overlay = p.overlay }
          end
        end
      else
        rec.zones = { { map = z, x = v.x, y = v.y, overlay = v.overlay } }
      end
      out[#out + 1] = rec
    end
  end
  return out
end
return {
  npcs = places(ns.NPC_INFO),
  npcLoot = POLESTAR_pairs(ns.NPC_LOOT),
  containers = places(ns.CONTAINER_INFO),
  containerLoot = POLESTAR_pairs(ns.CONTAINER_LOOT),
  mounts = POLESTAR_pairs(ns.DROPPED_MOUNT_IDS),
  pets = POLESTAR_pairs(ns.DROPPED_PET_IDS),
}