-- German (deDE): the guide forever/class/paladin/tyrs-watch (forever/class/paladin/tyrs-watch.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["Tyr's Watch and {spell:7328}"] = "Tyr's Watch und {spell:7328}",
	-- {spell:7328} Redemption
	["{spell:7328} to raise fallen allies, plus a weapon and a shield for a new Forsaken paladin."] = "{spell:7328}, um gefallene Verbündete wiederzubeleben, dazu eine Waffe und ein Schild für einen neuen verlassenen Paladin.",

	-- Step 1: Shari Stilwell
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152}, who trains Paladins in {area:159}, sends you to the order's keep on the west coast."] = "{npc:246152}, die in {area:159} Paladine ausbildet, schickt dich zur Feste des Ordens an der Westküste.",

	-- Step 2: Bandarion Keep
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {npc:246349} Breton Samuels
	["{area:16602} stands on the bluffs north-west of the {area:156}. {npc:246349} waits at the gate."] = "{area:16602} steht auf den Klippen nordwestlich von {area:156}. {npc:246349} wartet am Tor.",

	-- Step 3: Murlocs at the Gates
	["The Vile Fin murlocs lurk on the bluffs along the road east of the keep and in the camps around the lake to the west."] = "Die Murlocs der Finsterflossen lauern auf den Klippen entlang der Straße östlich der Feste und in den Lagern rund um den See im Westen.",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers"] = "Angreifer der Finsterflossen",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers"] = "Seher der Finsterflossen",

	-- Step 5: Danitha Morr
	-- {npc:246378} Danitha Morr · {npc:246393} Jorin Croge
	["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it."] = "{npc:246378} führt den Orden aus dem Inneren der Feste; {npc:246393} steht daneben.",

	-- Step 6: Shadowvale
	-- {quest:91317} The Tarnished · {area:16881} Shadowvale · {area:16616} Whispering Forest · {item:246213} Sturdy Lumber · {npc:259431} Rudolph Gelhardt
	["{quest:91317} hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. The {item:246213} is piled in the root cellar of one of its houses; Commander {npc:259431} walks among his Tarnished."] = "{quest:91317} halten das zerstörte Dorf {area:16881} in {area:16616}, südwestlich der Feste. {item:246213} ist im Wurzelkeller eines der Häuser gestapelt; Kommandant {npc:259431} geht zwischen seinen Befleckten umher.",
	-- {object:554626} Lumber Pile
	["{object:554626}, in the root cellar"] = "{object:554626}, im Wurzelkeller",
	-- plural, as words: Tarnished Drudges = {npc:259434} Tarnished Drudge
	["Tarnished Drudges"] = "Befleckte Akkordarbeiter",
	-- plural, as words: Tarnished Zealots = {npc:259433} Tarnished Zealot
	["Tarnished Zealots"] = "Befleckte Fanatiker",

	-- Step 7: Back to the keep
	["Back to the keep"] = "Zurück zur Feste",

	-- Step 8: A Lesson in Divinity
	-- {npc:246378} Danitha Morr
	["{npc:246378} offers the first Lesson in Divinity at level 12."] = "{npc:246378} bietet die erste Lektion in Sachen Göttlichkeit mit Stufe 12 an.",

	-- Step 9: The Undercity
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {npc:257648} Tanis Alderwood · {object:36078} Trade Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:10181} holds court in the {object:36126}; {npc:257648} begs in the {object:36078}."] = "Geh von {area:159} nach Süden zu {area:153} und hinab nach {zone:1458}. {npc:10181} hält in {object:36126} Hof; {npc:257648} bettelt in {object:36078}.",

	-- Step 10: Linen Cloth
	-- {npc:257648} Tanis Alderwood · {item:2589} Linen Cloth
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot · Scarlet Friars = {npc:1538} Scarlet Friar
	["{npc:257648} needs 10 {item:2589}. Scarlet Zealots and Scarlet Friars drop it about three times in ten; bring it along if you already carry some."] = "{npc:257648} braucht 10 {item:2589}. Scharlachrote Zeloten und Scharlachrote Ordensmitglieder lassen es etwa dreimal von zehn fallen; bring es mit, falls du schon welches dabeihast.",

	-- Step 12: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "{item:6866}",
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {item:6866} Symbol of Life · {npc:257655} Deathguard Billmuth
	["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep."] = "Zurück nach {area:16602}. {npc:246378} gibt dir {item:6866}; {npc:257655} wartet unten in der Feste.",

	-- Step 13: Deathguard Falgan
	-- {area:812} Venomweb Vale · {item:6866} Symbol of Life · {npc:257663} Deathguard Falgan · {npc:246378} Danitha Morr
	["{area:812} is at the far east end of the glades. Use the {item:6866} on {npc:257663}, then speak to him. If you lose the symbol, {npc:246378} gives you another."] = "{area:812} liegt am äußersten Ostende der Lichtungen. Benutze {item:6866} an {npc:257663} und sprich dann mit ihm. Verlierst du das Symbol, gibt dir {npc:246378} ein neues.",

	-- Step 14: The Scarlet attack plans
	["The Scarlet attack plans"] = "Die Angriffspläne des Scharlachroten Kreuzzugs",
	-- {area:812} Venomweb Vale
	-- plural, as words: Scarlet Crusaders = {npc:239036} Scarlet Crusader
	["The Scarlet Crusaders camped around {area:812} carry the attack plans."] = "Die Scharlachroten Kreuzfahrer, die rund um {area:812} lagern, tragen die Angriffspläne.",

	-- Step 15: Redemption
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {spell:7328} Redemption
	["Back to {area:16602}: Billmuth takes the plans, {npc:246378} teaches you {spell:7328}."] = "Zurück nach {area:16602}: Billmuth nimmt die Pläne, {npc:246378} lehrt dich {spell:7328}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{object:181686}, in the root cellar"] = "{object:181686}, im Wurzelkeller",
}
