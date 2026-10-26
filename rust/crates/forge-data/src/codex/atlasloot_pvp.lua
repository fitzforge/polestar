function POLESTAR_extra()
  local R = AtlasLoot.Data.Requirements
  local out = {}
  if not R or not R.GetPvPRankIconForItem then return out end
  for _, store in pairs(POLESTAR_AL.stores) do
    local meta = rawget(store, "__al")
    for _, key in ipairs(meta.order) do
      local c = rawget(store, key)
      if type(c) == "table" and type(c.items) == "table" then
        for _, boss in pairs(c.items) do
          if type(boss) == "table" then
            for _, dif in pairs(boss) do
              if type(dif) == "table" then
                for _, r in pairs(dif) do
                  if type(r) == "table" then
                    for _, id in ipairs({ r[2], r[901], r[902] }) do
                      if type(id) == "number" then
                        local ok, icon = pcall(R.GetPvPRankIconForItem, id)
                        if ok and type(icon) == "number" then out[tostring(id)] = icon - 136765 end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  return out
end