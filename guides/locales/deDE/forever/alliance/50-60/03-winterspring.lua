-- German (deDE): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Everlook
	-- {npc:11629} Jessica Redpath · {area:2262} Darrowshire
	["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}: für {area:2262} behalten",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}: beide für die Pestländer behalten",

	-- Step 2: Starfall Village
	["Ride west along the road to the night elf village."] = "Reite auf der Straße nach Westen zum Nachtelfendorf.",

	-- Step 3: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "Die Ruinen liegen um den gefrorenen See südlich von {area:2253}. Sammle die vier Reliktfragmente in den Ruinen und die Mondbestrahlten Federn am Boden, wo die Wildekin umherstreifen.",

	-- Step 4: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Folge der Straße nach Westen zu {npc:9298}s Lager neben den heißen Quellen.",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Behalten: Gregan in {zone:1444} braut das Elixier später",

	-- Step 5: Salfa
	-- {npc:11556} Salfa · {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden
	["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} bewacht den Eingang von {area:1769}, nordwestlich von {npc:9298}.",

	-- Step 6: The Winterfall camp
	["The Winterfall camp"] = "Das Lager der Winterfelle",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {quest:6031} Runecloth
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "Das westliche Lager der Winterfelle liegt in den Hügeln zwischen {npc:11556} und {npc:9298}. Jeder Furbolg hier kann {item:12771} (etwa einer von zehn) und selten {quest:8471} fallen lassen: Rechtsklicke, was immer fällt. Behalte {quest:6031}, das die Furbolgs fallen lassen, für Meilosh.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}, a rare drop"] = "{item:12771}, eine seltene Beute",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop"] = "{quest:8471}, eine seltene Beute",
	-- {area:1769} Timbermaw Hold
	["For Kernda in {area:1769}: keep it"] = "Für Kernda in {area:1769}: behalten",
	-- {quest:6031} Runecloth
	["{quest:6031}, for Meilosh later"] = "{quest:6031}, später für Meilosh",

	-- Step 7: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "Der Kessel der Totenwaldfelle in {zone:1448}: behalten",

	-- Step 8: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "Das Furbolgdorf der Winterfelle liegt östlich von {area:2255}: Schamanen (56-57), Höhlenbehüter (55-56) und Ursas (57-58), alle über deiner Stufe. Töte zuerst die Schamanen, sie heilen, und lock vom Rand aus. {npc:10738} in der Höhle hinten ist Elite: Bleib draußen.",

	-- Step 9: The Ice Thistle Hills
	-- {area:2247} Ice Thistle Hills
	["The {area:2247}"] = "{area:2247}",
	-- {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Eisdistelyetis leben in den Hügeln südlich von {area:2244}, Eiswindschimären im Tal Richtung {area:2255}.",

	-- Step 11: Optional: Sunken Temple
	-- {area:1417} Sunken Temple
	["Optional: {area:1417}"] = "Optional: {area:1417}",
	-- {area:1417} Sunken Temple · {area:2255} Everlook
	["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "Nach den Yetis noch nicht Stufe 54? {area:1417} (50-54) in einer Gruppe statt Grinden bringt dich schneller dorthin. Kehr danach nach {area:2255} zurück.",

	-- Step 12: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Makellose Yetihörner",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "Zurück in die Hügel: Nur die Eisdistelmatriarchinnen und Eisdistelpatriarchen tragen die Hörner. Töte weiter Yetis bis Stufe 54: Harlos Wildekinquests sind vorher rot.",
	-- {npc:7460} Ice Thistle Patriarch · {area:2247} Ice Thistle Hills · {zone:1452} Winterspring
	["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "grinde {npc:7460} bei {area:2247}, {zone:1452}",

	-- Step 13: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "Bei {npc:10978}, am Gasthaus",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583} und {npc:10977} folgen später",

	-- Step 14: Starfall Village
	-- {npc:10301} Jaron Stoneshaper
	["Ride west along the road to {npc:10301}."] = "Reite auf der Straße nach Westen zu {npc:10301}.",

	-- Step 15: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "{npc:10301}s Lager",
	-- {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Reite nach Südosten das Tal hinunter zu {npc:10301}s beschädigter Kiste im Schnee bei {area:2245}; sein zerstörter Wagen steht gleich östlich davon.",

	-- Step 16: Jaron Stoneshaper's supplies
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s supplies"] = "{npc:10301}s Vorräte",
	-- {npc:10301} Jaron Stoneshaper
	["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Sammle die Vorräte um den Wagen auf und hol dir {npc:10301}s Amulett von den Eulenbestien in der Nähe zurück.",

	-- Step 17: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Folge {npc:9298}s Wegbeschreibung zum Eingang von {area:2256}, vorbei an den Frosthagelriesen: Passiere sie einzeln.",

	-- Step 18: Starfall Village
	["Ride north-west back to the village."] = "Reite nach Nordwesten zurück ins Dorf.",

	-- Step 21: Winterfall Spirit Beads
	["The western Winterfall furbolgs drop the beads."] = "Die westlichen Furbolgs der Winterfelle lassen die Perlen fallen.",

	-- Step 23: Chillwind Camp
	-- {area:1769} Timbermaw Hold · {zone:1448} Felwood · {area:442} Auberdine · {area:150} Menethil Harbor · {area:271} Southshore · {area:3197} Chillwind Camp
	["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Geh durch {area:1769} nach {zone:1448} und flieg weiter in die Östlichen Königreiche ({area:442}, das Schiff nach {area:150}). Flieg nach {area:271} und reite auf der Straße nach Norden durch das Alteracgebirge nach {area:3197}.",

	-- Step 24: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Folge der südlichen Straße nach Osten nach {zone:1423}; die Ruinen von {area:2262} liegen südlich davon. {npc:10926}s Geist spielt beim zerstörten Haus am Südende.",

	-- Step 25: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "{npc:10926}s Puppe",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Die drei Teile der Puppe liegen in den zerstörten Häusern von {area:2262}; beim Aufheben können Geister erscheinen. Füge sie zur Puppe zusammen.",

	-- Step 26: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, in {zone:1422}: behalten",

	-- Step 27: Light's Hope Chapel
	["Follow the road east across the zone to the chapel."] = "Folge der Straße nach Osten durch das Gebiet zur Kapelle.",
	-- {npc:11038} Caretaker Alen · {npc:12250} Zaeldarr the Outcast
	["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}: {npc:12250} ist ein Elitegegner der Stufe 54",

	-- Step 28: Corin's Crossing
	-- {area:2264} Corin's Crossing
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "Die Geißel um {area:2264}, westlich der Kapelle, lässt beide Arten von Geißelsteinen fallen; aus ihnen erheben sich Geister von Darrowshire: Sprich mit jedem, um ihn zu befreien.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Befreie Geister von Darrowshire: Sprich mit ihnen",

	-- Step 30: The Undercroft
	-- {npc:12250} Zaeldarr the Outcast · {area:2261} The Undercroft
	["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} ist Elite: Eine Gruppe wird empfohlen. Er wartet ganz unten im {area:2261}, der Krypta im Südwesten des Gebiets.",

	-- Step 31: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Reite nach Norden nach {area:2627}. {npc:12384} lebt in der zerstörten Hütte, sein Quittungsbuch liegt im zerstörten Gasthaus in der Nähe.",

	-- Step 32: Light's Hope Chapel
	-- {area:3197} Chillwind Camp
	["The next guide starts here and flies to {area:3197}."] = "Der nächste Guide beginnt hier und fliegt nach {area:3197}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "Zaeldarr ist Elite: Eine Gruppe wird empfohlen. Er wartet ganz unten in {area:2261}, der Krypta im Südwesten des Gebiets.",
}
