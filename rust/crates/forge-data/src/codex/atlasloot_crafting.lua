function POLESTAR_extra()
  local P = AtlasLoot.Data.Profession
  local out = {}
  if not P or not P.GetProfessionData then return out end
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
                  if type(r) == "table" and type(r[2]) == "number" then
                    local d = P.GetProfessionData(r[2])
                    if d then out[tostring(r[2])] = { item = d[1], skill = d[3] } end
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