-- German (deDE): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Darkshire
	-- {area:1002} Three Corners · {area:10} Duskwood · {area:42} Darkshire
	["Follow the road south from {area:1002} into {area:10}; {area:42} lies on the east side of the forest."] = "",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409}, am Nordende des Orts",
	-- {npc:265} Madame Eva
	["{npc:265}, in her house by the tavern; inside"] = "",

	-- Step 3: Darkshire
	-- {item:4371} Bronze Tube · {quest:174} Look to the Stars · {npc:3133} Herble Baubbletump · {npc:276} Viktori Prism'Antras · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["No {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too.\n{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump
	["{item:4371}, from {npc:3133}, if you have none"] = "",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, im Rathaus",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, im Haus hinter dem Rathaus",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}, im Rathaus",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town; inside"] = "",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, Taverne Zum Scharlachroten Raben",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}, von {npc:3133}: begrenzter Vorrat. Ausverkauft? {npc:1448} in {area:150} verkauft sie auch.",

	-- Step 4: Nightbane Shadow Weaver on the way
	-- {npc:533} Nightbane Shadow Weaver
	["{npc:533} on the way"] = "",

	-- Step 5: Tranquil Gardens Cemetery: kill these as you meet them
	-- {area:121} Tranquil Gardens Cemetery
	["{area:121}: kill these as you meet them"] = "",
	-- {area:42} Darkshire · {npc:302} Blind Mary · {area:10} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {area:10} can drop a {item:2378}.\nCareful: Because the skeletons stand near each other, running straight in tends to pull several at once."] = "",

	-- Step 7: Skeletal Fiend on the way
	-- {npc:531} Skeletal Fiend
	["{npc:531} on the way"] = "",

	-- Step 8: Skeletal Horror on the way
	-- {npc:202} Skeletal Horror
	["{npc:202} on the way"] = "",

	-- Step 9: Watcher Dodds
	-- {npc:888} Watcher Dodds · {area:245} Yorgen Farmstead
	["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888} steht südlich der Straße, beim {area:245}.",

	-- Step 10: Raven Hill
	-- {area:94} Raven Hill · {object:673515} Memory of Valor
	["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "Geh weiter nach Westen nach {area:94}. Die {object:673515} leuchtet beim zerstörten Haus südlich der Straße.",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor
	["{item:281046}, from the {object:673515}"] = "{item:281046}, von der {object:673515}",

	-- Step 11: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Folge der Straße nach Nordwesten am Friedhof vorbei zu {npc:311}s Lager am äußersten Westrand des Waldes. {npc:893} steht neben {npc:311}.",

	-- Step 12: The Hushed Bank: kill these as you meet them
	-- {area:1097} The Hushed Bank
	["{area:1097}: kill these as you meet them"] = "",
	-- {npc:289} Abercrombie · {area:40} Westfall
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang.\nCareful: Wolves and other spider types share the area along the {area:40} border, so you can easily pull several mobs at once."] = "",

	-- Step 13: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["The hermit's shack stands in the woods north-east of the {area:492}."] = "Die Hütte des Einsiedlers steht im Wald nordöstlich des {area:492}.",

	-- Step 14: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "Der Friedhof liegt nördlich des Dorfs. Skelettschrecken und Skelettsatanskreaturen wandeln in seiner südlichen Hälfte. {npc:522}, ein Elite, wandert zwischen den Gräbern: Halte dich von ihm fern.",

	-- Step 15: Watcher Dodds
	-- {area:245} Yorgen Farmstead
	["Head back east along the road to the {area:245}."] = "Geh zurück nach Osten entlang der Straße zum {area:245}.",

	-- Step 16: Yorgen Farmstead
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "Der Haufen lockerer Erde liegt südlich des Bauernhauses, beim alten Baumstumpf.",

	-- Step 18: Darkshire
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, inside"] = "",

	-- Step 19: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "Ihr Haus steht auf dem Hügel südöstlich von {area:42}, oberhalb des {area:121}.",
	["Inside"] = "",

	-- Step 20: Tranquil Gardens Cemetery
	-- {quest:337} An Old History Book · {area:10} Duskwood
	["{quest:337}: a rare drop from {area:10}'s mobs"] = "",

	-- Step 22: Abercrombie
	["Head west along the road once more."] = "Geh noch einmal nach Westen entlang der Straße.",

	-- Step 24: Hearth to Darkshire
	-- {area:42} Darkshire
	["Hearth to {area:42}"] = "",

	-- Step 25: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "Zurück nach {area:42}",
	-- {area:42} Darkshire
	["Head back east to {area:42}."] = "Geh zurück nach Osten nach {area:42}.",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}, in der Taverne",

	-- Step 26: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "Fäulnisblüten",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "Skelettschrecken wandeln am Hang zwischen {area:42} und dem {area:121}, südöstlich des Orts; sie lassen die Fäulnisblüten fallen.",

	-- Step 28: Abercrombie
	["Head west to the hermit once more."] = "Geh noch einmal nach Westen zum Einsiedler.",

	-- Step 29: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "Ghulrippen",
	-- {area:492} Raven Hill Cemetery · {npc:948} Rotted One · {spell:3428} Summon Flesh Eating Worms
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds."] = "",

	-- Step 31: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288} versteckt sich im Haus am Westende von {area:94}.",

	-- Step 32: Sven's Camp
	-- {zone:1453} Stormwind · {area:17203} Stormwind Harbor · {area:442} Auberdine · {zone:1440} Ashenvale
	["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "Als Nächstes: {zone:1453} zum Trainieren, dann das Boot vom {area:17203} nach {area:442} für {zone:1440}.",

	-- Step 34: Agent Kearnen
	-- {area:94} Raven Hill · {area:40} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Head west along the road out of {area:94} into {area:40}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}, in der Truhe",

	-- Step 35: Master Mathias Shaw
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

	-- Step 36: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "",
	-- {area:108} Sentinel Hill
	["{area:108} flight master"] = "",

	-- Step 37: Gazin Tenorm
	-- {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall
	["{npc:6173} and {npc:6171} are in the Cathedral of Light."] = "",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "",

	-- Step 39: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 40: Shaman training
	["Shaman training"] = "Schamanentraining",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {area:442} Auberdine
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "{zone:1453} hat keinen Schamanenlehrer: Nimm die {area:2257} vom {object:28027} nach {zone:1455}, trainiere bei {npc:258098} und fahr dann mit der Bahn zurück zum Boot nach {area:442}.",

	-- Step 41: Rogue training
	["Rogue training"] = "",
	-- {zone:1453} Stormwind
	["Train here, in {zone:1453}, before you go on."] = "",

	-- Step 43: Class trainer
	["Class trainer"] = "",
	["Level 22 and 24 spells"] = "Zauber der Stufen 22 und 24",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "Jeder Ghul der nördlichen Hälfte des {area:492} kann eine Rippe fallen lassen: Fleischfresser, Knochenkauer, Seuchenverbreiter und Hirnfresser.",
	-- ["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "Folge der Straße von {area:1002} nach Süden in den {zone:1431}; {area:42} liegt auf der Ostseite des Waldes.",
	-- ["Head west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Geh von {area:94} entlang der Straße nach Westen hinaus nach {zone:1436}. {npc:7024} beobachtet den Turm von {npc:7053} von den Hügeln knapp hinter der Grenze. Die {npc:7051} (Stufe 23), die den Turm bewacht, trägt den Schlüssel dazu; Klavens Tagebuch liegt in der Truhe ganz oben.",
	-- ["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "Tollwütige Terrorwölfe streifen durch den Wald um den Friedhof und {npc:289}, Ausgehungerte Terrorwölfe durch die Hügel nordöstlich von ihm. Zwerggiftweberspinnen krabbeln östlich des Friedhofs und lassen das Gift fallen. Jeder Ghul der nördlichen Friedhofshälfte kann einen Fangzahn fallen lassen.",
	-- ["Ride back east along the road to the {area:245}."] = "Reite die Straße zurück nach Osten zum {area:245}.",
	-- ["Ride back east to {area:42}."] = "Reite zurück nach Osten nach {area:42}.",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Reite nach Norden durch den Wald von Elwynn nach {zone:1453}; Mathias Shaw ist bei SI:7 in {object:2100}.",
	-- ["Ride west along the road once more."] = "Reite noch einmal die Straße nach Westen.",
	-- ["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Reite die Straße nach Westen aus {area:94} hinaus nach {zone:1436}. {npc:7024} beobachtet den Turm von {npc:7053} von den Hügeln gleich hinter der Grenze. Die {npc:7051} (Stufe 23), die den Turm bewacht, trägt den Schlüssel; Klavens Tagebuch liegt in der Truhe ganz oben.",
	-- ["Ride west to the hermit once more."] = "Reite noch einmal nach Westen zum Einsiedler.",
	-- ["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "Skelettkrieger und Skelettmagier wandeln zwischen den Gräbern südöstlich von {area:42}, unterhalb des Hauses von {npc:302} auf dem Hügel. Jedes Skelett im {zone:1431} kann einen {item:2378} fallen lassen.",
	-- ["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "Trainiere in {zone:1453}, nach Norden durch den {zone:1429}. Nimm dann das Boot vom {area:17203} nach {area:442}.",
	-- ["Wolves, spiders and ghouls"] = "Wölfe, Spinnen und Ghule",
	-- ["{area:492}, south"] = "{area:492}, Süden",
	-- ["{npc:265}, in her house by the tavern"] = "{npc:265}, in ihrem Haus bei der Taverne",
	-- ["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "{npc:276}s Haus steht am Ostende des Orts. {npc:3133} verkauft Ingenieursbedarf im Haus daneben.",
	-- ["{npc:332}: {spell:2842}, and {item:18160}"] = "{npc:332}: {spell:2842} und {item:18160}",
	-- ["{npc:633}, at the south end of town"] = "{npc:633}, am Südende des Orts",
	-- ["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: seltene Beute von Gegnern im {zone:1431}",
}
