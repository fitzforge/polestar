-- German (deDE): the guide forever/class/priest/touch-of-weakness-and-dark-sacrifice (forever/class/priest/touch-of-weakness-and-dark-sacrifice.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["{spell:2652} and {quest:5644}"] = "{spell:2652} und {quest:5644}",
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["The Undead priest spells: {spell:2652} at 10, {quest:5644} (new in Forever) at 20. Free, no objectives."] = "Die Priesterzauber der Untoten: {spell:2652} mit 10, {quest:5644} (neu in Forever) mit 20. Kostenlos, keine Ziele.",

	-- Step 1: Touch of Weakness: Tai'jin
	-- {zone:1411} Durotar · {npc:3706} Tai'jin · {area:362} Razor Hill · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1411}, {npc:3706}, the priest trainer inside the barracks of {area:362}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "Mit 10 gibt dir in {zone:1411} {npc:3706}, der Priesterlehrer in der Kaserne von {area:362}, einen Brief {spell:2652} für {npc:4606} in der {zone:1458}.",
	-- {npc:3706} Tai'jin · {spell:2652} Touch of Weakness
	["{npc:3706}: take his {spell:2652} letter"] = "{npc:3706}: Nimm seinen Brief {spell:2652} an",

	-- Step 2: Touch of Weakness: Ur'kyo
	-- {zone:1454} Orgrimmar · {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity · {zone:1420} Tirisfal Glades
	["At 10 in {zone:1454}, {npc:6018} in the {object:172961} hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}. The zeppelin to {zone:1420} leaves from the tower outside {zone:1454}'s front gate."] = "Mit 10 gibt dir in {zone:1454} {npc:6018} im {object:172961} einen Brief {spell:2652} für {npc:4606} in der {zone:1458}. Der Zeppelin nach {zone:1420} startet am Turm vor dem Haupttor von {zone:1454}.",
	-- {npc:6018} Ur'kyo · {spell:2652} Touch of Weakness
	["{npc:6018}: take his {spell:2652} letter"] = "{npc:6018}: Nimm seinen Brief {spell:2652} an",

	-- Step 3: Touch of Weakness: Var'jun
	-- {zone:1412} Mulgore · {npc:11407} Var'jun · {area:222} Bloodhoof Village · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1412}, {npc:11407}, just south-west of {area:222}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "Mit 10 gibt dir in {zone:1412} {npc:11407}, südwestlich von {area:222}, einen Brief {spell:2652} für {npc:4606} in der {zone:1458}.",
	-- {npc:11407} Var'jun · {spell:2652} Touch of Weakness
	["{npc:11407}: take the {spell:2652} letter"] = "{npc:11407}: Nimm den Brief {spell:2652} an",

	-- Step 4: Touch of Weakness: Miles Welsh
	-- {zone:1456} Thunder Bluff · {npc:3044} Miles Welsh · {area:1640} Spirit Rise · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1456}, {npc:3044}, the priest trainer in the cave under {area:1640}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "Mit 10 gibt dir in {zone:1456} {npc:3044}, der Priesterlehrer in der Höhle unter {area:1640}, einen Brief {spell:2652} für {npc:4606} in der {zone:1458}.",
	-- {npc:3044} Miles Welsh · {spell:2652} Touch of Weakness
	["{npc:3044}: take his {spell:2652} letter"] = "{npc:3044}: Nimm seinen Brief {spell:2652} an",

	-- Step 5: Touch of Weakness: Aelthalyste
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {quest:5658} Touch of Weakness · {area:159} Brill
	["At 10, go to {npc:4606}, the priest trainer in the {zone:1458}'s {object:36070}: she gives {quest:5658} and takes it back at once. No letter needed. From {area:159}, follow the road south to the ruined city of Lordaeron; the {zone:1458}'s lifts are at the back of the throne room. {quest:5658} strikes the next melee attacker for Shadow damage and lowers its melee attack power for 2 minutes."] = "Geh mit 10 zu {npc:4606}, der Priesterlehrerin im {object:36070} der {zone:1458}: Sie gibt dir {quest:5658} und nimmt sie sofort zurück. Kein Brief nötig. Von {area:159} aus folgst du der Straße nach Süden zur zerstörten Stadt Lordaeron; die Aufzüge der {zone:1458} liegen hinten im Thronsaal. {quest:5658} trifft den nächsten Nahkampfangreifer mit Schattenschaden und senkt seine Nahkampf-Angriffskraft für 2 Minuten.",

	-- Step 6: Touch of Weakness: Tai'jin's letter
	-- {quest:5660} Touch of Weakness · {npc:3706} Tai'jin
	["{quest:5660}: {npc:3706}'s letter"] = "{quest:5660}: der Brief von {npc:3706}",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: the zeppelin from the tower outside {zone:1454} lands in {zone:1420}, a short walk from the {zone:1458}."] = "Gib den Brief bei {npc:4606} im {object:36070} der {zone:1458} ab: Der Zeppelin vom Turm vor {zone:1454} landet in {zone:1420}, ein kurzes Stück von der {zone:1458} entfernt.",

	-- Step 7: Touch of Weakness: Var'jun's letter
	-- {quest:5661} Touch of Weakness · {npc:11407} Var'jun
	["{quest:5661}: {npc:11407}'s letter"] = "{quest:5661}: der Brief von {npc:11407}",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: travel to {zone:1454} and take the zeppelin to {zone:1420}."] = "Gib den Brief bei {npc:4606} im {object:36070} der {zone:1458} ab: Reise nach {zone:1454} und nimm den Zeppelin nach {zone:1420}.",

	-- Step 8: Touch of Weakness: Ur'kyo's letter
	-- {quest:5662} Touch of Weakness · {npc:6018} Ur'kyo
	["{quest:5662}: {npc:6018}'s letter"] = "{quest:5662}: der Brief von {npc:6018}",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: the zeppelin from the tower outside {zone:1454} lands in {zone:1420}."] = "Gib den Brief bei {npc:4606} im {object:36070} der {zone:1458} ab: Der Zeppelin vom Turm vor {zone:1454} landet in {zone:1420}.",

	-- Step 9: Touch of Weakness: Miles Welsh's letter
	-- {quest:5663} Touch of Weakness · {npc:3044} Miles Welsh
	["{quest:5663}: {npc:3044}'s letter"] = "{quest:5663}: der Brief von {npc:3044}",

	-- Step 10: Dark Sacrifice: Ur'kyo
	-- {zone:1454} Orgrimmar · {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {quest:5644} Dark Sacrifice · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 20 in {zone:1454}, {npc:6018} in the {object:172961} hands you a {quest:5644} letter for {npc:4606} in the {zone:1458}."] = "Mit 20 gibt dir in {zone:1454} {npc:6018} im {object:172961} einen Brief {quest:5644} für {npc:4606} in der {zone:1458}.",
	-- {npc:6018} Ur'kyo · {quest:5644} Dark Sacrifice
	["{npc:6018}: take his {quest:5644} letter"] = "{npc:6018}: Nimm seinen Brief {quest:5644} an",

	-- Step 11: Dark Sacrifice: Miles Welsh
	-- {zone:1456} Thunder Bluff · {npc:3044} Miles Welsh · {area:1640} Spirit Rise · {quest:5644} Dark Sacrifice · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 20 in {zone:1456}, {npc:3044} in the cave under {area:1640} hands you a {quest:5644} letter for {npc:4606} in the {zone:1458}."] = "Mit 20 gibt dir in {zone:1456} {npc:3044} in der Höhle unter {area:1640} einen Brief {quest:5644} für {npc:4606} in der {zone:1458}.",
	-- {npc:3044} Miles Welsh · {quest:5644} Dark Sacrifice
	["{npc:3044}: take his {quest:5644} letter"] = "{npc:3044}: Nimm seinen Brief {quest:5644} an",

	-- Step 12: Dark Sacrifice: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter · {quest:5644} Dark Sacrifice · {spell:2944} Devouring Plague
	["At 20, {npc:4606} in the {object:36070} teaches {quest:5644} with a quest she gives and takes back at once (its text still speaks of {spell:2944}, which every priest now learns from the trainer)."] = "Mit 20 bringt dir {npc:4606} im {object:36070} {quest:5644} mit einer Quest bei, die sie dir gibt und sofort zurücknimmt (ihr Text spricht noch von {spell:2944}, das jetzt jeder Priester beim Lehrer lernt).",

	-- Step 13: Dark Sacrifice: Ur'kyo's letter
	-- {quest:5646} Dark Sacrifice · {npc:6018} Ur'kyo
	["{quest:5646}: {npc:6018}'s letter"] = "{quest:5646}: der Brief von {npc:6018}",

	-- Step 14: Dark Sacrifice: Miles Welsh's letter
	-- {quest:5644} Dark Sacrifice · {npc:3044} Miles Welsh
	["{quest:5644}: {npc:3044}'s letter"] = "{quest:5644}: der Brief von {npc:3044}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:4606} in the {zone:1458}'s {object:36070}. Priest trainers elsewhere ({npc:6018} in {zone:1454}, {npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to her with a quest of the same name."] = "Geh mit Stufe 10 zu {npc:4606} im {object:36070} von {zone:1458}. Priesterlehrer anderswo ({npc:6018} in {zone:1454}, {npc:3706} am {area:362}, {npc:3044} in {zone:1456}) schicken dich mit einer gleichnamigen Quest zu ihr.",
	-- ["At 20, {npc:4606} teaches {quest:5644}. {npc:6018} in {zone:1454} and {npc:3044} in {zone:1456} send you to her with a quest of the same name."] = "Mit Stufe 20 lehrt {npc:4606} {quest:5644}. {npc:6018} in {zone:1454} und {npc:3044} in {zone:1456} schicken dich mit einer gleichnamigen Quest zu ihr.",
	-- ["The Undead priest spells: {spell:2652} at 10, {quest:5644} at 20."] = "Die Priesterzauber der Untoten: {spell:2652} mit Stufe 10, {quest:5644} mit Stufe 20.",
}
