-- Korean (koKR): the guide forever/horde/30-40/05-arathi-highlands (forever/horde/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 2: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "{zone:1458} 상급자",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "{zone:1458}에 있는 동안 기술을 배우세요. 상급자는 {object:36070}, {object:36073}, {object:36082}에 있습니다(성기사: {npc:260093}).",

	-- Step 3: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "{area:272}(으)로 날아가기",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "",

	-- Step 4: Tarren Mill
	-- {npc:2229} Krusk
	["{npc:2229}, inside the inn"] = "",
	-- {object:1763} WANTED
	["The {object:1763} poster by the inn"] = "여관 옆의 {object:1763} 게시판",

	-- Step 6: Gol'dir
	-- {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north past Valik's camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "",
	["Inside"] = "",
	-- {quest:503} Gol'dir
	["Find where {quest:503} is held, on the top floor"] = "",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "",

	-- Step 8: Tarren Mill
	-- {npc:2229} Krusk · {area:272} Tarren Mill
	["{npc:2229} waits inside the inn at {area:272}, back south down the road."] = "",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",

	-- Step 9: Baron Vardus
	-- {npc:2306} Baron Vardus · {area:280} Strahnbrad · {quest:503} Gol'dir
	["{npc:2306} (40) carries the head. He turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village, which lie on your way to the Perenolde manor. If you already met him while freeing {quest:503}, this step is done."] = "",

	-- Step 10: Alterac Mountains
	["Perenolde manor"] = "",

	-- Step 11: Lord Aliden Perenolde
	-- {area:1339} Lordamere Lake · {quest:507} Lord Aliden Perenolde · {npc:2317} Elysa
	["Head north-west through the mountains to the Perenolde manor on the northern shore of {area:1339}. {quest:507} (41) waits in a room upstairs: he shields himself, puts you to sleep and heals below half health. {npc:2317} stands beside him."] = "",

	-- Step 12: Old Dalaran Ruins: kill these as you meet them
	-- {area:17707} Old Dalaran Ruins
	["{area:17707}: kill these as you meet them"] = "",
	-- {area:279} Dalaran
	-- plural, as words: Dalaran Summoners = {npc:2358} Dalaran Summoner · Elemental Slaves = {npc:2359} Elemental Slave
	["South along the lake shore to the ruins around the {area:279} crater. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves."] = "",

	-- Step 14: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back east to {area:272}."] = "",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "",
	["The magus offers a dungeon errand next: leave it."] = "",

	-- Step 15: Thoradin's Wall
	-- {area:1057} Thoradin's Wall
	["The road east through {area:1057}"] = "",

	-- Step 16: Northfold Manor
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["Head east out of {area:272} through {area:1057}. The Syndicate hold the walled manor and its farm north of the road; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "",

	-- Step 17: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["Follow the road east. The violet shards glow just off the road a short way west of {area:321}."] = "",

	-- Step 18: Hammerfall
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "",

	-- Step 19: Stromgarde quests for a group
	["Stromgarde quests for a group"] = "",
	-- {npc:2703} Zengu · {quest:639} Sigil of Strom
	["{npc:2703}'s {quest:639} drops from the elite Syndicate (35-38) in Stromgarde's ruins, the west of the highlands. Great XP if you have a group for it: the route passes Stromgarde on its way to the inner circle."] = "",

	-- Step 20: Foul Magics with a group
	-- {quest:671} Foul Magics
	["{quest:671} with a group"] = "",
	-- {npc:2706} Tor'gan · {quest:671} Foul Magics · {npc:2783} Marez Cowl
	["{npc:2706}'s next {quest:671} is {npc:2783}, a level 40 elite warlock in Stromgarde's Syndicate quarter."] = "",

	-- Step 21: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "",

	-- Step 22: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701}은(는) 골짜기 맨 끝에 있습니다.",
	["Below ground"] = "",

	-- Step 23: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "",

	-- Step 24: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall, far south-west of {area:321}; the Magus stand among them. Pull them one at a time."] = "",

	-- Step 25: Fleshstalker raptors
	["Fleshstalker raptors"] = "식인 고원랩터",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "식인 고원랩터(36-37)는 고원 남부에서 사냥합니다. 한 무리는 {area:316} 북쪽에, 다른 무리는 그 서쪽 평원에 있습니다. 한 번에 한 마리씩 끌어오세요.",

	-- Step 26: Go'shek Farm
	["Go'shek Farm"] = "",
	-- {npc:2733} Apothecary Jorell · {area:321} Hammerfall · {item:278462} Packaged Tonics
	["{npc:2733}'s lab shack stands at Go'shek Farm, north-east of the raptors' plain on the way back to {area:321}; the case of {item:278462} is inside."] = "",

	-- Step 27: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "{area:321}(으)로 돌아가기",
	-- {area:321} Hammerfall
	["Back north-east to {area:321}."] = "",

	-- Step 28: Boulderfist quests for a group
	["Boulderfist quests for a group"] = "",
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms · {npc:2772} Korin Fel · {quest:680} The Real Threat
	["{npc:2771}'s next {quest:678} and {npc:2772}'s {quest:680} are the elite ogres (38-40) in Stromgarde's ogre quarter, on the same group trip as the Sigil."] = "",
	-- {npc:2772} Korin Fel
	["{npc:2772}, beside him"] = "",

	-- Step 29: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head west; the outer circle stands in the middle of the highlands."] = "",

	-- Step 30: Circle of West Binding
	-- {area:1057} Thoradin's Wall
	["The western circle is near {area:1057}, north-west of the outer one."] = "",

	-- Step 31: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "안쪽 결속의 원은 서쪽 결속의 원 남쪽, 스트롬가드 동쪽에 있습니다.",
	-- {area:321} Hammerfall
	["The stone's next task needs Fozruk, a level 42 elite who roams west of {area:321}: leave it."] = "",

	-- Step 32: Stromgarde
	["Stromgarde"] = "",
	-- {npc:2783} Marez Cowl · {area:325} Tower of Arathor · {npc:2773} Or'Kalar
	["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi; {npc:2783} is among them), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "",

	-- Step 33: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "",

	-- Step 34: Professor Phizzlethorpe
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "",

	-- Step 36: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "만 서쪽 해안은 비수가시일족 침략자와 여마법사(38-40)가 차지하고 있습니다. 한 번에 하나씩 끌어오세요. 난파선 두 척은 앞바다 얕은 물에 있으며, 해도와 항해일지는 그 안에, 보석은 난파선 주변 해저에 있습니다.",
	["Underwater"] = "",

	-- Step 37: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 41"] = "",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {zone:1418} Badlands
	["The next guide crosses the {area:880} into the {zone:1437} and heads for the {zone:1418}."] = "",

	-- Step 38: Back to Hammerfall
	-- {area:321} Hammerfall · {area:880} Thandol Span
	["Only if you ran Stromgarde with a group: back to {area:321} for its hand-ins, then on to the {area:880}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "돌주먹일족 투사는 {area:321} 남쪽 오우거 전당 밖에 야영하고 있으며, 사제가 그들 사이에 있습니다. 한 번에 하나씩 끌어오세요.",
}
