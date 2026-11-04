-- Russian (ruRU): the guide forever/class/priest/hex-of-weakness-and-shadowguard (forever/class/priest/hex-of-weakness-and-shadowguard.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5652} Hex of Weakness · {quest:5642} Shadowguard
	["{quest:5652} and {quest:5642}"] = "{quest:5652} и {quest:5642}",
	-- {quest:5652} Hex of Weakness · {quest:5642} Shadowguard
	["The Troll priest spells: {quest:5652} at 10, {quest:5642} at 20. Free, no objectives."] = "",

	-- Step 1: Hex of Weakness: Tai'jin
	-- {npc:3706} Tai'jin · {area:362} Razor Hill · {area:363} Valley of Trials · {quest:5652} Hex of Weakness · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["At 10, {npc:3706}, the priest trainer inside the barracks of {area:362} (the first building on the right as you come up the road from the {area:363}), hands you a {quest:5652} letter for {npc:6018} in {zone:1454}. {area:362} is on the road north to the city."] = "",
	-- {npc:3706} Tai'jin · {quest:5652} Hex of Weakness
	["{npc:3706}: take his {quest:5652} letter"] = "",

	-- Step 2: Hex of Weakness: Var'jun
	-- {zone:1412} Mulgore · {npc:11407} Var'jun · {area:222} Bloodhoof Village · {quest:5652} Hex of Weakness · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["At 10 in {zone:1412}, {npc:11407}, just south-west of {area:222}, hands you a {quest:5652} letter for {npc:6018} in {zone:1454}."] = "",
	-- {npc:11407} Var'jun · {quest:5652} Hex of Weakness
	["{npc:11407}: take the {quest:5652} letter"] = "",

	-- Step 3: Hex of Weakness: Miles Welsh
	-- {zone:1456} Thunder Bluff · {npc:3044} Miles Welsh · {area:1640} Spirit Rise · {quest:5652} Hex of Weakness · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["At 10 in {zone:1456}, {npc:3044}, the priest trainer in the cave under {area:1640}, hands you a {quest:5652} letter for {npc:6018} in {zone:1454}."] = "",
	-- {npc:3044} Miles Welsh · {quest:5652} Hex of Weakness
	["{npc:3044}: take his {quest:5652} letter"] = "",

	-- Step 4: Hex of Weakness: Aelthalyste
	-- {zone:1458} Undercity · {npc:4606} Aelthalyste · {object:36070} War Quarter · {quest:5652} Hex of Weakness · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["At 10 in the {zone:1458}, {npc:4606}, the priest trainer in the {object:36070}, hands you a {quest:5652} letter for {npc:6018} in {zone:1454} (the zeppelin from the tower outside the {zone:1458})."] = "",
	-- {npc:4606} Aelthalyste · {quest:5652} Hex of Weakness
	["{npc:4606}: take her {quest:5652} letter"] = "",

	-- Step 5: Hex of Weakness: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {zone:1454} Orgrimmar · {quest:5652} Hex of Weakness
	["At 10, go to {npc:6018}, the priest trainer in a hut in the {object:172961}, {zone:1454}'s south-west corner: he gives {quest:5652} and takes it back at once. No letter needed."] = "",

	-- Step 6: Hex of Weakness: Tai'jin's letter
	-- {quest:5654} Hex of Weakness · {npc:3706} Tai'jin
	["{quest:5654}: {npc:3706}'s letter"] = "",
	-- {area:362} Razor Hill · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits · {npc:6018} Ur'kyo · {quest:5654} Hex of Weakness
	["Follow the road north from {area:362} into {zone:1454} and west to the {object:172961}: {npc:6018} takes the letter and teaches {quest:5654}."] = "",

	-- Step 7: Hex of Weakness: Var'jun's letter
	-- {quest:5655} Hex of Weakness · {npc:11407} Var'jun
	["{quest:5655}: {npc:11407}'s letter"] = "",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {zone:1454} Orgrimmar · {zone:1412} Mulgore · {zone:1413} Barrens · {zone:1411} Durotar · {zone:1456} Thunder Bluff
	["Hand the letter to {npc:6018} in the {object:172961}, {zone:1454} (from {zone:1412}: north through the {zone:1413} and east into {zone:1411}, or fly from {zone:1456} once you know {zone:1454}'s flight path)."] = "",

	-- Step 8: Hex of Weakness: Miles Welsh's letter
	-- {quest:5656} Hex of Weakness · {npc:3044} Miles Welsh
	["{quest:5656}: {npc:3044}'s letter"] = "",

	-- Step 9: Hex of Weakness: Aelthalyste's letter
	-- {quest:5657} Hex of Weakness · {npc:4606} Aelthalyste
	["{quest:5657}: {npc:4606}'s letter"] = "",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:6018} in the {object:172961}, {zone:1454} (the zeppelin from {zone:1420} lands outside {zone:1454})."] = "",

	-- Step 10: Shadowguard: Miles Welsh
	-- {zone:1456} Thunder Bluff · {npc:3044} Miles Welsh · {area:1640} Spirit Rise · {quest:5642} Shadowguard · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["At 20 in {zone:1456}, {npc:3044} in the cave under {area:1640} hands you a {quest:5642} letter for {npc:6018} in {zone:1454}."] = "",
	-- {npc:3044} Miles Welsh · {quest:5642} Shadowguard
	["{npc:3044}: take his {quest:5642} letter"] = "",

	-- Step 11: Shadowguard: Aelthalyste
	-- {zone:1458} Undercity · {npc:4606} Aelthalyste · {object:36070} War Quarter · {quest:5642} Shadowguard · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["At 20 in the {zone:1458}, {npc:4606} in the {object:36070} hands you a {quest:5642} letter for {npc:6018} in {zone:1454}."] = "",
	-- {npc:4606} Aelthalyste · {quest:5642} Shadowguard
	["{npc:4606}: take her {quest:5642} letter"] = "",

	-- Step 12: Shadowguard: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {quest:5642} Shadowguard
	["At 20, {npc:6018} in the {object:172961} teaches {quest:5642} with a quest he gives and takes back at once."] = "",

	-- Step 13: Shadowguard: Miles Welsh's letter
	-- {quest:5642} Shadowguard · {npc:3044} Miles Welsh
	["{quest:5642}: {npc:3044}'s letter"] = "",

	-- Step 14: Shadowguard: Aelthalyste's letter
	-- {quest:5643} Shadowguard · {npc:4606} Aelthalyste
	["{quest:5643}: {npc:4606}'s letter"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:6018} in the {object:172961}, on {zone:1454}'s west side. Priest trainers elsewhere ({npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to him with a quest of the same name."] = "На 10-м уровне идите к NPC {npc:6018} ({object:172961}, западная часть города {zone:1454}). Учителя жрецов в других местах ({npc:3706} — {area:362}, {npc:3044} — {zone:1456}) отправляют вас к нему с одноименным заданием.",
	-- ["At 20, {npc:6018} teaches {quest:5642}. {npc:3044} in {zone:1456} and Aelthalyste in the {zone:1458} send you to him with a quest of the same name."] = "На 20-м уровне {npc:6018} обучает заклинанию {quest:5642}. {npc:3044} ({zone:1456}) и Эльталисте ({zone:1458}) отправляют вас к нему с одноименным заданием.",
	-- ["The Troll priest spells: {quest:5652} at 10, {quest:5642} at 20."] = "Заклинания жрецов-троллей: {quest:5652} на 10-м уровне, {quest:5642} на 20-м.",
}
