-- Portuguese (Brazil) (ptBR): the guide forever/reputation/thunder-bluff (forever/reputation/thunder-bluff.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thunder Bluff Reputation"] = "Reputação: Penhasco do Trovão",
	-- {zone:1452} Winterspring · {item:11040} Morrowgrain · {item:14047} Runecloth · {zone:1412} Mulgore
	["{zone:1452}'s level 56-60 quests, {item:11040} and {item:14047} to Exalted, with {zone:1412}'s old quests as an optional extra."] = "",
	-- {faction:81} Thunder Bluff
	["Exalted with {faction:81}"] = "",

	-- Step 1: Thunder Bluff: how it works
	-- {faction:81} Thunder Bluff
	["{faction:81}: how it works"] = "",
	-- {faction:81} Thunder Bluff · {item:11040} Morrowgrain · {npc:14728} Rumstag Proudstrider · {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1412} Mulgore · {zone:1441} Thousand Needles
	["{faction:81} reputation comes from quests, {item:11040} and cloth. {npc:14728}, the cloth quartermaster, stands on the central rise among the leatherworkers' and tailors' tents. He takes four one-time donations of 60 cloth (150 each) and then {quest:7825}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:81} also gives a quarter as much to {zone:1454}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:81}'s quests within 5 levels of them: {zone:1412} at 1 to 12, Camp Taurajo and the Crossroads at 13 to 22, {zone:1441} at 25 to 30. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Thunder Bluff's merchants sell to you for 10% less (the Classic rule), the kodo vendor included; at Exalted other races can buy the kodos: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60, once you have mount training. {faction:81} has no tabard or other reward."] = "",

	-- Step 2: Everlook: Storm Shadowhoof
	-- {npc:10303} Storm Shadowhoof
	["Everlook: {npc:10303}"] = "",
	-- {npc:10303} Storm Shadowhoof · {faction:81} Thunder Bluff · {npc:10806} Ursius
	["{npc:10303}'s four quests are level 56 to 60, so they pay in full: 400 {faction:81} reputation. {npc:10806}, an elite bear, walks a loop over the four hills north of Everlook: wait on a hilltop for him."] = "",
	-- {npc:10806} Ursius
	["{npc:10806}, elite"] = "",

	-- Step 3: Brumeran and Shy-Rotam
	-- {npc:10807} Brumeran · {quest:5056} Shy-Rotam
	["{npc:10807} and {quest:5056}"] = "",
	-- {npc:10807} Brumeran · {quest:5056} Shy-Rotam · {item:12733} Sacred Frostsaber Meat · {object:103819} Stone of Shy-Rotam (no name in this language: may be words) · {npc:10306} Trull Failbane · {zone:1454} Orgrimmar · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets · {faction:81} Thunder Bluff
	["{npc:10807}, an elite chimera, spawns south of Everlook. For {quest:5056}, kill frostsabers north of Everlook until one drops {item:12733} (about one in ten), then use the meat at the {object:103819}, far to the north, and kill the great cat that comes. If you have done {npc:10306}'s Wild Guardians quests (the {zone:1454} guide), the Crazed, Moontouched and Berserk owlbeasts around Everlook sometimes drop a {item:12558}: it starts {quest:4882}, 50 {zone:1454} and then 100 {faction:81} reputation in full."] = "",
	-- {npc:10807} Brumeran
	["{npc:10807}, elite"] = "",
	-- {item:12733} Sacred Frostsaber Meat
	["{item:12733}, from the frostsabers"] = "",

	-- Step 4: Bloodvenom Post: Trull Failbane
	-- {npc:10306} Trull Failbane
	["Bloodvenom Post: {npc:10306}"] = "",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306} stands at Bloodvenom Post, through the Timbermaw tunnel south of {zone:1452}."] = "",
	-- {quest:4882} Guarding Secrets · {npc:5770} Nara Wildmane · {faction:81} Thunder Bluff
	["{quest:4882}, +100: to {npc:5770} in {faction:81}"] = "",

	-- Step 5: Thunder Bluff: Nara Wildmane
	-- {npc:5770} Nara Wildmane · {object:50507} Elder Rise (no name in this language: may be words) · {npc:5769} Arch Druid Hamuul Runetotem
	["{npc:5770} stands on {object:50507}, beside {npc:5769}."] = "",

	-- Step 6: Morrowgrain (optional)
	-- {item:11040} Morrowgrain
	["{item:11040} (optional)"] = "",
	-- {quest:3804} Morrowgrain to Thunder Bluff · {item:11040} Morrowgrain · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {npc:6746} Innkeeper Pala · {npc:5769} Arch Druid Hamuul Runetotem · {object:50507} Elder Rise (no name in this language: may be words)
	["{quest:3804} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60, but it is slow: the {item:11020} grows one casing every 10 minutes and a casing holds about one {item:11040} on average, so each hand-in takes about 90 minutes of waiting, 18 {quest:3761} and 9 seed packets (90 silver). It runs beside whatever else you do: a little over 30 reputation an hour. The chain before it is level 50 (in Classic a fifth at 60). {npc:6746} sends you to {npc:5769} on {object:50507}; he wants 20 {quest:3761}."] = "",

	-- Step 7: Un'Goro Crater: Un'Goro Soil
	-- {quest:3761} Un'Goro Soil · {item:11040} Morrowgrain
	["Nearly every beast, plant and silithid in the crater drops {quest:3761}, about one kill in three (the Bloodpetals and the Gorishi wasps about one in two), and the dirt mounds give it too. Take far more than 20: every casing uses 2, about 18 for each {item:11040} hand-in."] = "",

	-- Step 8: Thunder Bluff: Morrowgrain Research
	-- {npc:9076} Ghede · {npc:9087} Bashana Runetotem · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {item:11024} Evergreen Herb Casing · {item:11040} Morrowgrain
	["{npc:9076} takes the soil. {npc:9087} sells the {item:11020} (1 gold) and Packets of Tharlendris Seeds (10 silver each). With a seed packet and 2 {quest:3761} in your bags, use the pouch: it grows an {item:11024}, once every 10 minutes. Open each casing: about one in three holds 1 to 5 {item:11040}, the rest common herbs. Use the pouch whenever it is ready while you follow the rest of this guide."] = "",
	-- {item:11020} Evergreen Pouch
	["{item:11020}, 1 gold"] = "",
	-- {item:11022} Packet of Tharlendris Seeds
	["{item:11022}, 10 silver each"] = "",

	-- Step 9: Morrowgrain as you go
	-- {item:11040} Morrowgrain
	["{item:11040} as you go"] = "",
	-- {item:11040} Morrowgrain · {npc:9087} Bashana Runetotem
	["{item:11040}: use the pouch every 10 minutes and open the casings; {npc:9087} takes it"] = "",

	-- Step 10: Gloomrise (optional hub)
	["Gloomrise (optional hub)"] = "",
	-- {faction:81} Thunder Bluff · {zone:1454} Orgrimmar · {npc:259118} Muln Earthfury · {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem
	["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. The Earthen Ring camp on the Skywatcher Plateau, north-west of {faction:81}: 300 {faction:81} reputation in 20 minutes (60 at a fifth), plus 100 each for {zone:1454} and the Darkspear Trolls and 450 Earthen Ring. {npc:259118}, {npc:264074} and {npc:264072} stand in the camp."] = "",
	-- {npc:259118} Muln Earthfury · {quest:96259} Defending the Dead · {quest:96261} The Broodmother
	["{npc:259118}: {quest:96259}, +100 ({quest:96261} comes once it is handed in)"] = "",
	-- {npc:264074} Mazu'kon · {quest:96241} Talkin' bout Toxins, Mon
	["{npc:264074}: {quest:96241} (Darkspear +100)"] = "",

	-- Step 11: Gloomrise
	["Gloomrise"] = "",
	-- {faction:81} Thunder Bluff · {item:273015} Toxin Extractor · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["Gloomrise is the tauren burial ground north of {faction:81}. Use the {item:273015} on the Gnawed Corpses. {npc:264082} waits at the heart of it; her body carries a {item:273658}: read it to start {quest:96294}."] = "",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}, das Tecelãs de Penumbrascente ({npc:264081})",

	-- Step 12: The Skywatcher camp: hand in
	["The Skywatcher camp: hand in"] = "",
	-- {npc:259118} Muln Earthfury · {quest:96261} The Broodmother · {quest:96259} Defending the Dead
	["{npc:259118} offers {quest:96261} only once {quest:96259} is handed in."] = "",

	-- Step 13: Broodmother Valraxx
	-- {npc:264082} Broodmother Valraxx
	["{npc:264082}, at the heart of Gloomrise"] = "",

	-- Step 15: Camp Narache (optional hub)
	-- {object:2972} Camp Narache (no name in this language: may be words)
	["{object:2972} (optional hub)"] = "",
	-- {object:2972} Camp Narache (no name in this language: may be words) · {zone:1412} Mulgore · {faction:81} Thunder Bluff · {npc:2980} Grull Hawkwind · {npc:2981} Chief Hawkwind · {npc:3209} Brave Windfeather
	["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {object:2972}, at the south end of {zone:1412}: about 1,100 {faction:81} reputation in 25 minutes (220 at a fifth). Starting-zone quests give the other cities no share. {npc:2980} and {npc:2981} stand in the camp, {npc:3209} at its edge."] = "",

	-- Step 16: Greatmother Hawkwind and the plains
	-- {npc:2991} Greatmother Hawkwind
	["{npc:2991} and the plains"] = "",
	-- {npc:2991} Greatmother Hawkwind
	["{npc:2991}'s tent is south-east of the camp; the water pitcher stands at the well beside it. Plainstriders graze all around."] = "",

	-- Step 17: Camp Narache: hand in
	-- {object:2972} Camp Narache (no name in this language: may be words)
	["{object:2972}: hand in"] = "",

	-- Step 18: Seer Graytongue and the cougars
	-- {npc:2982} Seer Graytongue
	["{npc:2982} and the cougars"] = "",
	-- {npc:2982} Seer Graytongue
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:2982} sits on the hill south of the camp; the Mountain Cougars live in those hills."] = "",

	-- Step 19: Camp Narache: the Battleboars
	-- {object:2972} Camp Narache (no name in this language: may be words)
	-- plural, as words: Battleboars = {npc:2966} Battleboar
	["{object:2972}: the Battleboars"] = "",

	-- Step 20: Brambleblade Ravine
	["Brambleblade Ravine"] = "",
	-- {quest:780} The Battleboars · {npc:8554} Chief Sharptusk Thornmantle · {item:4851} Dirt-stained Map · {quest:781} Attack on Camp Narache
	["{quest:780} graze east of the camp; the Bristleback quilboar and {npc:8554} hold Brambleblade Ravine beyond them. A {item:4851} lies in the ravine: reading it starts {quest:781}."] = "",

	-- Step 21: Camp Narache: last hand-in
	-- {object:2972} Camp Narache (no name in this language: may be words)
	["{object:2972}: last hand-in"] = "",
	-- {quest:763} Rites of the Earthmother · {npc:2993} Baine Bloodhoof
	["{quest:763}, +75: to {npc:2993}"] = "",

	-- Step 23: Bloodhoof Village (optional hub)
	-- {object:2968} Bloodhoof Village (no name in this language: may be words)
	["{object:2968} (optional hub)"] = "",
	-- {object:2968} Bloodhoof Village (no name in this language: may be words) · {zone:1412} Mulgore · {faction:81} Thunder Bluff · {npc:2993} Baine Bloodhoof · {npc:2947} Harken Windtotem · {npc:2985} Ruul Eagletalon · {npc:3222} Brave Wildrunner · {npc:2988} Morin Cloudstalker
	["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {object:2968} and eastern {zone:1412}: about 1,000 {faction:81} reputation in 45 minutes (200 at a fifth). {npc:2993} stands in the middle of the village; {npc:2947}, {npc:2985} and {npc:3222} close by; {npc:2988} waits east of the village by the road."] = "",

	-- Step 24: Eastern Mulgore
	-- {zone:1412} Mulgore
	["Eastern {zone:1412}"] = "",
	-- {quest:99079} Longwalker Malah · {object:2908} Sealed Supply Crate · {quest:764} The Venture Co.
	["{quest:99079} waits by the eastern border. The {object:2908} of the ravaged caravan lies north-east of the village: open it to start the next quest. {quest:764} mine is further north-east; the elite shredder Venture Co. Clearcutter works deep inside."] = "",
	-- {object:2908} Sealed Supply Crate
	["the {object:2908}"] = "",

	-- Step 25: Bloodhoof Village: hand in
	-- {object:2968} Bloodhoof Village (no name in this language: may be words)
	["{object:2968}: hand in"] = "",

	-- Step 26: The mine, the centaurs and the plains
	["The mine, the centaurs and the plains"] = "",
	-- {quest:765} Supervisor Fizsprocket · {npc:275767} Herak the Pillager · {zone:1412} Mulgore
	-- plural, as words: Swoops = {npc:2970} Swoop
	["Back to the mine for the workers, supervisors and {quest:765}. The Galak centaurs and {npc:275767} camp east of the village. Swoops fly all over {zone:1412}; the Windfury harpies roost south-east of the village; the Palemane gnolls camp west of it."] = "",

	-- Step 27: Bloodhoof Village: last hand-in
	-- {object:2968} Bloodhoof Village (no name in this language: may be words)
	["{object:2968}: last hand-in"] = "",
	-- {quest:99082} The High Chieftain · {npc:3057} Cairne Bloodhoof · {faction:81} Thunder Bluff
	["{quest:99082}, +10: to {npc:3057} in {faction:81}"] = "",

	-- Step 29: Bashana Runetotem: Morrowgrain Research
	-- {npc:9087} Bashana Runetotem · {object:50507} Elder Rise (no name in this language: may be words) · {item:11040} Morrowgrain
	["{npc:9087} stands on {object:50507}. If your 10 {item:11040} are not ready yet, skip this step and go on with the cloth: the cloth steps below list the {item:11040} hand-in too."] = "",

	-- Step 30: Rumstag Proudstrider: A Donation of Wool
	-- {npc:14728} Rumstag Proudstrider · {item:14047} Runecloth · {quest:7825} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14728} offers the {item:14047} donation, and {quest:7825} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "",

	-- Step 31: A Donation of Silk
	["Silk: the Syndicate in Hillsbrad and Alterac drop it about one kill in three, or buy it."] = "",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "",

	-- Step 32: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "",

	-- Step 33: A Donation of Runecloth
	-- {item:14047} Runecloth · {object:176973} Tyr's Hand (no name in this language: may be words) · {zone:1423} Eastern Plaguelands · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {object:176973} in the {zone:1423}, the Gordok ogres outside Dire Maul in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "",
	-- {item:14047} Runecloth · {object:176973} Tyr's Hand (no name in this language: may be words)
	["{item:14047}: the Scarlet outside {object:176973}"] = "",

	-- Step 34: Additional Runecloth to Honored
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Honored"] = "{quest:7825} até Honrado",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth
	["{quest:7825}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (a tauren starts at Friendly 1,000: 100 hand-ins; an Undead at Neutral 500 first needs 50 more to reach Friendly). Hand in every 20 you carry, one after another."] = "",
	-- {item:11040} Morrowgrain · {npc:9087} Bashana Runetotem
	["{item:11040}, if you grow it: {npc:9087} takes it"] = "",

	-- Step 35: Additional Runecloth to Revered
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Revered"] = "{quest:7825} até Reverenciado",
	-- {item:14047} Runecloth · {item:11040} Morrowgrain · {npc:9017} Lord Incendius
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}, fewer if you also hand in {item:11040}. Blackrock Depths pays too: Disharmony of Flame and Disharmony of Fire from Thunderheart at Kargath ({npc:9017}, 150 in full)."] = "",
	-- {item:11040} Morrowgrain
	["{item:11040}, if you grow it"] = "",

	-- Step 36: Additional Runecloth to Exalted
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Exalted"] = "{quest:7825} até Exaltado",
	-- {item:14047} Runecloth · {npc:3685} Harb Clawhoof · {object:2968} Bloodhoof Village (no name in this language: may be words)
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:3685} in {object:2968} sells the kodos to every Horde race: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685}: the kodos"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Adeptos das Trevas e Umbramantes (nível 58-60) deixam cair aqui; cada Flagelo morto aqui também conta para {object:92525} (veja esse guia). A Casa de Leilões também serve.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Ogros Dunamalho (nível 45-48) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["Keep handing in {quest:7825} until {faction:81} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continue entregando {quest:7825} até ficar Exaltado com {faction:81}. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
	-- ["Keep handing in {quest:7825}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continue entregando {quest:7825}, 20 {item:14047} por vez. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Centauros Kolkar (nível 30-33) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Seguranças da Empreendimentos S.A. em {area:381} (nível 16-17) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["{npc:14728} takes cloth for {faction:81} in {faction:81}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7825} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14728} recebe tecido para {faction:81} em {faction:81}. As primeiras doações de Lã, Seda, Magitrama e {item:14047} (60 tecidos cada) são feitas uma só vez e dão mais reputação por tecido; depois delas, {quest:7825} se repete até Exaltado. Exaltado com a cidade de outra raça permite comprar as montarias dessa raça. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- ["{npc:14728}: {item:14047} delivered"] = "{npc:14728}: {item:14047} entregue",
	-- ["{quest:7825} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7825} pede 20 {item:14047} por entrega e se repete quantas vezes você quiser. Traga {item:14047} em múltiplos de 20 e entregue tudo de uma vez, uma entrega após a outra. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
}
