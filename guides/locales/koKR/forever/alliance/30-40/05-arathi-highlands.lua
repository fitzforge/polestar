-- Korean (koKR): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "{area:42}(으)로 날아가세요",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 3: Watcher Biggs
	-- {npc:5476} Watcher Biggs · {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him.\n{npc:217412} may not be here on Forever: if {npc:217412} doesn't offer {quest:93176}, skip it."] = "",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}: 아라시, {zone:1443}, 가시덤불 골짜기에서 잡을 동물 세 마리",

	-- Step 4: The western swamp
	["The western swamp"] = "서쪽 늪",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "새끼 악어, 늪그물거미, 늪지재규어가 모두 길 주변 늪을 돌아다닙니다.",

	-- Step 6: The Harborage
	-- {area:657} The Harborage
	["Follow the road north to the draenei of the {area:657}."] = "길을 따라 북쪽으로 {area:657}의 드레나이에게 가세요.",

	-- Step 7: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {npc:256028} The Lost One
	["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "길을 따라 동쪽으로 {area:76}까지 가세요. {npc:256028} 몹이 수정을 떨어뜨리고, 노보루는 폐허를 돌아다니며 곤봉을 떨어뜨립니다.",

	-- Step 8: The Lost Caravan
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["The wrecked caravan's chest lies at the north end of the {area:76}, beside {npc:5391}'s cage.\nCareful: The camp is full of Lost Ones around level 38. They stand in linked groups of 2-3, many are casters, and they respawn quickly."] = "",

	-- Step 9: Galen Goodward
	-- {npc:5391} Galen Goodward
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards."] = "{npc:5391}은(는) 성역 북쪽 끝에 갇혀 있습니다. 그를 풀어주고 나가는 동안 살려두세요. 그 후 그의 금고가 길가에서 기다립니다.",

	-- Step 10: The Harborage
	-- {npc:5391} Galen Goodward · {area:657} The Harborage
	["West along the road from {npc:5391}'s strongbox to the {area:657}."] = "",
	-- {npc:1776} Magtoor
	["{npc:1776}: Noboru's cudgel"] = "",

	-- Step 11: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["South down the road to {npc:5476}, on the way west out of the swamp."] = "",

	-- Step 13: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "{zone:1453}(으)로 날아가세요",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "{zone:1430}을(를) 지나 서쪽으로 {area:42}까지 돌아가세요.",

	-- Step 14: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}, {area:17203} 길",

	-- Step 15: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122}은(는) {object:2101}에 있는 {object:2164}의 지하실에서 기다립니다. 그곳 소환진에서 {item:6913}을(를) 사용하고 나타나는 서큐버스를 물리치세요. {quest:65602}을(를) 받았다면 그에게 {item:190309}도 건네고, 같은 소환진에 놓은 뒤 인큐버스를 물리치세요.",
	-- {npc:5677} Summoned Succubus
	["{npc:5677}, at the summoning circle"] = "",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}, 받았다면",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}, 같은 소환진에서",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122}이(가) 인큐버스를 당신에게 귀속시킵니다",

	-- Step 16: Stormwind
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}, 빛의 대성당",

	-- Step 18: Stormwind
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}, 성채 안 왕실 도서관",

	-- Step 19: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 20: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "{area:271}(으)로 날아가세요",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 22: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore
	["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "{npc:2434}이(가) {area:271} 외곽에 보이지 않게 숨어 있습니다. 그를 처치하고 그가 지닌 계약서를 읽으세요.",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "",

	-- Step 25: Refuge Pointe
	-- {area:287} Hillsbrad · {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "길을 따라 동쪽으로 {area:287}을(를) 나가 {area:1057}을(를) 넘어 {area:320}까지 가세요.",
	-- {npc:2700} Captain Nials · {npc:1075} Rhag Garmason
	["{npc:2700}: {npc:1075}'s plea, from 01-hillsbrad-foothills"] = "",

	-- Step 26: Northfold Manor
	-- {area:320} Refuge Pointe
	["The Syndicate hold the farm north-west of {area:320}.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "",

	-- Step 27: Hay Weevil
	-- {quest:681} Northfold Manor · {npc:217412} Amaryllis Webb
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["Hay Weevils crawl about the north end of {quest:681}'s farm: catch one with the tool from {npc:217412}'s Entomology Starter Kit."] = "",

	-- Step 28: Witherbark Village
	-- {area:314} Go'Shek Farm
	["A few Witherbark trolls camp south of Northfold, on the way; the main village lies in the hills south of {area:314} in the south-east, where the Witch Doctors stand and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "",
	-- {item:5040} Shadow Hunter Knife
	["{item:5040}; below ground"] = "",

	-- Step 29: Shards of Myzrael
	-- {area:314} Go'Shek Farm · {area:333} Circle of East Binding
	["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "{area:314}을(를) 지나 북쪽으로 가세요. 파편은 {area:333} 옆 언덕에서 반짝입니다.",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "가시덤불 골짜기에서 글루글에게 펜던트를 받은 경우에만",

	-- Step 30: Drywhisker Gorge: kill these as you meet them
	-- {area:318} Drywhisker Gorge
	["{area:318}: kill these as you meet them"] = "",
	-- {area:321} Hammerfall
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "",
	-- {item:4435} Mote of Myzrael · {npc:2572} Drywhisker Kobold · {npc:2573} Drywhisker Surveyor · {npc:2574} Drywhisker Digger
	["{item:4435} from {npc:2572}, {npc:2573} and {npc:2574}, by this stop"] = "",

	-- Step 31: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "파편은 {area:318}의 맨 끝에 있습니다.",
	["Below ground"] = "",

	-- Step 32: Stones of Binding
	-- {area:320} Refuge Pointe · {object:2702} Stone of Inner Binding
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "",

	-- Step 33: Quae
	-- {area:320} Refuge Pointe · {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Head back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "",

	-- Step 34: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "급사는 경비병 둘과 함께 {area:314} 서쪽 길을 걸어다닙니다. 길에서 끌어내세요.",

	-- Step 36: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712}와(과) {npc:2713}",

	-- Step 37: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "{npc:2713}의 심부름",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way.\nCareful: Orcs that drop to low health run away. {npc:2713} follows them and can pull more mobs, so kill or slow runners fast."] = "",

	-- Step 38: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "{area:271}의 {npc:2711}에게",

	-- Step 39: Refuge Pointe
	-- {area:320} Refuge Pointe · {object:2689} Stone of West Binding
	["West along the road to {area:320}, on the way to the {object:2689}."] = "",
	-- {npc:2789} Skuerto · {npc:2793} Kor'gresh Coldrage · {area:327} Faldir's Cove
	["{npc:2789}: {npc:2793}'s cave comes after {area:327}"] = "",

	-- Step 41: Faldir's Cove
	["South along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "",

	-- Step 42: Phizzlethorpe
	["Phizzlethorpe"] = "피즐솔프",
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "",

	-- Step 44: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "난파선 두 척은 만 서쪽 바다에 있습니다. 해도와 일지는 배 안에 있고, 보석은 주변 바다 바닥에 있습니다. 비수가시일족 나가가 바다 전체를 헤엄칩니다.",
	-- {npc:2595} Daggerspine Raider
	["{npc:2595}, underwater"] = "",
	-- {item:4492} Elven Gem
	["{item:4492}; underwater"] = "",
	-- {npc:2596} Daggerspine Sorceress
	["{npc:2596}, underwater"] = "",
	-- {object:2709} Maiden's Folly Log
	["{object:2709}; underwater"] = "",
	-- {object:2707} Maiden's Folly Charts
	["{object:2707}; underwater"] = "",
	-- {object:2710} Spirit of Silverpine Log
	["{object:2710}; underwater"] = "",
	-- {object:2708} Spirit of Silverpine Charts
	["{object:2708}; underwater"] = "",

	-- Step 45: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "{area:35}의 {npc:2487}에게: 보관하세요",

	-- Step 46: Kor'gresh Coldrage
	-- {area:327} Faldir's Cove · {npc:2793} Kor'gresh Coldrage
	["East from {area:327} through the southern hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "",
	-- {item:4525} Trelane's Wand of Invocation
	["{item:4525}; below ground"] = "",

	-- Step 47: Foggy MacKreel
	-- {npc:2793} Kor'gresh Coldrage · {area:880} Thandol Span · {npc:2696} Foggy MacKreel · {quest:647} MacKreel's Moonshine · {npc:2705} Brewmeister Bilger · {area:271} Southshore · {area:320} Refuge Pointe
	["South-west from {npc:2793}'s cave to the {area:880}: {npc:2696} stands on a broken section of the bridge; jump down to him from its north end. {quest:647} must reach {npc:2705} in {area:271} within 15 minutes: go straight back to {area:320} and fly to {area:271}."] = "",

	-- Step 49: Fly to Southshore
	-- {area:320} Refuge Pointe
	["{area:320} flight master"] = "",

	-- Step 50: Brewmeister Bilger
	-- {area:271} Southshore
	["Off the flight, straight to the {area:271} inn."] = "",
	-- {npc:2705} Brewmeister Bilger
	["{npc:2705}, below ground"] = "",

	-- Step 52: Gavin's Naze
	-- {area:271} Southshore · {area:280} Strahnbrad · {npc:2306} Baron Vardus
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "길을 따라 북쪽으로 {area:271}을(를) 나가 산으로 들어가세요. 산사자가 비탈을 돌아다니고, {area:280}의 비밀결사대가 인장 반지를 끼고 있으며, {npc:2306}은(는) 마을 북쪽 저택 부지를 돌아다닙니다.",

	-- Step 53: Ruins of Alterac: kill these as you meet them
	-- {area:281} Ruins of Alterac
	["{area:281}: kill these as you meet them"] = "",
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage · Crushridge Warmongers = {npc:2287} Crushridge Warmonger · Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and carry the tomes too: pull one at a time, or group up."] = "",
	-- {item:3658} Recovered Tome
	["{item:3658}: Crushridge ogres"] = "{item:3658}: 산사태 오우거",
	-- {item:3659} Worn Leather Book · {object:1760} Weathered Bookcase
	["{item:3659}: the {object:1760}; inside"] = "",

	-- Step 54: Ruins of Alterac: kill these as you meet them
	-- {npc:2417} Grel'borg the Miser
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2417} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 55: Strahnbrad: kill these as you meet them
	-- {area:280} Strahnbrad
	["{area:280}: kill these as you meet them"] = "",
	-- {npc:2320} Nagaz
	["Careful: Syndicate Spies and Assassins can be stealthed. Assassins also poison you.\nCareful: About three stealthed Syndicate mobs are inside {npc:2320}'s house. {npc:2320} does not join when they are pulled, and a ranged attack through the doorway brings him out by himself."] = "",

	-- Step 56: Crushridge ogres
	["Crushridge ogres"] = "산사태 오우거",
	-- {area:280} Strahnbrad · {item:3706} Ensorcelled Parchment · {npc:2320} Nagaz · {quest:537} Dark Council
	-- plural, as words: Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "",
	["Inside"] = "",

	-- Step 58: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "남서쪽으로 {area:279} 서쪽 호숫가의 키린 토 야영지로 가세요. {zone:1421} 경계를 막 넘은 곳으로, {npc:269127}이(가) 그곳에 서 있습니다. 대마법사 앤자이럼은 그 남동쪽, 돔 옆에 서 있습니다.",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "{area:35}의 {npc:2542}에게: 보관하세요",

	-- Step 60: Southshore
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "{zone:1453}의 {npc:1440}에게: 보관하세요",
	-- {npc:2277} Loremaster Dibbs
	["{npc:2277}: the parchment"] = "",

	-- Step 61: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance · {item:2321} Fine Thread
	["{npc:2438} stands between the flight master and the inn; {npc:2381} beside him sells {item:2321} if you have none."] = "",
	-- {item:2321} Fine Thread · {npc:2381} Micha Yance
	["{item:2321}, from {npc:2381}"] = "",

	-- Step 64: Ironforge
	-- {npc:1356} Prospector Stormpike · {object:32356} Hall of Explorers (no name in this language: may be words) · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}, {object:32356}: for {npc:1344} in {zone:1432}, next"] = "",

	-- Step 65: To Thelsamar
	-- {area:144} Thelsamar
	["To {area:144}"] = "",

	-- Step 66: Thelsamar
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "{zone:1455}에서 동쪽 굴을 지나 {zone:1426}을(를) 거쳐 {zone:1432}에 들어간 뒤, 길을 따라 {area:144}까지 가세요.",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "",

	-- Step 67: Prospector Ironband
	["South-east along the loch to the dig site."] = "호수를 따라 남동쪽으로 발굴 현장까지 가세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "각 열쇠는 아라시 고원의 선돌 원 중 하나에 있습니다. 파편 동쪽, {area:320} 근처, 그리고 서쪽입니다. {object:2702}은(는) {area:320} 서쪽에 서 있습니다.",
	-- ["Ebenezer Rustlocke"] = "에벤에셀 러스트로크",
	-- ["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "학자를 만 북쪽 해변까지 호위하고 그가 작업하는 동안 지키세요. 나가가 여러 차례 공격해 옵니다.",
	-- ["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "길을 따라 남쪽으로 다리를 건너 {zone:1437} 쪽 끝의 {area:205}까지 가세요. 그곳에서 {npc:1075}이(가) 기다립니다.",
	-- ["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "{area:42}에서 길을 따라 동쪽으로 {zone:1430}을(를) 지나 {zone:1435}에 들어가세요. 비그스는 그 입구 바로 안쪽의 갈림길을 지킵니다. {npc:217412}은(는) 그의 조금 북쪽에 서 있습니다.",
	-- ["From {zone:1455} take the tunnel east through {zone:1426} into {area:38} and follow the road to {area:144}."] = "{zone:1455}에서 동쪽 굴을 지나 {zone:1426}을(를) 거쳐 {area:38}에 들어간 뒤, 길을 따라 {area:144}까지 가세요.",
	-- ["Gyll, {area:35}"] = "가일, {area:35}",
	-- ["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "{area:320}을(를) 지나 북동쪽으로 돌아가세요. {npc:2712}와(과) {npc:2713}은(는) {area:314} 북쪽 언덕에 진을 치고 있습니다.",
	-- ["Shaman training"] = "주술사 훈련",
	-- ["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {area:130}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "남서쪽으로 {area:279} 서쪽 호숫가의 키린 토 야영지로 가세요. {area:130} 경계를 막 넘은 곳으로, {npc:269127}이(가) 그곳에 서 있습니다. 대마법사 앤자이럼은 그 남동쪽, 돔 옆에 서 있습니다.",
	-- ["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "{npc:2713}이(가) {area:314}에 몰래 들어갔다 나오는 동안 곁에 있으세요. 가는 길에 호드 오크가 덤벼듭니다.",
	-- ["Subdue the succubus"] = "서큐버스 제압",
	-- ["Summon Succubus"] = "서큐버스 소환",
	-- ["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "산사태 오우거는 {area:280} 북쪽 언덕을 차지하고 있습니다. 더 북쪽의 낡은 나무 상자에 {item:3706}이(가) 들어 있고, {quest:537}의 {npc:2320}이(가) 바로 옆에 서 있습니다.",
	-- ["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "마른수염 코볼트는 {area:321}(호드) 동쪽 협곡에서 땅을 팝니다. 마을은 북쪽으로 돌아가세요. 그들은 티끌과 크라젝의 광석을 모두 떨어뜨립니다.",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "비밀결사대가 {area:320} 북서쪽 농장을 차지하고 있습니다. 농장에는 {npc:217589}이(가) 기어다닙니다. {npc:217412}의 곤충학 입문 도구로 한 마리를 잡은 뒤 목록에서 체크하세요.",
	-- ["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "마른나무껍질 트롤은 {area:314} 남쪽 언덕에 삽니다. 의술사는 마을에 서 있고, 어둠사냥꾼은 계곡 맨 끝을 지킵니다.",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "고서는 {area:280} 서쪽의 무너진 성채에 있습니다. 아르거스재림회 어둠마법사가 폐허를 차지하고 있습니다.",
	-- ["The wrecked caravan lies off the road near Biggs."] = "부서진 대상단 마차는 비그스 근처 길가에 있습니다.",
	-- ["The wrecks"] = "난파선",
	-- ["Walk back onto the span: Ebenezer lies under its Arathi end."] = "다리 위로 다시 걸어가세요. 에벤에셀은 다리의 아라시 쪽 끝 아래에 쓰러져 있습니다.",
	-- ["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "해안을 따라 서쪽으로 고블린의 만까지 가세요. 롤로는 그 위 바위에서 망을 봅니다.",
	-- ["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{npc:2438}의 망토용 {item:2321}, 없다면 {npc:2381}에게서",
	-- ["{item:3659}: the {object:1760}"] = "{item:3659}: {object:1760}",
	-- ["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}: {quest:93176}을(를) 위해 잡으세요",
	-- ["{npc:252085}, in the City of Dalaran"] = "{npc:252085}, 달라란 도시 안",
	-- ["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "오우거 마법사 {npc:2793}은(는) 마른나무껍질 계곡 남쪽 끝의 동굴을 차지하고 있습니다.",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453}에는 주술사 상급자가 없습니다. {object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가서 {npc:258098}에게 훈련을 받으세요. {object:32372}의 {npc:1573}도 {area:271}(으)로 날아갑니다.",
}
