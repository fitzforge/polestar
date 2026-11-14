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
	["Fly to {area:415}"] = "Flieg nach {area:415}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Flugmeister von {area:702}",

	-- Step 2: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 3: The Emerald Sanctuary
	-- {area:415} Astranaar · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "Reite von {area:415} nach Norden hinaus nach {zone:1448} zum {area:2479}, dem Lager der Druiden an der Straße.",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}, in den Ruinen gleich östlich von {npc:11554}",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, drinnen",

	-- Step 4: Grazle
	-- {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["{npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "{npc:11554} der Furbolg steht an der Straße, gleich südlich vom {area:2479}.",

	-- Step 5: Deadwood Village
	-- {npc:11554} Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Die Furbolgs der Totenwaldfelle leben im Dorf gleich südwestlich von {npc:11554}; behalte die Kopfputzfedern der Totenwaldfelle, die sie fallen lassen.",

	-- Step 6: Level 52.58
	["Level 52.58"] = "Stufe 52,58",
	-- {item:9328} Super Snapper FX
	["If you skipped The Horn of the Beast or The {item:9328}, grind here to level 52.58 to stay on the route's plan."] = "Wenn du The Horn of the Beast oder The {item:9328} übersprungen hast, grinde hier bis Stufe 52,58, um im Plan der Route zu bleiben.",
	-- {npc:7153} Deadwood Warrior
	["grind on {npc:7153}"] = "Grinde an {npc:7153}",

	-- Step 7: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395} wartet am Nordende des {zone:1448}",

	-- Step 8: Level 52.69
	["Level 52.69"] = "Stufe 52,69",
	-- {area:1763} Jaedenar
	["Top up here to level 52.69 before the hand-ins at {area:1763}: they take you to level 53."] = "Grinde hier bis Stufe 52,69, bevor du bei {area:1763} abgibst: Das bringt dich auf Stufe 53.",
	-- {npc:7155} Deadwood Pathfinder
	["grind on {npc:7155}"] = "Grinde an {npc:7155}",

	-- Step 9: Jadefire Glen
	-- {npc:9454} Xavathras · {spell:7992} Slowing Poison
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker · Cursed Oozes = {npc:7086} Cursed Ooze
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back.\nCareful: Jadefire Shadowstalkers (level 51-52) use Sneak and {spell:7992} and are stealthed, so they often join fights uninvited.\nCursed Oozes slide about the glen's streams: kill them and use Laris's Empty Ooze Jar on their remains."] = "Die Satyrn von Jadefire halten das Tal westlich der Straße, mit {npc:9454} an dessen Ende.\nVorsicht: Jadefire Shadowstalkers (Stufe 51-52) nutzen Sneak und {spell:7992} und sind getarnt, sodass sie oft ungebeten in Kämpfe geraten.\nCursed Oozes gleiten durch die Bäche des Tals: Töte sie und benutze Laris's Empty Ooze Jar an ihren Überresten.",
	-- {npc:7109} Jadefire Felsworn
	["grind on {npc:7109}"] = "Grinde an {npc:7109}",

	-- Step 11: Jaedenar
	-- {area:1763} Jaedenar
	["{area:1763} is the ruined temple north of the glen."] = "{area:1763} ist der zerstörte Tempel nördlich des Tals.",
	-- {item:11949} Filled Tainted Ooze Jar · {area:1763} Jaedenar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{item:11949}: Tainted Oozes slide about {area:1763}'s fel pools"] = "{item:11949}: Tainted Oozes gleiten durch die Teufelsteiche von {area:1763}",

	-- Step 13: Level 52.9
	["Level 52.9"] = "Stufe 52,9",
	-- {area:2479} Emerald Sanctuary · {area:1766} Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Still short of level 52.9 after the {area:2479}'s hand-ins? Top up on the Entropic Beasts in {area:1766}, the next stop north."] = "Nach den Abgaben im {area:2479} noch unter Stufe 52,9? Hol dir den Rest an den Entropic Beasts in {area:1766}, dem nächsten Halt im Norden.",
	-- {npc:9878} Entropic Beast
	["grind on {npc:9878}"] = "Grinde an {npc:9878}",

	-- Step 14: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "Folge der Straße nach Norden ins Kratertal und geh zu jedem Krater; töte dabei die Entropischen Bestien und Schrecken dazwischen.",
	["First crater"] = "Erster Krater",
	["Second crater"] = "Zweiter Krater",
	["Third crater"] = "Dritter Krater",

	-- Step 15: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "Die Wucherborkentreants im {area:1767}, östlich der {area:2618}, tragen die {item:11503}.",
	["Below ground"] = "Unter der Erde",

	-- Step 16: Jadefire Run: kill these as you meet them
	-- {area:2618} Jadefire Run
	["{area:2618}: kill these as you meet them"] = "{area:2618}: Töte sie, wenn du ihnen begegnest",
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618} ist das Satyrtal im Nordwesten, mit {npc:10648} an seinem hinteren Ende. Er lässt {quest:939} fallen; jeder Jadefeuersatyr kann {item:11674} fallen lassen.",

	-- Step 17: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "Wieder {area:1763}",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}."] = "Benutze {item:12922} am verderbten Mondbrunnen mitten in {area:1763}.",

	-- Step 18: The Emerald Sanctuary
	-- {area:1763} Jaedenar · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Ride south-east from {area:1763} to the {area:2479}, the druids' camp by the road in southern {zone:1448}."] = "Reite von {area:1763} nach Südosten zum {area:2479}, dem Lager der Druiden an der Straße im Süden von {zone:1448}.",

	-- Step 19: The Emerald Sanctuary
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}: keep it; inside"] = "Die Phiole wird in {zone:1457} gefüllt: Behalte sie; drinnen",
	-- {zone:1413} Barrens
	["Ends in the {zone:1413}: keep it"] = "Endet im {zone:1413}: Behalte es",
	-- {npc:10924} Ivy Leafrunner · {npc:11079} Wynd Nightchaser · {zone:1452} Winterspring
	["{npc:10924}: for {npc:11079} in {zone:1452}, keep it"] = "{npc:10924}: für {npc:11079} in {zone:1452}, behalte es",

	-- Step 20: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Ride north up the road from the Sanctuary, all the way to the cave mouth of {area:1769}; {npc:15395} guards it."] = "Reite vom Heiligtum die Straße nach Norden hinauf, ganz bis zum Höhleneingang der {area:1769}; {npc:15395} bewacht ihn.",

	-- Step 21: Felpaw Village
	-- {area:1762} Felpaw Village · {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Die Deadwood-Furbolgs von {area:1762} bevölkern die Hügel westlich der Höhle. Töte sie weiter, bis einer ein {quest:8470} fallen lässt, etwa bei jedem dreißigsten Kill, und klicke es dann mit Rechtsklick an: {npc:11558} in {area:1769} nimmt es an, sobald die Timbermaw dir gegenüber Neutral sind, jetzt, falls sie es schon sind, oder wenn dich der letzte Guide wieder an der Höhle vorbeiführt, bei 58.\nVorsicht: Die Den Watchers sind Stufe 53-54; sie rufen nahe Verbündete in 25 yd Umkreis, sobald sie unter 50 % Gesundheit sind, und laufen unter 15 % davon, um Hilfe zu holen.",

	-- Step 22: Nafien
	-- {zone:1452} Winterspring
	["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Salfa steht am Ende des Tunnels in {zone:1452}: Behalte es",

	-- Step 24: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside."] = "Betritt die Höhle: {npc:11558} steht gleich hinter dem Eingang.",
	-- {npc:11558} Kernda
	["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}: Die Timbermaw sprechen nur ab Neutral mit dir; läuft hier umher: Schau in den Kreis auf der Karte",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Five feathers buy a little Timbermaw reputation"] = "Fünf Federn bringen ein wenig Ruf bei der Holzschlundfeste",
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
	-- ["Top up here to level 52.9 before the hand-ins at {area:2479}: they take you to level 53. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Grinde hier bis Stufe 52,9, bevor du bei {area:2479} abgibst: Das bringt dich auf Stufe 53. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:1417} oder den Dungeon {area:2100}.",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "Benutze die {item:12922} am verderbten Mondbrunnen mitten in {area:1763}. Hast du {npc:11018} befreit, geh zurück in {area:1770} zum Sukkubus {npc:9518}; die Überreste von Trey Lightforge liegen neben ihr.",
	-- ["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763} ist der verfallene Tempel nördlich des Tals. Manche seiner Kultisten lassen einen {item:13140} fallen, etwa einer von dreißig: Er öffnet die Zelle von {npc:11018} in {area:1770}, der Höhle im hinteren Teil. Fällt er, säubere den Weg nach draußen, bevor du sie befreist; sonst überspring ihre Quests.",
	-- ["{item:13140}, a rare drop"] = "{item:13140}, seltene Beute",
	-- ["{npc:11016}, in {area:1770}"] = "{npc:11016}, in {area:1770}",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}: dreißig {quest:6031}, abgegeben, wenn du mit 57 wieder durchkommst",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral"] = "{npc:11558}: Die Holzschlundfeste spricht erst ab Neutral mit dir",
	-- ["{npc:15395} waits at the north end of {area:361}"] = "{npc:15395} wartet am Nordende des {area:361}",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, seltene Beute",
}
