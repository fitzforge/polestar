-- German (deDE): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "",

	-- Step 2: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 3: The Emerald Sanctuary
	-- {area:415} Astranaar · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}, in den Ruinen gleich östlich von {npc:11554}",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "",

	-- Step 4: Grazle
	-- {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["{npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "",

	-- Step 5: Deadwood Village
	-- {npc:11554} Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Die Furbolgs der Totenwaldfelle leben im Dorf gleich südwestlich von {npc:11554}; behalte die Kopfputzfedern der Totenwaldfelle, die sie fallen lassen.",

	-- Step 6: Level 52.58
	["Level 52.58"] = "",
	-- {item:9328} Super Snapper FX · {area:1417} Sunken Temple · {area:2100} Maraudon
	["If you skipped The Horn of the Beast or The {item:9328}, grind here to level 52.58 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",
	-- {npc:7153} Deadwood Warrior
	["grind on {npc:7153}"] = "",

	-- Step 7: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395} wartet am Nordende des {zone:1448}",
	["Five feathers buy a little Timbermaw reputation"] = "Fünf Federn bringen ein wenig Ruf bei der Holzschlundfeste",

	-- Step 8: Level 52.69
	["Level 52.69"] = "",
	-- {area:1763} Jaedenar · {area:1417} Sunken Temple · {area:2100} Maraudon
	["Top up here to level 52.69 before the hand-ins at {area:1763}: they take you to level 53. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",
	-- {npc:7155} Deadwood Pathfinder
	["grind on {npc:7155}"] = "",

	-- Step 9: Jadefire Glen
	-- {npc:9454} Xavathras · {spell:7992} Slowing Poison
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker · Cursed Oozes = {npc:7086} Cursed Ooze
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back.\nCareful: Jadefire Shadowstalkers (level 51-52) use Sneak and {spell:7992} and are stealthed, so they often join fights uninvited.\nCursed Oozes slide about the glen's streams: kill them and use Laris's Empty Ooze Jar on their remains."] = "",
	-- {npc:7109} Jadefire Felsworn
	["grind on {npc:7109}"] = "",

	-- Step 11: Jaedenar
	-- {area:1763} Jaedenar
	["{area:1763} is the ruined temple north of the glen."] = "",
	-- {item:11949} Filled Tainted Ooze Jar · {area:1763} Jaedenar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{item:11949}: Tainted Oozes slide about {area:1763}'s fel pools"] = "",
	-- {npc:7125} Jaedenar Hound
	["grind on {npc:7125}"] = "",

	-- Step 12: Level 52.9
	["Level 52.9"] = "",
	-- {area:2479} Emerald Sanctuary · {area:1417} Sunken Temple · {area:2100} Maraudon
	["Top up here to level 52.9 before the hand-ins at {area:2479}: they take you to level 53. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",

	-- Step 14: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "Folge der Straße nach Norden ins Kratertal und geh zu jedem Krater; töte dabei die Entropischen Bestien und Schrecken dazwischen.",
	["First crater"] = "Erster Krater",
	["Second crater"] = "Zweiter Krater",
	["Third crater"] = "Dritter Krater",

	-- Step 15: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "Die Wucherborkentreants im {area:1767}, östlich der {area:2618}, tragen die {item:11503}.",
	["Below ground"] = "",

	-- Step 16: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Follow the road north to the cave mouth of {area:1769}; {npc:15395} guards it."] = "Folge der Straße nach Norden zum Höhleneingang der {area:1769}; {npc:15395} bewacht ihn.",

	-- Step 17: Felpaw Village
	-- {area:1762} Felpaw Village · {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "",

	-- Step 18: Nafien
	-- {zone:1452} Winterspring
	["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Salfa steht am Ende des Tunnels in {zone:1452}: Behalte es",

	-- Step 20: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "",

	-- Step 21: Jadefire Run: kill these as you meet them
	-- {area:2618} Jadefire Run
	["{area:2618}: kill these as you meet them"] = "",
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618} ist das Satyrtal im Nordwesten, mit {npc:10648} an seinem hinteren Ende. Er lässt {quest:939} fallen; jeder Jadefeuersatyr kann {item:11674} fallen lassen.",

	-- Step 22: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "Wieder {area:1763}",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}."] = "",

	-- Step 23: The Emerald Sanctuary
	-- {area:1763} Jaedenar · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Ride south-east from {area:1763} to the {area:2479}, the druids' camp by the road in southern {zone:1448}."] = "",

	-- Step 24: The Emerald Sanctuary
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}: keep it; inside"] = "",
	-- {zone:1413} Barrens
	["Ends in the {zone:1413}: keep it"] = "Endet im {zone:1413}: Behalte es",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "Flieg von {area:1998} zum Ende der Straße beim Refugium oder reite sie nach Süden entlang.",
	-- ["Keep her alive until she is out of the cave"] = "Halte sie am Leben, bis sie aus der Höhle ist",
	-- ["Oozes"] = "Schlammbestien",
	-- ["Ride east to the night elf camp at {area:1998}."] = "Reite nach Osten zum Nachtelfenlager in {area:1998}.",
	-- ["Ride north out of {area:415} into {zone:1448}. {npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "Reite nach Norden aus {area:415} hinaus in den {zone:1448}. {npc:11554}, der Furbolg, steht an der Straße gleich südlich des {area:2479}.",
	-- ["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "Reite nach Norden zur {area:1769} (oder flieg erst zurück nach {area:1998}) und durch den Tunnel nach {zone:1452}; folge der Straße nach Osten zur Goblinstadt {area:2255}.",
	-- ["Step into the cave: {npc:11558} and {npc:11557} stand just inside."] = "Betritt die Höhle: {npc:11558} und {npc:11557} stehen gleich hinter dem Eingang.",
	-- ["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "Nimm das Boot von {area:702} nach {area:442} und flieg nach {area:415}.",
	-- ["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "Die Verfluchten und Besudelten Brühschlammer gleiten durch die Bäche und Teufelstümpel um {area:1763} und {area:1765}: Töte sie und benutze Laris' leere Schlammgefäße an ihren Überresten.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "Die Furbolgs der Totenwaldfelle im {area:1762} füllen die Hügel westlich der Höhle. Die Rächer können ein {quest:8470} fallen lassen.",
	-- ["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "Die Jadefeuersatyrn halten das Tal westlich der Straße, mit {npc:9454} im hinteren Teil.",
	-- ["The vial is filled in {zone:1457}: keep it"] = "Die Phiole wird in {zone:1457} gefüllt: Behalte es",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "Benutze die {item:12922} am verderbten Mondbrunnen mitten in {area:1763}. Hast du {npc:11018} befreit, geh zurück in {area:1770} zum Sukkubus {npc:9518}; die Überreste von Trey Lightforge liegen neben ihr.",
	-- ["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763} ist der verfallene Tempel nördlich des Tals. Manche seiner Kultisten lassen einen {item:13140} fallen, etwa einer von dreißig: Er öffnet die Zelle von {npc:11018} in {area:1770}, der Höhle im hinteren Teil. Fällt er, säubere den Weg nach draußen, bevor du sie befreist; sonst überspring ihre Quests.",
	-- ["{item:13140}, a rare drop"] = "{item:13140}, seltene Beute",
	-- ["{npc:11016}, in {area:1770}"] = "{npc:11016}, in {area:1770}",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}: dreißig {quest:6031}, abgegeben, wenn du mit 57 wieder durchkommst",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral"] = "{npc:11558}: Die Holzschlundfeste spricht erst ab Neutral mit dir",
	-- ["{npc:15395} waits at the north end of {area:361}"] = "{npc:15395} wartet am Nordende des {area:361}",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, seltene Beute",
}
