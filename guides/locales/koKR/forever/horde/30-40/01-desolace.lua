-- Korean (koKR): the guide forever/horde/30-40/01-desolace (forever/horde/30-40/01-desolace.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "{area:1637}(으)로 날아가기",
	-- {area:484} Freewind Post · {area:1637} Orgrimmar
	["From {area:484}, fly to {area:1637}."] = "{area:484}에서 {area:1637}(으)로 날아가세요.",

	-- Step 2: Alliance Relations
	-- {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits · {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:5639} waits in the Drag; {npc:5640} stands in the {object:172961} on the west side of the city. Skyborne: {npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:5639}은(는) 골목길에서 기다리고, {npc:5640}은(는) 도시 서쪽의 {object:172961}에 서 있습니다. 스카이본: {npc:4949}은(는) {object:172957}의 그롬마쉬 요새에서 기다립니다.",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "그롬마쉬 요새의 {npc:4949}, 가지고 있다면",

	-- Step 3: Train
	["Train"] = "기술 배우기",
	["Train your new spells."] = "새 주문을 배우세요.",

	-- Step 4: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:460} Sun Rock Retreat
	["Your trainer is in {area:1638}, one flight away: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to {area:460} from there."] = "직업 상급자는 비행 한 번 거리의 {area:1638}에 있습니다: {area:1639}의 {npc:3033}(드루이드), {npc:246344}(성기사). 그곳에서 {area:460}(으)로 날아가세요.",

	-- Step 5: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "{zone:1454} 직업 퀘스트",
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892}은(는) {object:172957}에 서 있습니다.",

	-- Step 6: Ratchet
	-- {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly to {area:392}. {npc:5901} camps on the coast a short ride south of the town."] = "{area:392}(으)로 날아가세요. {npc:5901}은(는) 마을 남쪽으로 조금 떨어진 해안에 야영하고 있습니다.",

	-- Step 7: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post."] = "{area:484}(으)로 날아가세요. {npc:5905}은(는) 주둔지 북동쪽 협곡 벽의 작은 동굴에 숨어 있습니다.",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: {item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905}은(는) 폭풍의 무기로 이어지는 33-40 연계 퀘스트인 정기의 도움({area:1717})도 줍니다: forever/class/shaman/call-of-air-horde.",

	-- Step 8: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "{area:460}(으)로 날아가기",

	-- Step 9: Gizelton caravan
	["Gizelton caravan"] = "기젤톤 대상단",
	-- {zone:1443} Desolace · {area:608} Nijel's Point · {npc:11625} Cork Gizelton · {area:609} Kolkar Village
	["Follow the road south-west out of Sun Rock into {zone:1443} and on south past {area:608}. {npc:11625}'s kodo caravan waits by the road north of {area:609}; if it has already left, ride on."] = "해바위 야영지에서 길을 따라 남서쪽으로 {zone:1443}에 들어가 {area:608}을(를) 지나 계속 남쪽으로 가세요. {npc:11625}의 코도 대상단은 {area:609} 북쪽 길가에서 기다립니다. 이미 떠났다면 계속 가세요.",

	-- Step 10: Bodyguard for Hire
	-- {area:609} Kolkar Village · {npc:11625} Cork Gizelton · {area:2617} Scrabblescrew's Camp · {area:597} Ghost Walker Post
	["The caravan rolls south past {area:609}. Kolkar raiders ambush it in waves: kill them before they reach {npc:11625}. It stops by {area:2617}, east of {area:597}."] = "대상단은 {area:609}을(를) 지나 남쪽으로 이동합니다. 콜카르일족 약탈자가 여러 차례 습격합니다. {npc:11625}에게 닿기 전에 처치하세요. 대상단은 {area:597} 동쪽의 {area:2617} 옆에서 멈춥니다.",

	-- Step 12: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "{npc:5395}은(는) 주둔지에 있고, {npc:5641}와(과) {npc:4498}은(는) 그 서쪽, {area:596} 위의 언덕에서 기다립니다.",

	-- Step 13: Kodo Roundup
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. Five kodos, one at a time."] = "묘지의 늙은 코도, 임종의 코도, {npc:4702}에게 {npc:11596}의 {item:13892}을(를) 사용하고, 길들인 코도를 {npc:11596}에게 데려가세요. 다섯 마리를 한 번에 한 마리씩 데려갑니다.",

	-- Step 14: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	["Ride north-east to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health."] = "북동쪽의 {area:609}(으)로 가세요. {quest:1365}(35)은(는) 전투대장 한두 명(32-33)과 함께 동쪽 천막 사이를 돌아다닙니다. 주변을 정리한 뒤 생명력이 가득 찬 상태에서 그만 끌어오세요.",

	-- Step 15: Sargeron
	-- {area:603} Sargeron
	["North along the eastern hills, the satyrs hold the ruins of {area:603}. The Shadowstalkers walk unseen; the four kinds you need do not."] = "동쪽 언덕을 따라 북쪽으로 가면 사티로스가 {area:603}의 폐허를 차지하고 있습니다. 그림자추적자는 보이지 않게 다니지만, 필요한 네 종류는 그렇지 않습니다.",

	-- Step 16: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {item:20310} Flayed Demon Skin
	["Ride west to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. They also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "서쪽의 {area:599}(으)로 가세요. 불타는 칼날단 이교도를 거의 죽을 때까지 때린 뒤, 죽기 전에 {item:6436}을(를) 사용해 {item:6435}을(를) 하나 채우세요. 가끔(1-5%) {item:20310}도 떨어뜨립니다. 얻으면 읽으세요.",

	-- Step 17: Ghost Walker Post
	["Ride back south to the post."] = "남쪽의 주둔지로 돌아가세요.",
	-- {npc:5641} Takata Steelblade · {quest:1431} Alliance Relations · {zone:1454} Orgrimmar
	["{npc:5641}'s next {quest:1431} sends you back to {zone:1454} for nothing: leave it."] = "{npc:5641}의 다음 퀘스트인 {quest:1431}은(는) 아무 소득 없이 {zone:1454}(으)로 돌려보냅니다. 받지 마세요.",

	-- Step 18: Kolkar ears
	["Kolkar ears"] = "콜카르일족 귀",
	-- {area:609} Kolkar Village
	["Back at {area:609}, every Kolkar can drop an ear."] = "{area:609}에서는 모든 콜카르일족이 귀를 떨어뜨릴 수 있습니다.",

	-- Step 19: Shadowstalker scalp
	["Shadowstalker scalp"] = "그림자추적자의 머리가죽",
	-- {area:603} Sargeron
	-- plural, as words: Hatefury Shadowstalkers = {npc:4674} Hatefury Shadowstalker
	["The Hatefury Shadowstalkers at {area:603} walk unseen until they strike; about one in three carries a scalp."] = "{area:603}의 서릿발분노의 그림자추적자는 공격할 때까지 보이지 않습니다. 세 마리 중 한 마리 정도가 머리가죽을 지니고 있습니다.",

	-- Step 21: Shadowprey Village
	-- {area:606} Gelkis Village
	["Ride south-west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "남서쪽 해안의 트롤 마을로 가세요. 가는 길에 {area:606}은(는) 피하세요.",
	-- {npc:11877} Roon Wildmane · {npc:715} Hemet Nesingwary
	["{npc:11877}: for {npc:715} in Stranglethorn"] = "{npc:11877}: 가시덤불 골짜기의 {npc:715}에게",

	-- Step 22: Clam beds
	["Clam beds"] = "조개 서식지",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler
	["Ride north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "해안을 따라 북쪽으로 가세요. 커다란 연갑 조개는 얕은 물에 있고, 사나운 모래톱게는 해변을 돌아다닙니다. 조개는 가방에서 열어 살을 꺼내세요.",

	-- Step 23: Slitherblade Oracles
	-- plural, as words: Slitherblade Oracles = {npc:4718} Slitherblade Oracle
	["Slitherblade Oracles"] = "뱀갈퀴일족 예언자",
	-- {area:598} Sar'theris Strand
	["Keep north to {area:598}. The Oracles stand among the other naga at its north end; pull one at a time."] = "계속 북쪽의 {area:598}(으)로 가세요. 예언자는 북쪽 끝에 다른 나가들과 함께 있습니다. 한 번에 하나씩 끌어오세요.",

	-- Step 24: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["{npc:11863} waits in the ruined tower of {area:2405}, inland to the south-east."] = "{npc:11863}은(는) 내륙 남동쪽 {area:2405}의 무너진 탑에서 기다립니다.",

	-- Step 25: Burning Blade Seer
	-- {area:599} Thunder Axe Fortress · {area:2405} Ethel Rethor
	["The Seer stands on the south side of {area:599}, east of {area:2405}. Clear the cultists around it first."] = "현자는 {area:2405} 동쪽, {area:599} 남쪽에 서 있습니다. 먼저 주변의 이교도를 처치하세요.",

	-- Step 26: Ethel Rethor
	["His next errand is not on this route."] = "그의 다음 심부름은 이 경로에 없습니다.",

	-- Step 27: Ghost Walker Post
	["Ride south-east to the post."] = "남동쪽의 주둔지로 가세요.",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "{npc:5641}의 다음 심부름은 정예 호위병을 거느린 악마 군주를 쫓게 합니다. 건너뛰세요.",

	-- Step 28: Gelkis Village
	["Ride south-west towards Shadowprey. The Gelkis centaurs (32-35) around their village are a good camp; fight them until level 32."] = "남서쪽의 그늘수렵 마을 쪽으로 가세요. 마을 주변의 겔키스일족 켄타우로스(32-35)는 사냥하기 좋습니다. 32레벨까지 처치하세요.",
	-- {area:606} Gelkis Village · {zone:1443} Desolace
	-- plural, as words: Gelkis Stampers = {npc:4648} Gelkis Stamper
	["grind on Gelkis Stampers and Windchasers at the {area:606}, {zone:1443}"] = "{zone:1443} {area:606}에서 겔키스일족 곤봉잡이와 바람전사 사냥",

	-- Step 30: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638} from Shadowprey and train with {npc:3033} on {area:1639}, then fly on to {zone:1454}."] = "그늘수렵 마을에서 {area:1638}(으)로 날아가 {area:1639}의 {npc:3033}에게서 기술을 배운 뒤, {zone:1454}(으)로 날아가세요.",

	-- Step 31: Fly to Orgrimmar
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408} 비행 조련사",

	-- Step 32: Zeppelin to the Undercity
	-- {area:1497} Undercity
	["Zeppelin to the {area:1497}"] = "{area:1497}행 비행선",
	-- {zone:1454} Orgrimmar · {area:1497} Undercity
	["Leave {zone:1454} by the main gate; the zeppelin tower stands just north-east of it. Take the {area:1497} zeppelin."] = "정문으로 {zone:1454}을(를) 나가세요. 비행선 탑은 그 바로 북동쪽에 있습니다. {area:1497}행 비행선을 타세요.",
	["Zeppelin tower"] = "비행선 탑",

	-- Step 33: Garen Largo
	-- {npc:260093} Garen Largo · {area:1497} Undercity
	["{npc:260093} trains Paladins in the {area:1497}."] = "{npc:260093}은(는) {area:1497}에서 성기사를 가르칩니다.",

	-- Step 34: Brazier of Everfount
	-- {area:1497} Undercity · {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Do your shopping in the {area:1497} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "먼저 {area:1497}에서 쇼핑을 마친 뒤 {area:228}(으)로 날아가세요. {object:113791}은(는) 그 바로 남서쪽 언덕에 있습니다. 옆의 타락한 물의 현신을 쓰러뜨리고, 그 손목보호대를 화로에 넣은 뒤 {npc:5895}에게 말을 걸고, {item:7813}은(는) {npc:5901}을(를) 위해 보관하세요. {area:228}에서 {area:272}(으)로 날아가세요.",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}: from Stranglethorn, next guide"] = "{npc:5901}에게: 다음 가이드에서 가시덤불 골짜기에서",

	-- Step 35: Undercity
	-- {quest:515} Elixir of Agony · {item:3388} Strong Troll's Blood Potion · {skill:171} Alchemy · {area:287} Hillsbrad
	["{quest:515} needs a {item:3388}, an {skill:171} item: buy one at the auction house here if you can (or ask an alchemist). No potion: skip the Elixir steps in {area:287}."] = "{quest:515}에는 {skill:171} 아이템인 {item:3388}이(가) 필요합니다. 가능하면 이곳 경매장에서 사세요(또는 연금술사에게 부탁하세요). 물약이 없으면 {area:287}의 비약 단계는 건너뛰세요.",
	-- {item:3388} Strong Troll's Blood Potion · {quest:515} Elixir of Agony
	["{item:3388}: auction house or an alchemist, for {quest:515}."] = "{item:3388}: {quest:515}을(를) 위해 경매장이나 연금술사에게서",
	-- {npc:4551} Michael Garrett
	["{npc:4551}, the bat handler"] = "박쥐 조련사 {npc:4551}",

	-- Step 36: Tarren Mill
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{npc:2333}에게 줄 {item:3703}",
	-- {npc:2770} Tallow · {area:321} Hammerfall
	["{npc:2770}: for {area:321} in Arathi, later on the route"] = "{npc:2770}: 나중에 경로상의 아라시 고원 {area:321}에서",
	-- {npc:2229} Krusk · {zone:1413} Barrens
	["{npc:2229}: for the {zone:1413}, later on the route"] = "{npc:2229}: 나중에 경로상의 {zone:1413}에서",

	-- Step 37: Daggerspine naga
	["Daggerspine naga"] = "비수가시일족 나가",
	-- {area:271} Southshore
	["Ride south, east of {area:271}, down to the coast. The Daggerspine naga line the shore south-east of the town."] = "{area:271} 동쪽으로 남쪽 해안까지 내려가세요. 비수가시일족 나가가 마을 남동쪽 해안에 늘어서 있습니다.",
	["Daggerspine shore"] = "비수가시일족 해안",

	-- Step 38: Torn Fin murlocs
	["Torn Fin murlocs"] = "너덜지느러미멀록",
	-- {area:271} Southshore
	["Follow the shore west past {area:271}'s bay; the Torn Fin murlocs camp on the beaches beyond it."] = "해안을 따라 서쪽으로 {area:271}의 만을 지나가세요. 너덜지느러미멀록은 그 너머 해변에 야영하고 있습니다.",
	["Torn Fin beach"] = "너덜지느러미멀록 해변",

	-- Step 39: Apothecary Lydon
	-- {area:272} Tarren Mill · {area:271} Southshore
	["Ride back north to {area:272}, keeping west of {area:271}."] = "{area:271} 서쪽으로 북쪽의 {area:272}까지 돌아가세요.",

	-- Step 40: Shindigger keg
	["Shindigger keg"] = "신디거 흑맥주 통",
	-- {area:287} Hillsbrad
	["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "맥주 통은 {area:287} 남동쪽 해안의 비밀결사대 야영지에 다른 통 몇 개와 함께 있습니다.",

	-- Step 41: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "{area:272}(으)로 돌아가기",
	["Hearth back (or ride north if it is on cooldown)."] = "귀환석으로 돌아가세요(재사용 대기 중이면 북쪽으로 달려가세요).",
	-- {object:1729} Tainted Keg · {object:1728} Dusty Rug
	["Place the {object:1729} on the {object:1728} beside the inn"] = "여관 옆의 {object:1728} 위에 {object:1729}을(를) 놓으세요",

	-- Step 42: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik
	["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "길을 따라 {area:272}에서 북쪽으로 알터랙 산기슭으로 가세요. {quest:535}은(는) 비밀결사대 야영지 옆에서 기다립니다. 흑맥주를 건네세요.",

	-- Step 43: Syndicate missives
	["Syndicate missives"] = "비밀결사대 서신",
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "길 서쪽 야영지 주변의 비밀결사대 노상강도와 도둑(32-33)이 서신을 지니고 있습니다. 세 명 중 한 명 정도가 떨어뜨립니다.",

	-- Step 44: Helcular's Rod
	-- {area:272} Tarren Mill
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti
	["South-west, the Cave and Ferocious Yetis (30-31) fill the caves in the hills west of {area:272}; about one in sixteen carries the rod."] = "남서쪽, {area:272} 서쪽 언덕의 동굴에는 동굴 설인과 사나운 설인(30-31)이 가득합니다. 열여섯 마리 중 한 마리 정도가 막대를 지니고 있습니다.",

	-- Step 45: The Dalaran traitors
	-- {area:279} Dalaran
	["The {area:279} traitors"] = "{area:279}의 배신자",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens."] = "산기슭을 따라 서쪽으로 {area:279}의 보랏빛 돔으로 가세요. {npc:2411}, {npc:2412}, {npc:2413}(33-34)은(는) 분화구 동쪽 가장자리 안쪽에 함께 서 있고, {npc:2414}(35)은(는) 그 조금 서쪽에 있습니다. 각자 피의 돌 조각을 하나씩 지니고 있습니다. 주변의 수호기사와 사술사(31-32)가 닳은 돌 징표를 떨어뜨립니다.",

	-- Step 46: Tarren Mill
	-- {area:272} Tarren Mill
	["Ride back east to {area:272}."] = "동쪽의 {area:272}(으)로 돌아가세요.",
	-- {area:271} Southshore
	["Thaivand's next task ends at {area:271}'s graveyard and the magus offers a dungeon errand: leave both."] = "타이반드의 다음 임무는 {area:271} 묘지에서 끝나고, 마법사는 던전 심부름을 줍니다. 둘 다 받지 마세요.",

	-- Step 47: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Ride north past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side."] = "{quest:535}의 야영지를 지나 북쪽으로 비밀결사대가 차지한 마을 {area:280}(35-37)(으)로 가세요. {npc:2431}이(가) {item:3704}을(를) 지니고 있습니다. {quest:503}은(는) 북쪽 집 안의 우리에 갇혀 있습니다.",

	-- Step 48: Tarren Mill
	-- {area:272} Tarren Mill
	["Ride back south to {area:272}."] = "남쪽의 {area:272}(으)로 돌아가세요.",

	-- Step 49: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "{area:1497}(으)로 날아가기",
	-- {area:1497} Undercity · {object:3202} Grom'gol
	["The next guide starts in the {area:1497}, at the {object:3202} zeppelin."] = "다음 가이드는 {area:1497}의 {object:3202}행 비행선에서 시작합니다.",
}
