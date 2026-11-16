-- env: qol
-- The Buttons page's action buttons (Polestar_Options/QoL/ButtonsOptions.lua; QoL/Buttons.lua): the live secure
-- buttons against tests/lua/stub_qol.lua, as ui-look-buttons.rs runs them, on a step that uses a quest item (two
-- in the bags, its key bound), kills two kinds of mob and hearths, with a rare in range and the bags nearly full.
local q, QoL, B
local item, hearth, target, rare, bag
local function rgba(t) local r, g, b, a = t:GetVertexColor(); return { r, g, b, a } end
local function pt(b) local p, _, rp, x, y = b:GetPoint(1); return { p, rp, x, y } end
local function size(fs) return select(2, fs:GetFont()) end
local nearby = { "Hogger" }
return {
	setup = function()
		q, QoL = stub.qol, Polestar.QoL
		B = QoL.Buttons
		item, hearth, target, rare, bag = PolestarQuestItemButton, PolestarHearthButton, PolestarTargetButton, PolestarRareButton, B.bag
		q.items[900] = { name = "Torch" }
		q.items[6948] = { name = "Hearthstone" }
		q.items[1] = { name = "Broken Fang", quality = 0, price = 7 }
		q.items[3] = { name = "Linen Cloth", quality = 1, price = 13 }
		q.addItem(0, 1, 900, 2)
		q.addItem(0, 2, 6948, 1)
		q.addItem(0, 3, 1, 2)
		for slot = 4, 15 do q.addItem(0, slot, 3, 1) end
		q.bindings["CLICK PolestarQuestItemButton:LeftButton"] = { "F" }
		stub.fire("UPDATE_BINDINGS")
		Polestar.Rares = { Nearby = function() return nearby end }
		q.step({ { t = "use", item = 900, quest = 7 }, { t = "kill", target = "Murloc" }, { t = "kill", target = "Gnoll" }, { t = "hearth", location = "Goldshire" } })
		Polestar.Fire("RARE_NEARBY")
		stub.fire("BAG_UPDATE_DELAYED")
		stub.advance(0.5)
	end,
	settle = 0.2,
	probes = {
		["qol.buttonScale"] = function() return { B.Holder():GetScale(), item:GetScale() } end,
		["buttons.layout"] = function() return { pt(hearth), pt(target) } end,
		["buttons.spacing"] = function() return { pt(hearth), pt(target) } end,
		-- The set moved away, then Reset: back in its default spot.
		["Buttons:Position"] = { press = true,
			prepare = function() QoL.State().buttonPos = { "CENTER", "CENTER", 0, 0 }; Polestar.Fire("SETTING_CHANGED", "buttons") end,
			probe = function() return pt(B.Holder()) end },
		["buttons.idleAlpha"] = function() return item:GetAlpha() end,
		["buttons.alpha"] = function()
			q.combat(true)
			local a = item:GetAlpha()
			q.combat(false)
			return a
		end,
		["buttons.itemSize"] = function() return item:GetWidth() end,
		["buttons.hearthSize"] = function() return hearth:GetWidth() end,
		["buttons.targetSize"] = function() return target:GetWidth() end,
		["buttons.rareSize"] = function() return rare:GetWidth() end,
		["buttons.bagSize"] = function() return bag:GetWidth() end,
		["qol.itemButton"] = function() return item:IsShown() and true or false end,
		-- The target button, or beside its list the Polestar mark in its slot.
		["qol.targetButton"] = function() return (target:IsShown() or B.anchor:IsShown()) and true or false end,
		-- The single button instead of the list.
		["qol.targetSimple"] = function() return { target:IsShown() and true or false, B.anchor:IsShown() and true or false } end,
		-- How many rows the list shows: the step's two mobs, or one.
		["qol.targetRows"] = { value = 1, probe = function()
			local n = 0
			for _, r in ipairs(B.rows) do if r:IsShown() then n = n + 1 end end
			return n
		end },
		["qol.rareButton"] = function() return rare:IsShown() and true or false end,
		-- The icon's inset from the button's edge.
		["buttons.padding"] = function() return pt(item.Icon) end,
		["buttons.backing"] = function() return { item.Bg:IsShown() and true or false, rgba(item.Bg) } end,
		["buttons.backingColor"] = function() return rgba(item.Bg) end,
		["buttons.border"] = function() return rgba(item.psBorder[1]) end,
		["buttons.borderColor"] = function() return rgba(item.psBorder[1]) end,
		["buttons.borderSize"] = function() return { item.psBorder[1]:GetHeight(), item.psBorder[1]:GetWidth() } end,
		-- Under the mouse: the hairline's colour.
		["buttons.hoverColor"] = function()
			item:GetScript("OnEnter")(item)
			local c = rgba(item.psBorder[1])
			item:GetScript("OnLeave")(item)
			return c
		end,
		["buttons.glow"] = function() return item.psGlow ~= nil and item.psGlow:IsShown() and true or false end,
		["buttons.glowColor"] = { with = { ["buttons.glow"] = true }, probe = function() return rgba(item.psGlow) end },
		["qol.buttonTextSide"] = function() return pt(target.Label) end,
		["buttons.labelScale"] = function() return size(target.Label) end,
		["buttons.labelOutline"] = { value = "thick", probe = function() return select(3, target.Label:GetFont()) or "" end },
		-- The target button's face: what you do next and who, or a plain crosshair.
		["qol.targetPlate"] = function() return { target.Icon:GetTexture(), { target.Label:GetTextColor() } } end,
		["buttons.miniSize"] = function() return target.Minis[1]:GetWidth() end,
		["buttons.hotkey"] = function() return { item.Hotkey:IsShown() and true or false, item.Hotkey:GetText() } end,
		["buttons.hotkeyScale"] = function() return size(item.Hotkey) end,
		["buttons.count"] = function() return item.Count:IsShown() and true or false end,
		["buttons.cooldownText"] = function() return item.Cooldown.noCooldownCount or false end,
	},
}
