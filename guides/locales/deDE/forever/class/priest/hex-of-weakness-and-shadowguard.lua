-- German (deDE): the guide forever/class/priest/hex-of-weakness-and-shadowguard (forever/class/priest/hex-of-weakness-and-shadowguard.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5652} Hex of Weakness · {quest:5642} Shadowguard
	["{quest:5652} and {quest:5642}"] = "{quest:5652} und {quest:5642}",
	-- {quest:5652} Hex of Weakness · {quest:5642} Shadowguard
	["The Troll priest spells: {quest:5652} at 10, {quest:5642} at 20. Free, no objectives."] = "Die Priesterzauber der Trolle: {quest:5652} mit 10, {quest:5642} mit 20. Kostenlos, keine Ziele.",

	-- Step 1: Hex of Weakness: Tai'jin
	-- {npc:3706} Tai'jin · {area:362} Razor Hill · {area:363} Valley of Trials · {quest:5652} Hex of Weakness · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["At 10, {npc:3706}, the priest trainer inside the barracks of {area:362} (the first building on the right as you come up the road from the {area:363}), hands you a {quest:5652} letter for {npc:6018} in {zone:1454}. {area:362} is on the road north to the city."] = "Mit 10 gibt dir {npc:3706}, der Priesterlehrer in der Kaserne von {area:362} (das erste Gebäude rechts, wenn du die Straße aus dem {area:363} heraufkommst), einen Brief {quest:5652} für {npc:6018} in {zone:1454}. {area:362} liegt an der Straße nach Norden zur Stadt.",
	-- {npc:3706} Tai'jin · {quest:5652} Hex of Weakness
	["{npc:3706}: take his {quest:5652} letter"] = "{npc:3706}: Nimm seinen Brief {quest:5652} an",

	-- Step 2: Hex of Weakness: Var'jun
	-- {zone:1412} Mulgore · {npc:11407} Var'jun · {area:222} Bloodhoof Village · {quest:5652} Hex of Weakness · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["At 10 in {zone:1412}, {npc:11407}, just south-west of {area:222}, hands you a {quest:5652} letter for {npc:6018} in {zone:1454}."] = "Mit 10 gibt dir in {zone:1412} {npc:11407}, südwestlich von {area:222}, einen Brief {quest:5652} für {npc:6018} in {zone:1454}.",
	-- {npc:11407} Var'jun · {quest:5652} Hex of Weakness
	["{npc:11407}: take the {quest:5652} letter"] = "{npc:11407}: Nimm den Brief {quest:5652} an",

	-- Step 3: Hex of Weakness: Miles Welsh
	-- {zone:1456} Thunder Bluff · {npc:3044} Miles Welsh · {area:1640} Spirit Rise · {quest:5652} Hex of Weakness · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["At 10 in {zone:1456}, {npc:3044}, the priest trainer in the cave under {area:1640}, hands you a {quest:5652} letter for {npc:6018} in {zone:1454}."] = "Mit 10 gibt dir in {zone:1456} {npc:3044}, der Priesterlehrer in der Höhle unter {area:1640}, einen Brief {quest:5652} für {npc:6018} in {zone:1454}.",
	-- {npc:3044} Miles Welsh · {quest:5652} Hex of Weakness
	["{npc:3044}: take his {quest:5652} letter"] = "{npc:3044}: Nimm seinen Brief {quest:5652} an",

	-- Step 4: Hex of Weakness: Aelthalyste
	-- {zone:1458} Undercity · {npc:4606} Aelthalyste · {object:36070} War Quarter · {quest:5652} Hex of Weakness · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["At 10 in the {zone:1458}, {npc:4606}, the priest trainer in the {object:36070}, hands you a {quest:5652} letter for {npc:6018} in {zone:1454} (the zeppelin from the tower outside the {zone:1458})."] = "Mit 10 gibt dir in der {zone:1458} {npc:4606}, die Priesterlehrerin im {object:36070}, einen Brief {quest:5652} für {npc:6018} in {zone:1454} (der Zeppelin vom Turm vor der {zone:1458}).",
	-- {npc:4606} Aelthalyste · {quest:5652} Hex of Weakness
	["{npc:4606}: take her {quest:5652} letter"] = "{npc:4606}: Nimm ihren Brief {quest:5652} an",

	-- Step 5: Hex of Weakness: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {zone:1454} Orgrimmar · {quest:5652} Hex of Weakness
	["At 10, go to {npc:6018}, the priest trainer in a hut in the {object:172961}, {zone:1454}'s south-west corner: he gives {quest:5652} and takes it back at once. No letter needed."] = "Geh mit 10 zu {npc:6018}, dem Priesterlehrer in einer Hütte im {object:172961}, in der Südwestecke von {zone:1454}: Er gibt dir {quest:5652} und nimmt sie sofort zurück. Kein Brief nötig.",

	-- Step 6: Hex of Weakness: Tai'jin's letter
	-- {quest:5654} Hex of Weakness · {npc:3706} Tai'jin
	["{quest:5654}: {npc:3706}'s letter"] = "{quest:5654}: der Brief von {npc:3706}",
	-- {area:362} Razor Hill · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits · {npc:6018} Ur'kyo · {quest:5654} Hex of Weakness
	["Follow the road north from {area:362} into {zone:1454} and west to the {object:172961}: {npc:6018} takes the letter and teaches {quest:5654}."] = "Folge der Straße von {area:362} nach Norden in {zone:1454} und nach Westen zu {object:172961}: {npc:6018} nimmt den Brief entgegen und bringt dir {quest:5654} bei.",

	-- Step 7: Hex of Weakness: Var'jun's letter
	-- {quest:5655} Hex of Weakness · {npc:11407} Var'jun
	["{quest:5655}: {npc:11407}'s letter"] = "{quest:5655}: der Brief von {npc:11407}",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {zone:1454} Orgrimmar · {zone:1412} Mulgore · {zone:1413} Barrens · {zone:1411} Durotar · {zone:1456} Thunder Bluff
	["Hand the letter to {npc:6018} in the {object:172961}, {zone:1454} (from {zone:1412}: north through the {zone:1413} and east into {zone:1411}, or fly from {zone:1456} once you know {zone:1454}'s flight path)."] = "Gib den Brief bei {npc:6018} im {object:172961} in {zone:1454} ab (von {zone:1412}: nach Norden durch {zone:1413} und nach Osten in {zone:1411}, oder flieg von {zone:1456} aus, sobald du die Flugroute von {zone:1454} kennst).",

	-- Step 8: Hex of Weakness: Miles Welsh's letter
	-- {quest:5656} Hex of Weakness · {npc:3044} Miles Welsh
	["{quest:5656}: {npc:3044}'s letter"] = "{quest:5656}: der Brief von {npc:3044}",

	-- Step 9: Hex of Weakness: Aelthalyste's letter
	-- {quest:5657} Hex of Weakness · {npc:4606} Aelthalyste
	["{quest:5657}: {npc:4606}'s letter"] = "{quest:5657}: der Brief von {npc:4606}",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:6018} in the {object:172961}, {zone:1454} (the zeppelin from {zone:1420} lands outside {zone:1454})."] = "Gib den Brief bei {npc:6018} im {object:172961} in {zone:1454} ab (der Zeppelin aus {zone:1420} landet vor {zone:1454}).",

	-- Step 10: Shadowguard: Miles Welsh
	-- {zone:1456} Thunder Bluff · {npc:3044} Miles Welsh · {area:1640} Spirit Rise · {quest:5642} Shadowguard · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["At 20 in {zone:1456}, {npc:3044} in the cave under {area:1640} hands you a {quest:5642} letter for {npc:6018} in {zone:1454}."] = "Mit 20 gibt dir in {zone:1456} {npc:3044} in der Höhle unter {area:1640} einen Brief {quest:5642} für {npc:6018} in {zone:1454}.",
	-- {npc:3044} Miles Welsh · {quest:5642} Shadowguard
	["{npc:3044}: take his {quest:5642} letter"] = "{npc:3044}: Nimm seinen Brief {quest:5642} an",

	-- Step 11: Shadowguard: Aelthalyste
	-- {zone:1458} Undercity · {npc:4606} Aelthalyste · {object:36070} War Quarter · {quest:5642} Shadowguard · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["At 20 in the {zone:1458}, {npc:4606} in the {object:36070} hands you a {quest:5642} letter for {npc:6018} in {zone:1454}."] = "Mit 20 gibt dir in der {zone:1458} {npc:4606} im {object:36070} einen Brief {quest:5642} für {npc:6018} in {zone:1454}.",
	-- {npc:4606} Aelthalyste · {quest:5642} Shadowguard
	["{npc:4606}: take her {quest:5642} letter"] = "{npc:4606}: Nimm ihren Brief {quest:5642} an",

	-- Step 12: Shadowguard: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {quest:5642} Shadowguard
	["At 20, {npc:6018} in the {object:172961} teaches {quest:5642} with a quest he gives and takes back at once."] = "Mit 20 bringt dir {npc:6018} im {object:172961} {quest:5642} mit einer Quest bei, die er dir gibt und sofort zurücknimmt.",

	-- Step 13: Shadowguard: Miles Welsh's letter
	-- {quest:5642} Shadowguard · {npc:3044} Miles Welsh
	["{quest:5642}: {npc:3044}'s letter"] = "{quest:5642}: der Brief von {npc:3044}",

	-- Step 14: Shadowguard: Aelthalyste's letter
	-- {quest:5643} Shadowguard · {npc:4606} Aelthalyste
	["{quest:5643}: {npc:4606}'s letter"] = "{quest:5643}: der Brief von {npc:4606}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:6018} in the {object:172961}, on {zone:1454}'s west side. Priest trainers elsewhere ({npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to him with a quest of the same name."] = "Geh mit 10 zu {npc:6018} im {object:172961} auf der Westseite von {zone:1454}. Priesterlehrer anderswo ({npc:3706} in {area:362}, {npc:3044} in {zone:1456}) schicken dich mit einer gleichnamigen Quest zu ihm.",
	-- ["At 20, {npc:6018} teaches {quest:5642}. {npc:3044} in {zone:1456} and Aelthalyste in the {zone:1458} send you to him with a quest of the same name."] = "Mit 20 lehrt {npc:6018} {quest:5642}. {npc:3044} in {zone:1456} und Aelthalyste in {zone:1458} schicken dich mit einer gleichnamigen Quest zu ihm.",
	-- ["The Troll priest spells: {quest:5652} at 10, {quest:5642} at 20."] = "Die Priesterzauber der Trolle: {quest:5652} mit 10, {quest:5642} mit 20.",
}
