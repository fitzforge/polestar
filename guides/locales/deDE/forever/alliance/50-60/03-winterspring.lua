-- German (deDE): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "Nach {zone:1452}",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} steht direkt am Ausgang des Tunnels von {area:1769} nach {zone:1452}, wo du herauskommst.",

	-- Step 4: Everlook's inn
	-- {area:2255} Everlook
	["{area:2255}'s inn"] = "Gasthaus von {area:2255}",
	-- {zone:1455} Ironforge · {zone:1425} Hinterlands · {zone:1452} Winterspring · {area:2255} Everlook
	["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there at 47, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "Dein Ruhestein ist nicht auf {zone:1455} gesetzt (der Guide für {zone:1425} bindet dich dort mit Stufe 47, und dieser Guide verlässt {zone:1452} darüber): Binde dich stattdessen in {area:2255}, für die Wege zurück in die Stadt.",

	-- Step 5: Everlook
	-- {npc:11629} Jessica Redpath · {area:2262} Darrowshire
	["{npc:11629}: keep it for {area:2262}; inside"] = "{npc:11629}: Behalte es für {area:2262}; drinnen",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep both for the Plaguelands; inside"] = "{npc:10431}: Behalte beides für das Pestland; drinnen",
	-- {npc:11754} Meggi Peppinrocker · {area:2255} Everlook
	["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754} läuft um {area:2255} umher: Schau in den Kreis auf der Karte",
	-- {item:12383} Moontouched Feather
	["{item:12383}, 110 yd north"] = "{item:12383}, 110 yd nördlich",

	-- Step 7: Ice Thistle Hills: kill these as you meet them
	-- {area:2247} Ice Thistle Hills
	["{area:2247}: kill these as you meet them"] = "{area:2247}: Töte sie, wenn du ihnen begegnest",
	-- {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Eisdistelyetis leben in den Hügeln südlich von {area:2244}, Eiswindschimären im Tal Richtung {area:2255}.",

	-- Step 8: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "Die Ruinen liegen um den gefrorenen See südlich von {area:2253}. Sammle die vier Reliktfragmente in den Ruinen und die Mondbestrahlten Federn am Boden, wo die Wildekin umherstreifen.",

	-- Step 9: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Folge der Straße nach Westen zu {npc:9298}s Lager neben den heißen Quellen.",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Behalten: Gregan in {zone:1444} braut das Elixier später",

	-- Step 10: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}: Töte sie, wenn du ihnen begegnest",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {item:14047} Runecloth · {zone:1452} Winterspring
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty: it comes within the top-ups): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh.\nThe rest of {zone:1452}'s work is level 55-58: stay on this camp until level 54, so your first kills also count for {npc:9298} and {npc:11556}."] = "Das westliche Lager der Winterquell liegt in den Hügeln zwischen {npc:11556} und {npc:9298}. Jeder Furbolg hier kann einen {item:12771} fallen lassen (etwa bei jedem zehnten: Er kommt innerhalb der Kills, die diese Quests brauchen) und ein {quest:8471} (etwa bei jedem dreißigsten: Es kommt innerhalb der Grind-Runden): Klicke mit Rechtsklick an, was auch immer fällt. Behalte die {item:14047}, die die Furbolgs fallen lassen, für Meilosh.\nDie übrige Arbeit in {zone:1452} ist Stufe 55-58: Bleib bis Stufe 54 in diesem Lager, damit deine ersten Kills auch für {npc:9298} und {npc:11556} zählen.",
	-- {npc:7442} Winterfall Pathfinder
	["grind on {npc:7442}"] = "Grinde an {npc:7442}",

	-- Step 11: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "Der Kessel der Totenwaldfelle in {zone:1448}: behalten",

	-- Step 12: Level 55.05
	["Level 55.05"] = "Stufe 55,05",
	-- {area:2255} Everlook · {area:2246} Frostfire Hot Springs · {area:1769} Timbermaw Hold · {quest:8471} Winterfall Ritual Totem
	["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for."] = "Grinde hier bis Stufe 55,05, bevor du bei {area:2255} abgibst: Das bringt dich auf Stufe 56. Grinde die Winterquell-Furbolgs am {area:2246} (Pathfinders, Totemics, Den Watchers): Sie zu töten erhöht deinen Ruf bei den Timbermaw, den die Quests hier und der Weg durch {area:1769} brauchen; einer von ihnen lässt das {quest:8471} fallen, und sie füllen deine Taschen mit den dreißig Runenstoffen, die Meilosh verlangt.",

	-- Step 13: Winterfall Ritual Totem
	["Any Winterfall furbolg can drop the totem, about one kill in thirty: if the top-up did not bring one, keep killing them here until it drops, then right-click it."] = "Jeder Winterquell-Furbolg kann das Totem fallen lassen, etwa bei jedem dreißigsten Kill: Wenn der Grind keines gebracht hat, töte sie hier weiter, bis es fällt, und klicke es dann mit Rechtsklick an.",
	-- {area:1769} Timbermaw Hold
	["For Kernda in {area:1769}: keep it"] = "Für Kernda in {area:1769}: behalten",

	-- Step 15: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "Das Furbolgdorf der Winterfelle liegt östlich von {area:2255}: Schamanen (56-57), Höhlenbehüter (55-56) und Ursas (57-58), alle über deiner Stufe. Töte zuerst die Schamanen, sie heilen, und lock vom Rand aus. {npc:10738} in der Höhle hinten ist Elite: Bleib draußen.",

	-- Step 16: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Makellose Yetihörner",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "Zurück in die Hügel: Nur die Ice Thistle Matriarchs und Patriarchs tragen die Hörner.",

	-- Step 17: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "Bei {npc:10978}, am Gasthaus",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583} und {npc:10977} folgen später",
	-- {npc:10978} Legacki · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:10978} with {item:12928}"] = "Verscheuche {npc:10978} mit {item:12928}",

	-- Step 18: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "Zum {zone:1455}",
	-- {zone:1455} Ironforge · {area:3197} Chillwind Camp · {area:2255} Everlook
	["Your Hearthstone is still set at {zone:1455}: from there the gryphon to {area:3197} is about ten minutes quicker than {area:2255}'s flight to Theramore and the boat."] = "Dein Ruhestein ist noch auf {zone:1455} gesetzt: Von dort ist der Greif nach {area:3197} etwa zehn Minuten schneller als der Flug von {area:2255} nach Theramore und das Schiff.",
	-- {zone:1455} Ironforge
	["{zone:1455} inn"] = "Gasthaus von {zone:1455}",

	-- Step 20: Fly to Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Fly to {area:3197}"] = "Flieg nach {area:3197}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Flugmeister in {zone:1455}",

	-- Step 21: Fly to Theramore
	["Fly to Theramore"] = "Flieg nach Theramore",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Flugmeister in {area:2255}",

	-- Step 22: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Schiff nach {area:150}",

	-- Step 23: Fly to Chillwind Camp
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Flugmeister von {area:150}",

	-- Step 24: Chillwind Camp
	["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "Reinherz, Dumah, Tapferfaust und MacDonnell stehen in der Mitte des Lagers, beim Flugmeister.",
	-- {npc:11616} Nathaniel Dumah · {area:2627} Terrordale
	["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: Die Termiten kommen später, im {area:2627}",
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838}: the watchtowers are in Andorhal, keep it"] = "{npc:10838}: Die Wachtürme sind in Andorhal, behalte es",
	-- {npc:11053} High Priestess MacDonnell · {area:200} Dalson's Tears
	["{npc:11053}: the cauldron is at {area:200}, keep it"] = "{npc:11053}: Der Kessel ist in {area:200}, behalte es",

	-- Step 25: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {zone:1423} Eastern Plaguelands
	["{npc:10739} stands by the farm at the {area:202}, on the road east to the {zone:1423}."] = "{npc:10739} steht am Hof bei {area:202}, an der Straße nach Osten in die {zone:1423}.",
	["Inside"] = "Drinnen",

	-- Step 26: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "Nach {zone:1423}",

	-- Step 28: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Folge der südlichen Straße nach Osten nach {zone:1423}; die Ruinen von {area:2262} liegen südlich davon. {npc:10926}s Geist spielt beim zerstörten Haus am Südende.",

	-- Step 29: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "{npc:10926}s Puppe",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Die drei Teile der Puppe liegen in den zerstörten Häusern von {area:2262}; beim Aufheben können Geister erscheinen. Füge sie zur Puppe zusammen.",
	-- {item:12886} Pamela's Doll's Head
	["{item:12886}; inside"] = "{item:12886}; drinnen",
	-- {item:12888} Pamela's Doll's Right Side
	["{item:12888}; inside"] = "{item:12888}; drinnen",

	-- Step 30: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, in {zone:1422}: behalten",

	-- Step 31: Light's Hope Chapel
	["Follow the road east across the zone to the chapel."] = "Folge der Straße nach Osten durch das Gebiet zur Kapelle.",
	-- {npc:11038} Caretaker Alen
	["{npc:11038}: Zaeldarr is a level 54 elite"] = "{npc:11038}: Zaeldarr ist ein Elite der Stufe 54",

	-- Step 32: Corin's Crossing
	-- {area:2264} Corin's Crossing · {npc:10411} Eye of Naxxramas
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it.\nCareful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Die Geißel um {area:2264}, westlich der Kapelle, lässt beide Arten von Geißelsteinen fallen; Darrowshire Spirits steigen aus ihnen auf: Sprich jeden an, um ihn zu befreien.\nVorsicht: {npc:10411} wird unsichtbar, wenn er nicht im Kampf ist, und ruft Rockwing Gargoyles, sobald ein Kampf beginnt. Es gibt nur 3, und sie respawnen alle 15 Min.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Befreie Geister von Darrowshire: Sprich mit ihnen",

	-- Step 33: The Undercroft
	-- {area:2261} The Undercroft
	["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "Zaeldarr ist Elite: Eine Gruppe wird empfohlen. Er wartet ganz unten in {area:2261}, der Krypta im Südwesten des Gebiets.",
	-- {item:15785} Zaeldarr's Head
	["{item:15785}; below ground"] = "{item:15785}; unterirdisch",

	-- Step 34: Light's Hope Chapel
	-- {area:3197} Chillwind Camp
	["The next guide starts here and flies to {area:3197}."] = "Der nächste Guide beginnt hier und fliegt nach {area:3197}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "Zurück in die Hügel: Nur die Eisdistelmatriarchinnen und Eisdistelpatriarchen tragen die Hörner. Töte weiter Yetis bis Stufe 54: Harlos Wildekinquests sind vorher rot.",
	-- ["Fly to {area:271}"] = "Flieg nach {area:271}",
	-- ["Follow the southern road east into the {area:139}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Folge der südlichen Straße nach Osten nach {area:139}; die Ruinen von {area:2262} liegen südlich davon. {npc:10926}s Geist spielt beim zerstörten Haus am Südende.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Folge {npc:9298}s Wegbeschreibung zum Eingang von {area:2256}, vorbei an den Frosthagelriesen: Passiere sie einzeln.",
	-- ["Optional: {area:1417}"] = "Optional: {area:1417}",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Sammle die Vorräte um den Wagen auf und hol dir {npc:10301}s Amulett von den Eulenbestien in der Nähe zurück.",
	-- ["Pristine Yeti Horns"] = "Makellose Yetihörner",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Reite nach Norden nach {area:2627}. {npc:12384} lebt in der zerstörten Hütte, sein Quittungsbuch liegt im zerstörten Gasthaus in der Nähe.",
	-- ["Ride north-west back to the village."] = "Reite nach Nordwesten zurück ins Dorf.",
	-- ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Reite nach Südosten das Tal hinunter zu {npc:10301}s beschädigter Kiste im Schnee bei {area:2245}; sein zerstörter Wagen steht gleich östlich davon.",
	-- ["Ride west along the road to the night elf village."] = "Reite auf der Straße nach Westen zum Nachtelfendorf.",
	-- ["Ride west along the road to {npc:10301}."] = "Reite auf der Straße nach Westen zu {npc:10301}.",
	-- ["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "Nach den Yetis noch nicht Stufe 54? {area:1417} (50-54) in einer Gruppe statt Grinden bringt dich schneller dorthin. Kehr danach nach {area:2255} zurück.",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "Die Geißel um {area:2264}, westlich der Kapelle, lässt beide Arten von Geißelsteinen fallen; aus ihnen erheben sich Geister von Darrowshire: Sprich mit jedem, um ihn zu befreien.",
	-- ["The Winterfall camp"] = "Das Lager der Winterfelle",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "Das westliche Lager der Winterfelle liegt in den Hügeln zwischen {npc:11556} und {npc:9298}. Jeder Furbolg hier kann {item:12771} (etwa einer von zehn) und selten {quest:8471} fallen lassen: Rechtsklicke, was immer fällt. Behalte {quest:6031}, das die Furbolgs fallen lassen, für Meilosh.",
	-- ["The western Winterfall furbolgs drop the beads."] = "Die westlichen Furbolgs der Winterfelle lassen die Perlen fallen.",
	-- ["The {area:2247}"] = "{area:2247}",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Geh durch {area:1769} nach {zone:1448} und flieg weiter in die Östlichen Königreiche ({area:442}, das Schiff nach {area:150}). Flieg nach {area:271} und reite auf der Straße nach Norden durch das Alteracgebirge nach {area:3197}.",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "grinde {npc:7460} bei {area:2247}, {zone:1452}",
	-- ["{item:12771}, a rare drop"] = "{item:12771}, eine seltene Beute",
	-- ["{npc:10301}'s camp"] = "{npc:10301}s Lager",
	-- ["{npc:10301}'s supplies"] = "{npc:10301}s Vorräte",
	-- ["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}: beide für die Pestländer behalten",
	-- ["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}: {npc:12250} ist ein Elitegegner der Stufe 54",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: Der letzte Guide bindet dich hier, daher ist das meist sofort abgehakt",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} bewacht den Eingang von {area:1769}, nordwestlich von {npc:9298}.",
	-- ["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}: für {area:2262} behalten",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} ist Elite: Eine Gruppe wird empfohlen. Er wartet ganz unten im {area:2261}, der Krypta im Südwesten des Gebiets.",
	-- ["{quest:5152}, in the {area:28}: keep it"] = "{quest:5152}, in {area:28}: behalten",
	-- ["{quest:6031}, for Meilosh later"] = "{quest:6031}, später für Meilosh",
	-- ["{quest:8471}, a rare drop"] = "{quest:8471}, eine seltene Beute",
}
