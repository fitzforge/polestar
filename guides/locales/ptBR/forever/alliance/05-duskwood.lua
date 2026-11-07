-- Portuguese (Brazil) (ptBR): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Darkshire
	-- {area:1002} Three Corners · {area:10} Duskwood · {area:42} Darkshire
	["Follow the road south from {area:1002} into {area:10}; {area:42} lies on the east side of the forest."] = "",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409}, no extremo norte da cidade",
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
	["{npc:267}, in the town hall"] = "{npc:267}, na prefeitura",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, na casa atrás da prefeitura",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}, na prefeitura",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town; inside"] = "",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, Taberna Corvo Escarlate",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}, de {npc:3133}: estoque limitado. Esgotado? {npc:1448}, em {area:150}, também vende.",

	-- Step 4: Nightbane Shadow Weaver on the way
	-- {npc:533} Nightbane Shadow Weaver
	["{npc:533} on the way"] = "",

	-- Step 5: Tranquil Gardens Cemetery: kill these as you meet them
	-- {area:121} Tranquil Gardens Cemetery
	["{area:121}: kill these as you meet them"] = "",
	-- {area:42} Darkshire · {npc:302} Blind Mary · {area:10} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {area:10} can drop a {item:2378}.\nCareful: Because the skeletons stand near each other, running straight in tends to pull several at once."] = "",

	-- Step 7: Skeletal Horror on the way
	-- {npc:202} Skeletal Horror
	["{npc:202} on the way"] = "",

	-- Step 8: Watcher Dodds
	-- {npc:888} Watcher Dodds · {area:245} Yorgen Farmstead
	["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888} fica ao sul da estrada, em {area:245}.",

	-- Step 9: Skeletal Fiend on the way
	-- {npc:531} Skeletal Fiend
	["{npc:531} on the way"] = "",

	-- Step 10: Raven Hill
	-- {area:94} Raven Hill · {object:673515} Memory of Valor (no name in this language: may be words)
	["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "Continue para o oeste até {area:94}. {object:673515} brilha junto à casa em ruínas ao sul da estrada.",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor (no name in this language: may be words)
	["{item:281046}, from the {object:673515}"] = "{item:281046}, de {object:673515}",

	-- Step 11: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Siga a estrada para noroeste, passando o cemitério, até o acampamento de {npc:311}, no extremo oeste da floresta. {npc:893} fica ao lado de {npc:311}.",

	-- Step 12: The Hushed Bank: kill these as you meet them
	-- {area:1097} The Hushed Bank
	["{area:1097}: kill these as you meet them"] = "",
	-- {npc:289} Abercrombie · {area:40} Westfall
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang.\nCareful: Wolves and other spider types share the area along the {area:40} border, so you can easily pull several mobs at once."] = "",

	-- Step 13: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["The hermit's shack stands in the woods north-east of the {area:492}."] = "O barraco do eremita fica na mata a nordeste de {area:492}.",

	-- Step 14: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "O cemitério fica ao norte do vilarejo. Horrores Descarnados e Malévolos Descarnados andam pela metade sul. {npc:522}, um elite, vaga entre os túmulos: fique longe dele.",

	-- Step 15: Watcher Dodds
	-- {area:245} Yorgen Farmstead
	["Head back east along the road to the {area:245}."] = "",

	-- Step 16: Yorgen Farmstead
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "O monte de terra solta fica ao sul da casa da fazenda, junto ao velho toco.",

	-- Step 18: Darkshire
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, inside"] = "",

	-- Step 19: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "A casa dela fica na colina a sudeste de {area:42}, acima de {area:121}.",
	["Inside"] = "",

	-- Step 20: Tranquil Gardens Cemetery
	-- {quest:337} An Old History Book · {area:10} Duskwood
	["{quest:337}: a rare drop from {area:10}'s mobs"] = "",

	-- Step 22: Abercrombie
	["Head west along the road once more."] = "",

	-- Step 24: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "De volta a {area:42}",
	-- {area:42} Darkshire
	["Head back east to {area:42}."] = "",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}, na taverna",

	-- Step 25: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "Flores do Mal",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "Horrores Descarnados andam pela encosta entre {area:42} e {area:121}, a sudeste da cidade; eles deixam cair as Flores do Mal.",

	-- Step 27: Abercrombie
	["Head west to the hermit once more."] = "",

	-- Step 28: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "Costelas de Carniçal",
	-- {area:492} Raven Hill Cemetery · {npc:948} Rotted One · {spell:3428} Summon Flesh Eating Worms
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds."] = "",

	-- Step 30: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288} se esconde na casa no extremo oeste de {area:94}.",

	-- Step 31: Sven's Camp
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {zone:1440} Ashenvale
	["Next: training, then Redridge's second pass, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "",

	-- Step 33: Agent Kearnen
	-- {area:94} Raven Hill · {area:40} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Head west along the road out of {area:94} into {area:40}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}, no baú",

	-- Step 34: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332}: Venenos e {item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607}: {npc:7207}, no porão do Quartel",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "/lay down ao lado de {npc:7207}",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372}: {npc:1313}, Suprimentos de Alquimia",

	-- Step 35: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "",
	-- {area:108} Sentinel Hill
	["{area:108} flight master"] = "",

	-- Step 36: Gazin Tenorm
	-- {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall
	["{npc:6173} and {npc:6171} are in the Cathedral of Light."] = "",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "",

	-- Step 38: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 39: Shaman training
	["Shaman training"] = "Treinamento de xamã",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {area:442} Auberdine
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "{zone:1453} não tem instrutor de xamã: pegue o {area:2257} no {object:28027} até {zone:1455}, treine com {npc:258098} e volte de metrô para pegar o barco de {area:442}.",

	-- Step 40: Rogue training
	["Rogue training"] = "",
	-- {zone:1453} Stormwind
	["Train here, in {zone:1453}, before you go on."] = "",

	-- Step 42: Class trainer
	["Class trainer"] = "",
	["Level 22 and 24 spells"] = "Feitiços dos níveis 22 e 24",

	-- Step 43: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 44: Redridge Mountains
	-- {area:87} Goldshire · {area:1002} Three Corners · {area:69} Lakeshire
	["Follow the road east from {area:87} through Elwynn to {area:1002}, then along the lake to {area:69}."] = "",

	-- Step 45: Lakeshire
	-- {npc:382} Marshal Marris
	["{npc:382} stands at the north end of the bridge; two Wanted posters hang on the town hall doorway, a third by the inn."] = "",
	["The Wanted poster on the town hall doorway"] = "",
	["The Wanted poster beside it"] = "",
	["The Wanted poster by the inn"] = "",

	-- Step 46: Incinerator Gar'im
	-- {area:2099} Stonewatch Keep · {item:1261} Midnight Orb
	["East past the mill, then south-east to the Blackrock camps east of {area:2099}: Gar'im keeps to the cave at their south end with his imp and two orcs. Elite: group up if you can; solo, pull the orcs at the mouth first and interrupt his fire cast. He drops a {item:1261} too."] = "",

	-- Step 47: Stonewatch Keep
	-- {area:2099} Stonewatch Keep · {quest:19} Tharil'zun · {npc:334} Gath'Ilzogg
	-- plural, as words: Blackrock Shadowcasters = {npc:436} Blackrock Shadowcaster
	["North to {area:2099}. Blackrock Shadowcasters (elite) stand with Sentries on its west side: pull one at a time. Then {quest:19} (elite) in the south-west courtyard with his guards, and {npc:334} (elite) in the keep's top room with two guards and a dragon: hug the right wall as you enter so you don't pull him at once. Elite: group up if you can."] = "",
	-- {item:1261} Midnight Orb
	-- plural, as words: Blackrock Shadowcasters = {npc:436} Blackrock Shadowcaster
	["{item:1261}: Blackrock Shadowcasters"] = "",

	-- Step 48: Lieutenant Fangore
	-- {area:1000} Galardell Valley
	["North-east to the gnolls' eastern camp in {area:1000}. Fangore has two guards linked to him: clear the gnolls around him first and fight at full health."] = "",

	-- Step 49: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "",
	-- {area:69} Lakeshire
	["West back to {area:69}."] = "",
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "",

	-- Step 50: Fly to Stormwind
	-- {area:69} Lakeshire
	["{area:69} flight master"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "Qualquer carniçal da metade norte de {area:492} pode deixar cair uma costela: Comedores de Carne, Mastigossos, Vetores da Peste e Devora-Cérebros.",
	-- ["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "Siga a estrada para o sul a partir de {area:1002} até {zone:1431}; {area:42} fica no lado leste da floresta.",
	-- ["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "A seguir: {zone:1453} para treinar, depois o barco de {area:17203} para {area:442}, rumo a {zone:1440}.",
	-- ["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "Lobos Hediondos Raivosos vagam pela mata ao redor do cemitério e de {npc:289}; Lobos Hediondos Famintos, pelas colinas a nordeste dele. Veneracnas Pigmeias rastejam a leste do cemitério e deixam cair o veneno. Qualquer carniçal da metade norte do cemitério pode deixar cair uma presa.",
	-- ["Ride back east along the road to the {area:245}."] = "Volte para o leste pela estrada até {area:245}.",
	-- ["Ride back east to {area:42}."] = "Volte para o leste até {area:42}.",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Siga para o norte pela Floresta de Elwynn até {zone:1453}; Mathias Shaw fica no SI:7, em {object:2100}.",
	-- ["Ride west along the road once more."] = "Siga para o oeste pela estrada mais uma vez.",
	-- ["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Siga para o oeste pela estrada, saindo de {area:94} para {zone:1436}. {npc:7024} vigia a torre de {npc:7053} das colinas logo depois da fronteira. {npc:7051} (nível 23) que guarda a torre leva a chave; o diário de Filipe está no baú lá no alto.",
	-- ["Ride west to the hermit once more."] = "Siga para o oeste até o eremita mais uma vez.",
	-- ["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "Guerreiros Descarnados e Magos Descarnados andam entre os túmulos a sudeste de {area:42}, abaixo da casa de {npc:302} na colina. Qualquer esqueleto de {zone:1431} pode deixar cair {item:2378}.",
	-- ["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "Treine em {zone:1453}, ao norte, passando por {zone:1429}. Depois pegue o barco de {area:17203} para {area:442}.",
	-- ["Wolves, spiders and ghouls"] = "Lobos, aranhas e carniçais",
	-- ["{area:492}, south"] = "{area:492}, sul",
	-- ["{npc:265}, in her house by the tavern"] = "{npc:265}, na casa dela, ao lado da taverna",
	-- ["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "A casa de {npc:276} fica no extremo leste da cidade. {npc:3133} vende artigos de engenharia na casa ao lado.",
	-- ["{npc:633}, at the south end of town"] = "{npc:633}, no extremo sul da cidade",
	-- ["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: saque raro dos monstros de {zone:1431}",
}
