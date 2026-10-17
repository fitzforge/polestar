-- Spanish (Latin America) (esMX): the guide forever/class/rogue/certificate-of-thievery (forever/class/rogue/certificate-of-thievery.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6966} Lucius · {quest:2282} Alther's Mill · {quest:2300} SI:7
	["Your first lockpicking job at 16: {npc:6966}'s lockbox at {quest:2282}, for {quest:2300}."] = "Tu primer trabajo de forzar cerraduras a nivel 16: la caja fuerte de {npc:6966} en {quest:2282}, para {quest:2300}.",

	-- Step 1: SI:7 (Goldshire)
	-- {npc:917} Keryn Sylvius · {area:87} Goldshire · {npc:6946} Renzik "The Shiv" · {zone:1453} Stormwind
	["At 16 {npc:917}, the rogue trainer in the Lion's Pride Inn in {area:87}, sends you to {npc:6946} in {zone:1453}."] = "A nivel 16, {npc:917}, el instructor de pícaros de la Posada Orgullo de León en {area:87}, te envía con {npc:6946} en {zone:1453}.",

	-- Step 2: To Hulfdan! (Kharanos)
	-- {npc:1234} Hogral Bakkan · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 16 {npc:1234} in the {area:2102} in {area:131} sends you to {npc:5165}, in the north of {zone:1455}."] = "A nivel 16, {npc:1234}, en {area:2102} de {area:131}, te envía con {npc:5165}, en el norte de {zone:1455}.",

	-- Step 4: Erion Shadewhisper (Dolanaar)
	-- {npc:3599} Jannok Breezesong · {area:186} Dolanaar · {quest:2259} Erion Shadewhisper · {zone:1457} Darnassus
	["At 16 {npc:3599} in {area:186} sends you to {quest:2259} in {zone:1457}."] = "A nivel 16, {npc:3599}, en {area:186}, te envía con {quest:2259} en {zone:1457}.",

	-- Step 5: Renzik "The Shiv"
	-- {npc:6946} Renzik "The Shiv" · {npc:332} Master Mathias Shaw · {quest:2300} SI:7 · {object:2100} Old Town · {area:2257} Deeprun Tram · {zone:1455} Ironforge · {area:442} Auberdine · {area:17203} Stormwind Harbor
	["{npc:6946} stands beside {npc:332} at {quest:2300} in {object:2100}. Dwarves and Gnomes take the {area:2257} from {zone:1455}; Night Elves take the boat from {area:442} to {area:17203}."] = "{npc:6946} está junto a {npc:332} en {quest:2300}, en {object:2100}. Los enanos y gnomos toman el {area:2257} desde {zone:1455}; los elfos de la noche toman el barco de {area:442} a {area:17203}.",

	-- Step 6: Lucius
	-- {zone:1429} Elwynn Forest · {area:69} Lakeshire · {npc:6966} Lucius · {item:5060} Thieves' Tools
	["Ride east through {zone:1429} into Redridge, or fly to {area:69}. {npc:6966} waits on the west side of {area:69} and gives you {item:5060}."] = "Cabalga hacia el este por {zone:1429} hasta las Montañas Crestagrana, o vuela a {area:69}. {npc:6966} espera en el lado oeste de {area:69} y te da {item:5060}.",

	-- Step 7: Alther's Mill
	-- {quest:2282} Alther's Mill · {area:69} Lakeshire · {object:121264} Lucius's Lockbox
	["{quest:2282} stands east of {area:69}, up off the road. Open {object:121264} there."] = "{quest:2282} está al este de {area:69}, arriba, fuera del camino. Abre ahí {object:121264}.",

	-- Step 8: Back to Lucius
	-- {npc:6966} Lucius
	["Back to {npc:6966}"] = "Regresa con {npc:6966}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{quest:2282} stands east of {area:69}, up off the road. Open {item:7869} there."] = "{quest:2282} está al este de {area:69}, arriba, fuera del camino. Abre ahí {item:7869}.",
}
