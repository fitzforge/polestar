-- Russian (ruRU): the guide forever/class/mage/manaweave-robe (forever/class/mage/manaweave-robe.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1453} Stormwind · {zone:1432} Loch Modan
	["A robe at 15 for Alliance mages, from {zone:1453} and {zone:1432}."] = "Мантия на 15-м уровне для магов Альянса; задания: {zone:1453} и {zone:1432}.",

	-- Step 1: Zaldimar Wefhellt (Goldshire)
	-- {npc:328} Zaldimar Wefhellt · {area:87} Goldshire
	["{npc:328} is the {area:87} mage trainer."] = "{npc:328} – учитель магов ({area:87}).",

	-- Step 2: Dink (Ironforge)
	-- {npc:7312} Dink · {zone:1455} Ironforge · {object:32362} Mystic Ward · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:7312} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:7312} обучает магов ({zone:1455}, {object:32362}). Затем сядьте на поезд ({area:2257}) в районе {object:171524} до города {zone:1453}.",

	-- Step 3: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:5497} стоит в башне ({object:2101}). {item:7247} и {item:7308} лежат за ней.",

	-- Step 4: The Blue Recluse
	-- {object:2169} The Blue Recluse · {object:2101} Mage Quarter · {item:7308} Cantation of Manifestation · {npc:6492} Rift Spawn · {item:7247} Chest of Containment Coffers
	["{object:2169} is the tavern in the {object:2101}. Use the {item:7308} inside to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "{object:2169} – таверна ({object:2101}). Используйте внутри {item:7308}, чтобы сделать видимой цель {npc:6492}, ослабьте ее заклинаниями, затем используйте {item:7247}, чтобы бросить ларец и поймать ее.",

	-- Step 5: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "Назад: {npc:5497}",

	-- Step 6: Linen Cloth
	-- {item:2589} Linen Cloth · {object:2096} Trade District
	["Humanoids drop {item:2589}; the Auction House in the {object:2096} sells it."] = "{item:2589} падает с гуманоидов; продается на аукционе ({object:2096}).",

	-- Step 7: The Silver Stream Mine
	-- {area:149} Silver Stream Mine
	["The {area:149}"] = "{area:149}",
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {zone:1432} Loch Modan · {area:149} Silver Stream Mine
	["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The dwarven miners' league left the crates in the {area:149} at the north end of the loch; Tunnel Rat troggs hold the mine."] = "Сядьте на поезд ({area:2257}) до города {zone:1455}, затем идите по дороге на восток через туннель Южных ворот в зону {zone:1432}. Лига дворфов-шахтеров оставила ящики здесь: {area:149}, у северного конца озера; рудник занимают трогги-туннельщики.",

	-- Step 8: Wynne Larson
	-- {zone:1453} Stormwind · {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["Back to {zone:1453} by the tram. {npc:1309} works at {object:23296} in the {object:2101}."] = "Назад на поезде. Цель: {zone:1453}. {npc:1309} работает здесь: {object:23296} ({object:2101}).",
}
