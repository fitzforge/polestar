-- German (deDE): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Flieg nach {area:42}",
	-- {area:69} Lakeshire · {area:42} Darkshire · {zone:1431} Duskwood
	["Back to the {area:69} gryphon master: fly to {area:42} for {zone:1431}'s second loop."] = "",
	-- {area:69} Lakeshire
	["{area:69} flight master"] = "",

	-- Step 2: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "Ihr Haus steht auf dem Hügel südöstlich von {area:42}, oberhalb des {area:121}.",
	["Inside"] = "",
	-- {item:1946} Mary's Looking Glass · {npc:511} Insane Ghoul · {zone:1431} Duskwood
	["{item:1946}: the {npc:511} in the cemetery's crypt is level 26; it waits for the {zone:1431} return"] = "",

	-- Step 3: Tranquil Gardens Cemetery
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: seltene Beute von Gegnern im {zone:1431}",

	-- Step 5: Abercrombie
	["Head west along the road once more."] = "Geh noch einmal nach Westen entlang der Straße.",

	-- Step 7: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "Zurück nach {area:42}",
	-- {area:42} Darkshire
	["Head back east to {area:42}."] = "Geh zurück nach Osten nach {area:42}.",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, im Rathaus",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}, in der Taverne",

	-- Step 8: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "Fäulnisblüten",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "Skelettschrecken wandeln am Hang zwischen {area:42} und dem {area:121}, südöstlich des Orts; sie lassen die Fäulnisblüten fallen.",

	-- Step 10: Abercrombie
	["Head west to the hermit once more."] = "Geh noch einmal nach Westen zum Einsiedler.",

	-- Step 11: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "Ghulrippen",
	-- {area:492} Raven Hill Cemetery · {npc:948} Rotted One · {spell:3428} Summon Flesh Eating Worms
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds."] = "",

	-- Step 13: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "",
	-- {area:94} Raven Hill · {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Fiends = {npc:531} Skeletal Fiend · Skeletal Horrors = {npc:202} Skeletal Horror
	["Head south through the cemetery towards {area:94}. Skeletal Fiends and Skeletal Horrors walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "",

	-- Step 14: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288} versteckt sich im Haus am Westende von {area:94}.",

	-- Step 15: Sven's Camp
	-- {zone:1453} Stormwind · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["Next: training, then the flight from {zone:1453} to {area:150} for the {zone:1437}."] = "",

	-- Step 17: Agent Kearnen
	-- {area:94} Raven Hill · {zone:1436} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Head west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Geh von {area:94} entlang der Straße nach Westen hinaus nach {zone:1436}. {npc:7024} beobachtet den Turm von {npc:7053} von den Hügeln knapp hinter der Grenze. Die {npc:7051} (Stufe 23), die den Turm bewacht, trägt den Schlüssel dazu; Klavens Tagebuch liegt in der Truhe ganz oben.",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}, in der Truhe",

	-- Step 18: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Geh durch Elwynn nach Norden nach {zone:1453}; Mathias Shaw ist bei SI:7 in der {object:2100}.",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332}: Gifte und {item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607}: {npc:7207}, im Keller der Kaserne",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "/hinlegen neben {npc:7207}",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372}: {npc:1313}, Alchemiebedarf",
	-- {item:4371} Bronze Tube · {object:2096} Trade District · {npc:5519} Billibub Cogspinner
	["{item:4371}: the Auction House, {object:2096}; {npc:5519} keeps one and is nearly always sold out"] = "",

	-- Step 19: Elwynn Forest
	-- {area:94} Raven Hill · {area:87} Goldshire · {zone:1453} Stormwind
	["North from {area:94} through Elwynn: {area:87} is on the road to {zone:1453}."] = "",

	-- Step 20: Class trainer
	["Class trainer"] = "",
	["Level 22 and 24 spells"] = "Zauber der Stufen 22 und 24",

	-- Step 21: Gazin Tenorm
	-- {zone:1453} Stormwind · {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall
	["On into {zone:1453}: {npc:6173} and {npc:6171} are in the Cathedral of Light, on the way to the gryphon master."] = "",
	["Cathedral of Light"] = "Kathedrale des Lichts",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}: Erlösung",

	-- Step 22: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "",

	-- Step 23: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 24: Shaman training
	["Shaman training"] = "Schamanentraining",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453} hat keinen Schamanenlehrer: Nimm {area:2257} vom {object:28027} nach {zone:1455}, trainiere bei {npc:258098} und fahr dann mit der Bahn zurück.",

	-- Step 25: Rogue training
	["Rogue training"] = "",
	-- {zone:1453} Stormwind
	["Train here, in {zone:1453}, before you go on."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "Geh weiter nach Westen nach {area:94}. Die {object:673515} leuchtet beim zerstörten Haus südlich der Straße.",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "Jeder Ghul der nördlichen Hälfte des {area:492} kann eine Rippe fallen lassen: Fleischfresser, Knochenkauer, Seuchenverbreiter und Hirnfresser.",
	-- ["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Folge der Straße nach Nordwesten am Friedhof vorbei zu {npc:311}s Lager am äußersten Westrand des Waldes. {npc:893} steht neben {npc:311}.",
	-- ["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "Folge der Straße von {area:1002} nach Süden in den {zone:1431}; {area:42} liegt auf der Ostseite des Waldes.",
	-- ["Head back east along the road to the {area:245}."] = "Geh zurück nach Osten entlang der Straße zum {area:245}.",
	-- ["Head west along the road out of {area:94} into {area:40}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Geh von {area:94} entlang der Straße nach Westen hinaus nach {area:40}. {npc:7024} beobachtet den Turm von {npc:7053} von den Hügeln knapp hinter der Grenze. Die {npc:7051} (Stufe 23), die den Turm bewacht, trägt den Schlüssel dazu; Klavens Tagebuch liegt in der Truhe ganz oben.",
	-- ["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "Als Nächstes: {zone:1453} zum Trainieren, dann das Boot vom {area:17203} nach {area:442} für {zone:1440}.",
	-- ["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "Tollwütige Terrorwölfe streifen durch den Wald um den Friedhof und {npc:289}, Ausgehungerte Terrorwölfe durch die Hügel nordöstlich von ihm. Zwerggiftweberspinnen krabbeln östlich des Friedhofs und lassen das Gift fallen. Jeder Ghul der nördlichen Friedhofshälfte kann einen Fangzahn fallen lassen.",
	-- ["Ride back east along the road to the {area:245}."] = "Reite die Straße zurück nach Osten zum {area:245}.",
	-- ["Ride back east to {area:42}."] = "Reite zurück nach Osten nach {area:42}.",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Reite nach Norden durch den Wald von Elwynn nach {zone:1453}; Mathias Shaw ist bei SI:7 in {object:2100}.",
	-- ["Ride west along the road once more."] = "Reite noch einmal die Straße nach Westen.",
	-- ["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Reite die Straße nach Westen aus {area:94} hinaus nach {zone:1436}. {npc:7024} beobachtet den Turm von {npc:7053} von den Hügeln gleich hinter der Grenze. Die {npc:7051} (Stufe 23), die den Turm bewacht, trägt den Schlüssel; Klavens Tagebuch liegt in der Truhe ganz oben.",
	-- ["Ride west to the hermit once more."] = "Reite noch einmal nach Westen zum Einsiedler.",
	-- ["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "Skelettkrieger und Skelettmagier wandeln zwischen den Gräbern südöstlich von {area:42}, unterhalb des Hauses von {npc:302} auf dem Hügel. Jedes Skelett im {zone:1431} kann einen {item:2378} fallen lassen.",
	-- ["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "Der Friedhof liegt nördlich des Dorfs. Skelettschrecken und Skelettsatanskreaturen wandeln in seiner südlichen Hälfte. {npc:522}, ein Elite, wandert zwischen den Gräbern: Halte dich von ihm fern.",
	-- ["The hermit's shack stands in the woods north-east of the {area:492}."] = "Die Hütte des Einsiedlers steht im Wald nordöstlich des {area:492}.",
	-- ["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "Der Haufen lockerer Erde liegt südlich des Bauernhauses, beim alten Baumstumpf.",
	-- ["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "Trainiere in {zone:1453}, nach Norden durch den {zone:1429}. Nimm dann das Boot vom {area:17203} nach {area:442}.",
	-- ["Wolves, spiders and ghouls"] = "Wölfe, Spinnen und Ghule",
	-- ["{area:492}, south"] = "{area:492}, Süden",
	-- ["{item:281046}, from the {object:673515}"] = "{item:281046}, von der {object:673515}",
	-- ["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}, von {npc:3133}: begrenzter Vorrat. Ausverkauft? {npc:1448} in {area:150} verkauft sie auch.",
	-- ["{npc:2409}, at the north end of town"] = "{npc:2409}, am Nordende des Orts",
	-- ["{npc:264}, in the town hall"] = "{npc:264}, im Rathaus",
	-- ["{npc:265}, in her house by the tavern"] = "{npc:265}, in ihrem Haus bei der Taverne",
	-- ["{npc:268}, in the house behind the town hall"] = "{npc:268}, im Haus hinter dem Rathaus",
	-- ["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "{npc:276}s Haus steht am Ostende des Orts. {npc:3133} verkauft Ingenieursbedarf im Haus daneben.",
	-- ["{npc:332}: {spell:2842}, and {item:18160}"] = "{npc:332}: {spell:2842} und {item:18160}",
	-- ["{npc:633}, at the south end of town"] = "{npc:633}, am Südende des Orts",
	-- ["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, Taverne Zum Scharlachroten Raben",
	-- ["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888} steht südlich der Straße, beim {area:245}.",
	-- ["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: seltene Beute von Gegnern im {zone:1431}",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "{zone:1453} hat keinen Schamanenlehrer: Nimm die {area:2257} vom {object:28027} nach {zone:1455}, trainiere bei {npc:258098} und fahr dann mit der Bahn zurück zum Boot nach {area:442}.",
}
