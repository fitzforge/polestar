-- Chinese (simplified) (zhCN): the guide forever/class/mage/astral-knot-garment (forever/class/mage/astral-knot-garment.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a blouse for Human and Gnome mages in their late 20s."] = "为二十多级的人类和侏儒法师准备的长袍或短衫。",

	-- Step 1: Bink (Ironforge)
	-- {npc:5144} Bink · {zone:1455} Ironforge · {object:32362} Mystic Ward · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:5144} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:5144}在{zone:1455}的{object:32362}教导法师。之后从{object:171524}乘{area:2257}前往{zone:1453}。",

	-- Step 2: Jennea Cannon (Stormwind)
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}."] = "{npc:5497}站在{object:2101}的法师塔里。",

	-- Step 3: High Sorcerer Andromath
	-- {quest:1939} High Sorcerer Andromath
	["{quest:1939} is in the Wizard's Sanctum too."] = "{quest:1939}也在法师塔里。",

	-- Step 4: The Tower of Ilgalar
	-- {area:96} Tower of Ilgalar
	["The {area:96}"] = "{area:96}",
	-- {zone:1429} Elwynn Forest
	["Ride east through {zone:1429} into Redridge. The fallen mage's tower of Ilgalar stands in the east of the zone; the treatise is in his library."] = "向东穿过{zone:1429}进入赤脊山。那位堕落法师伊尔加拉的塔位于该地区东部；论文在他的书房里。",

	-- Step 5: Back to Andromath
	["Back to Andromath"] = "回到高阶巫师安多玛斯那里",

	-- Step 6: Carrion Recluses
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse
	["Carrion Recluses"] = "{npc:949}",
	-- {zone:1431} Duskwood
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse · Black Widow Hatchlings = {npc:930} Black Widow Hatchling
	["Carrion Recluses lurk in the woods of western {zone:1431} and each one drops the silk. The Black Widow Hatchlings further east drop it now and then."] = "{npc:949}潜伏在{zone:1431}西部的树林里，每只都会掉落蛛丝。更东边的{npc:930}偶尔也会掉落。",

	-- Step 7: Wynne Larson
	-- {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["{npc:1309} works at {object:23296} in the {object:2101}."] = "{npc:1309}在{object:2101}的{object:23296}工作。",
}
