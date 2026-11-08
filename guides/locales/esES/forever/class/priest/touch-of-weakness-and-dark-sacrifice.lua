-- Spanish (Spain) (esES): the guide forever/class/priest/touch-of-weakness-and-dark-sacrifice (forever/class/priest/touch-of-weakness-and-dark-sacrifice.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["{spell:2652} and {quest:5644}"] = "{spell:2652} y {quest:5644}",
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["The Undead priest spells: {spell:2652} at 10, {quest:5644} (new in Forever) at 20. Free, no objectives."] = "",

	-- Step 1: Touch of Weakness: Tai'jin
	-- {zone:1411} Durotar · {npc:3706} Tai'jin · {object:3224} Razor Hill (no name in this language: may be words) · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1411}, {npc:3706}, the priest trainer inside the barracks of {object:3224}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "",
	-- {npc:3706} Tai'jin · {spell:2652} Touch of Weakness
	["{npc:3706}: take his {spell:2652} letter"] = "",

	-- Step 2: Touch of Weakness: Ur'kyo
	-- {zone:1454} Orgrimmar · {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity · {zone:1420} Tirisfal Glades
	["At 10 in {zone:1454}, {npc:6018} in the {object:172961} hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}. The zeppelin to {zone:1420} leaves from the tower outside {zone:1454}'s front gate."] = "",
	-- {npc:6018} Ur'kyo · {spell:2652} Touch of Weakness
	["{npc:6018}: take his {spell:2652} letter"] = "",

	-- Step 3: Touch of Weakness: Var'jun
	-- {zone:1412} Mulgore · {npc:11407} Var'jun · {object:2968} Bloodhoof Village (no name in this language: may be words) · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1412}, {npc:11407}, just south-west of {object:2968}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "",
	-- {npc:11407} Var'jun · {spell:2652} Touch of Weakness
	["{npc:11407}: take the {spell:2652} letter"] = "",

	-- Step 4: Touch of Weakness: Miles Welsh
	-- {zone:1456} Thunder Bluff · {npc:3044} Miles Welsh · {object:50495} Spirit Rise (no name in this language: may be words) · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1456}, {npc:3044}, the priest trainer in the cave under {object:50495}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "",
	-- {npc:3044} Miles Welsh · {spell:2652} Touch of Weakness
	["{npc:3044}: take his {spell:2652} letter"] = "",

	-- Step 5: Touch of Weakness: Aelthalyste
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {quest:5658} Touch of Weakness
	["At 10, go to {npc:4606}, the priest trainer in the {zone:1458}'s {object:36070}: she gives {quest:5658} and takes it back at once. No letter needed. From Brill, follow the road south to the ruined city of Lordaeron; the {zone:1458}'s lifts are at the back of the throne room. {quest:5658} strikes the next melee attacker for Shadow damage and lowers its melee attack power for 2 minutes."] = "",

	-- Step 6: Touch of Weakness: Tai'jin's letter
	-- {quest:5660} Touch of Weakness · {npc:3706} Tai'jin
	["{quest:5660}: {npc:3706}'s letter"] = "",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: the zeppelin from the tower outside {zone:1454} lands in {zone:1420}, a short walk from the {zone:1458}."] = "",

	-- Step 7: Touch of Weakness: Var'jun's letter
	-- {quest:5661} Touch of Weakness · {npc:11407} Var'jun
	["{quest:5661}: {npc:11407}'s letter"] = "",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: travel to {zone:1454} and take the zeppelin to {zone:1420}."] = "",

	-- Step 8: Touch of Weakness: Ur'kyo's letter
	-- {quest:5662} Touch of Weakness · {npc:6018} Ur'kyo
	["{quest:5662}: {npc:6018}'s letter"] = "",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: the zeppelin from the tower outside {zone:1454} lands in {zone:1420}."] = "",

	-- Step 9: Touch of Weakness: Miles Welsh's letter
	-- {quest:5663} Touch of Weakness · {npc:3044} Miles Welsh
	["{quest:5663}: {npc:3044}'s letter"] = "",

	-- Step 10: Dark Sacrifice: Ur'kyo
	-- {zone:1454} Orgrimmar · {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {quest:5644} Dark Sacrifice · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 20 in {zone:1454}, {npc:6018} in the {object:172961} hands you a {quest:5644} letter for {npc:4606} in the {zone:1458}."] = "",
	-- {npc:6018} Ur'kyo · {quest:5644} Dark Sacrifice
	["{npc:6018}: take his {quest:5644} letter"] = "",

	-- Step 11: Dark Sacrifice: Miles Welsh
	-- {zone:1456} Thunder Bluff · {npc:3044} Miles Welsh · {object:50495} Spirit Rise (no name in this language: may be words) · {quest:5644} Dark Sacrifice · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 20 in {zone:1456}, {npc:3044} in the cave under {object:50495} hands you a {quest:5644} letter for {npc:4606} in the {zone:1458}."] = "",
	-- {npc:3044} Miles Welsh · {quest:5644} Dark Sacrifice
	["{npc:3044}: take his {quest:5644} letter"] = "",

	-- Step 12: Dark Sacrifice: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter · {quest:5644} Dark Sacrifice
	["At 20, {npc:4606} in the {object:36070} teaches {quest:5644} with a quest she gives and takes back at once (its text still speaks of Devouring Plague, which every priest now learns from the trainer)."] = "",

	-- Step 13: Dark Sacrifice: Ur'kyo's letter
	-- {quest:5646} Dark Sacrifice · {npc:6018} Ur'kyo
	["{quest:5646}: {npc:6018}'s letter"] = "",

	-- Step 14: Dark Sacrifice: Miles Welsh's letter
	-- {quest:5644} Dark Sacrifice · {npc:3044} Miles Welsh
	["{quest:5644}: {npc:3044}'s letter"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:4606} in the {zone:1458}'s {object:36070}. Priest trainers elsewhere ({npc:6018} in {zone:1454}, {npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to her with a quest of the same name."] = "A nivel 10, ve con {npc:4606} en {object:36070} de {zone:1458}. Los instructores de sacerdotes de otros lugares ({npc:6018} en {zone:1454}, {npc:3706} en {area:362}, {npc:3044} en {zone:1456}) te envían con ella con una misión del mismo nombre.",
	-- ["At 20, {npc:4606} teaches {quest:5644}. {npc:6018} in {zone:1454} and {npc:3044} in {zone:1456} send you to her with a quest of the same name."] = "A nivel 20, {npc:4606} enseña {quest:5644}. {npc:6018} en {zone:1454} y {npc:3044} en {zone:1456} te envían con ella con una misión del mismo nombre.",
	-- ["The Undead priest spells: {spell:2652} at 10, {quest:5644} at 20."] = "Los hechizos de sacerdote no-muerto: {spell:2652} a nivel 10, {quest:5644} a nivel 20.",
}
