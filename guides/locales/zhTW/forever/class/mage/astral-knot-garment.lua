-- Chinese (traditional) (zhTW): the guide forever/class/mage/astral-knot-garment (forever/class/mage/astral-knot-garment.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a blouse for Human and Gnome mages in their late 20s."] = "給20多級後段人類和地精法師的長袍或罩衫。",

	-- Step 1: Bink (Ironforge)
	-- {npc:5144} Bink · {zone:1455} Ironforge · {object:32362} Mystic Ward · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:5144} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:5144}在{zone:1455}的{object:32362}訓練法師。之後從{object:171524}搭乘{area:2257}前往{zone:1453}。",

	-- Step 2: Jennea Cannon (Stormwind)
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}."] = "{npc:5497}站在{object:2101}的高塔巫師聖所。",

	-- Step 3: High Sorcerer Andromath
	-- {quest:1939} High Sorcerer Andromath
	["{quest:1939} is in the Wizard's Sanctum too."] = "{quest:1939}也在巫師聖所。",

	-- Step 4: The Tower of Ilgalar
	-- {area:96} Tower of Ilgalar
	["The {area:96}"] = "{area:96}",
	-- {zone:1429} Elwynn Forest
	["Ride east through {zone:1429} into Redridge. The fallen mage's tower of Ilgalar stands in the east of the zone; the treatise is in his library."] = "向東騎過{zone:1429}進入赤脊山。墮落法師的伊爾加拉之塔位於該區東部；論文在他的書房裡。",

	-- Step 5: Back to Andromath
	["Back to Andromath"] = "返回高階巫師安多瑪斯",

	-- Step 6: Carrion Recluses
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse
	["Carrion Recluses"] = "食腐獨行蛛",
	-- {zone:1431} Duskwood
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse · Black Widow Hatchlings = {npc:930} Black Widow Hatchling
	["Carrion Recluses lurk in the woods of western {zone:1431} and each one drops the silk. The Black Widow Hatchlings further east drop it now and then."] = "食腐獨行蛛潛伏在{zone:1431}西部的樹林中，每隻都會掉落蛛絲。更東邊的小型黑寡婦蜘蛛偶爾也會掉落。",

	-- Step 7: Wynne Larson
	-- {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["{npc:1309} works at {object:23296} in the {object:2101}."] = "{npc:1309}在{object:2101}的{object:23296}工作。",
}
