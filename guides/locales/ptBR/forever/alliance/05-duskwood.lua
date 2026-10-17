-- Portuguese (Brazil) (ptBR): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Darkshire
	-- {area:1002} Three Corners · {zone:1431} Duskwood · {area:42} Darkshire
	["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "Siga a estrada para o sul a partir de {area:1002} até {zone:1431}; {area:42} fica no lado leste da floresta.",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409}, no extremo norte da cidade",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, Taberna Corvo Escarlate",
	-- {npc:265} Madame Eva
	["{npc:265}, in her house by the tavern"] = "{npc:265}, na casa dela, ao lado da taverna",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}, na prefeitura",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, na casa atrás da prefeitura",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town"] = "{npc:633}, no extremo sul da cidade",

	-- Step 2: Viktori Prism'Antras
	-- {npc:276} Viktori Prism'Antras · {npc:3133} Herble Baubbletump
	["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "A casa de {npc:276} fica no extremo leste da cidade. {npc:3133} vende artigos de engenharia na casa ao lado.",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}, de {npc:3133}: estoque limitado. Esgotado? {npc:1448}, em {area:150}, também vende.",

	-- Step 3: Tranquil Gardens Cemetery
	-- {area:42} Darkshire · {npc:302} Blind Mary · {zone:1431} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "Guerreiros Descarnados e Magos Descarnados andam entre os túmulos a sudeste de {area:42}, abaixo da casa de {npc:302} na colina. Qualquer esqueleto de {zone:1431} pode deixar cair {item:2378}.",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: saque raro dos monstros de {zone:1431}",

	-- Step 5: Watcher Dodds
	-- {npc:888} Watcher Dodds · {area:245} Yorgen Farmstead
	["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888} fica ao sul da estrada, em {area:245}.",

	-- Step 6: Raven Hill
	-- {area:94} Raven Hill · {object:673515} Memory of Valor (no name in this language: may be words)
	["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "Continue para o oeste até {area:94}. {object:673515} brilha junto à casa em ruínas ao sul da estrada.",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor (no name in this language: may be words)
	["{item:281046}, from the {object:673515}"] = "{item:281046}, de {object:673515}",

	-- Step 7: Raven Hill Cemetery, south
	-- {area:492} Raven Hill Cemetery
	["{area:492}, south"] = "{area:492}, sul",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "O cemitério fica ao norte do vilarejo. Horrores Descarnados e Malévolos Descarnados andam pela metade sul. {npc:522}, um elite, vaga entre os túmulos: fique longe dele.",

	-- Step 8: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Siga a estrada para noroeste, passando o cemitério, até o acampamento de {npc:311}, no extremo oeste da floresta. {npc:893} fica ao lado de {npc:311}.",

	-- Step 9: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["The hermit's shack stands in the woods north-east of the {area:492}."] = "O barraco do eremita fica na mata a nordeste de {area:492}.",

	-- Step 10: Wolves, spiders and ghouls
	["Wolves, spiders and ghouls"] = "Lobos, aranhas e carniçais",
	-- {npc:289} Abercrombie
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "Lobos Hediondos Raivosos vagam pela mata ao redor do cemitério e de {npc:289}; Lobos Hediondos Famintos, pelas colinas a nordeste dele. Veneracnas Pigmeias rastejam a leste do cemitério e deixam cair o veneno. Qualquer carniçal da metade norte do cemitério pode deixar cair uma presa.",

	-- Step 11: Watcher Dodds
	-- {area:245} Yorgen Farmstead
	["Ride back east along the road to the {area:245}."] = "Volte para o leste pela estrada até {area:245}.",

	-- Step 12: Yorgen Farmstead
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "O monte de terra solta fica ao sul da casa da fazenda, junto ao velho toco.",

	-- Step 14: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "A casa dela fica na colina a sudeste de {area:42}, acima de {area:121}.",

	-- Step 16: Abercrombie
	["Ride west along the road once more."] = "Siga para o oeste pela estrada mais uma vez.",

	-- Step 18: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "De volta a {area:42}",
	-- {area:42} Darkshire
	["Ride back east to {area:42}."] = "Volte para o leste até {area:42}.",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, na prefeitura",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}, na taverna",

	-- Step 19: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "Flores do Mal",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "Horrores Descarnados andam pela encosta entre {area:42} e {area:121}, a sudeste da cidade; eles deixam cair as Flores do Mal.",

	-- Step 21: Abercrombie
	["Ride west to the hermit once more."] = "Siga para o oeste até o eremita mais uma vez.",

	-- Step 22: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "Costelas de Carniçal",
	-- {area:492} Raven Hill Cemetery
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "Qualquer carniçal da metade norte de {area:492} pode deixar cair uma costela: Comedores de Carne, Mastigossos, Vetores da Peste e Devora-Cérebros.",

	-- Step 24: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288} se esconde na casa no extremo oeste de {area:94}.",

	-- Step 25: Sven's Camp
	-- {zone:1453} Stormwind · {area:17203} Stormwind Harbor · {area:442} Auberdine · {zone:1440} Ashenvale
	["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "A seguir: {zone:1453} para treinar, depois o barco de {area:17203} para {area:442}, rumo a {zone:1440}.",

	-- Step 26: Agent Kearnen
	-- {area:94} Raven Hill · {zone:1436} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Siga para o oeste pela estrada, saindo de {area:94} para {zone:1436}. {npc:7024} vigia a torre de {npc:7053} das colinas logo depois da fronteira. {npc:7051} (nível 23) que guarda a torre leva a chave; o diário de Filipe está no baú lá no alto.",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}, no baú",

	-- Step 27: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Siga para o norte pela Floresta de Elwynn até {zone:1453}; Mathias Shaw fica no SI:7, em {object:2100}.",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332}: Venenos e {item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607}: {npc:7207}, no porão do Quartel",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "/lay down ao lado de {npc:7207}",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372}: {npc:1313}, Suprimentos de Alquimia",

	-- Step 28: Stormwind
	-- {zone:1453} Stormwind · {zone:1429} Elwynn Forest · {area:17203} Stormwind Harbor · {area:442} Auberdine
	["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "Treine em {zone:1453}, ao norte, passando por {zone:1429}. Depois pegue o barco de {area:17203} para {area:442}.",
	["Level 22 and 24 spells"] = "Feitiços dos níveis 22 e 24",

	-- Step 29: Shaman training
	["Shaman training"] = "Treinamento de xamã",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {area:442} Auberdine
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "{zone:1453} não tem instrutor de xamã: pegue o {area:2257} no {object:28027} até {zone:1455}, treine com {npc:258098} e volte de metrô para pegar o barco de {area:442}.",
}
