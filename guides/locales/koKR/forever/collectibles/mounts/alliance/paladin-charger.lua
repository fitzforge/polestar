-- Korean (koKR): the guide forever/collectibles/mounts/alliance/paladin-charger (forever/collectibles/mounts/alliance/paladin-charger.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Charger"] = "성기사 군마",
	["Your epic mount at 60, summoned at will: the faster step up from the Warhorse."] = "60레벨의 영웅 탈것으로, 언제든 소환할 수 있습니다. 전투마보다 빠른 상위 탈것입니다.",

	-- Step 1: Lord Grayson Shadowbreaker (Ironforge)
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:7638} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 60 {npc:5149} in the {object:32362} sends you to {quest:7638} in {zone:1453}'s Cathedral of Light."] = "60레벨에 {object:32362}의 {npc:5149}이(가) 당신을 {zone:1453} 빛의 대성당의 {quest:7638}에게 보냅니다.",

	-- Step 2: Lord Grayson Shadowbreaker
	-- {spell:23214} Summon Charger · {area:2279} Stratholme · {area:2057} Scholomance · {item:14047} Runecloth · {item:8836} Arthas' Tears · {npc:6171} Duthorian Rall
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["The {spell:23214} chain is long: {area:2279}, Dire Maul West and {area:2057} with a group, 350 gold in donations, and materials worth several hundred more (6 Arcanite Bars, 40 {item:14047}, 10 {item:8836}, two diamonds). Start saving early. Lord Grayson stands in the Cathedral of Light, {npc:6171} nearby."] = "",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}, 빛의 대성당",

	-- Step 3: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406}, the priest trainer, walks about the {object:32386} in {zone:1455}'s {object:32362}. He gives you his censer for a donation of 150 gold, taken at the hand-in. Keep the censer."] = "",
	-- {npc:11406} High Priest Rohan
	["{npc:11406}: 150 gold"] = "{npc:11406}: 150골드",

	-- Step 4: Back to Lord Grayson
	["Back to Lord Grayson"] = "그레이슨 경에게 돌아가기",
	-- {item:18752} Exorcism Censer · {area:2627} Terrordale
	["Lord Grayson blesses the censer into the {item:18752} for {area:2627}."] = "",

	-- Step 5: Exorcising Terrordale
	-- {area:2627} Terrordale · {zone:1423} Eastern Plaguelands · {area:2279} Stratholme · {object:179747} Terrordale Haunting Spirit (no name in this language: may be words) · {item:18752} Exorcism Censer · {spell:7713} Wailing Dead · {spell:2878} Turn Undead
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["{area:2627} lies in the far north-west of the {zone:1423}, west of the {area:2279} gates. Stand inside a green glowing patch on the ground (a {object:179747}; some are inside the ruined houses) and use the {item:18752}: up to three Terrordale Spirits (level 59-60) rise and attack. Their {spell:7713} lowers all your stats by 30%: fight them one at a time and use {spell:2878}. The patches come back quickly; several paladins can work side by side."] = "",
	-- {item:18752} Exorcism Censer
	["{item:18752}, inside a green patch"] = "",
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Terrordale Spirits x25"] = "Terrordale Spirit x25",

	-- Step 6: Lord Grayson Shadowbreaker
	["Lord Grayson takes the censer back."] = "",

	-- Step 7: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {object:28027} Dwarven District · {item:18753} Arcanite Barding
	["{npc:1416} works in {zone:1453}'s {object:28027}. He forges the {item:18753} from your materials and 150 gold."] = "{npc:1416}은(는) {zone:1453}의 {object:28027}에서 일합니다. 재료와 150골드로 {item:18753}을(를) 만들어 줍니다.",

	-- Step 8: Grimand Elmore's materials
	-- {npc:1416} Grimand Elmore
	["{npc:1416}'s materials"] = "{npc:1416}의 재료",
	-- {item:14047} Runecloth · {area:2255} Everlook · {area:2577} Dire Maul · {item:8836} Arthas' Tears · {skill:182} Herbalism · {area:3197} Chillwind Camp · {item:12360} Arcanite Bar · {item:12359} Thorium Bar · {item:12363} Arcane Crystal
	["{item:14047} drops from humanoids of level 50 and up ({area:2255}'s Bruisers, the Scarlet Crusade in the Plaguelands, the {area:2577} ogres). {item:8836} is a Plaguelands herb ({skill:182} 220), common around {area:3197}. An {item:12360} is an alchemist's transmute from a {item:12359} and an {item:12363}, once every two days per alchemist: ask a guild alchemist early, or buy the bars. The Auction House sells all three."] = "",
	-- {item:14047} Runecloth
	["{item:14047} x40"] = "",
	-- {item:8836} Arthas' Tears
	["{item:8836} x10"] = "",
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Arcanite Bars x6: an alchemist, or the Trade District Auction House"] = "아케이나이트 주괴 x6: 연금술사 또는 상업 지구 경매장",

	-- Step 9: Stratholme Holy Water
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands
	-- plural, as words: Stratholme Supply Crates = {object:181085} Stratholme Supply Crate
	["{area:2279} is a dungeon for a group of five at 58-60, at the north end of the {zone:1423}. Stratholme Supply Crates along the streets of both halves hold the Holy Water, one to three each; they come back after three minutes. Some crates let out a swarm of plagued rats or maggots: be ready. The main gate (the Scarlet half) needs no key."] = "",
	-- plural, as words: Stratholme Supply Crates = {object:181085} Stratholme Supply Crate
	["Stratholme Supply Crates, inside"] = "",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {item:18753} Arcanite Barding
	["Bring the materials and 150 gold, taken at the hand-in. {npc:1416} walks to his forge and hands you the {item:18753}."] = "",
	-- {npc:1416} Grimand Elmore
	["{npc:1416}: 150 gold"] = "{npc:1416}: 150골드",

	-- Step 11: Lord Grayson Shadowbreaker
	["Lord Grayson keeps the barding for now: you get it back with the next quest."] = "",
	-- {npc:928} Lord Grayson Shadowbreaker · {item:18753} Arcanite Barding
	["{npc:928}: the {item:18753}"] = "{npc:928}: {item:18753}",

	-- Step 12: Enriched Manna Biscuits
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits"] = "맛 좋은 만나빵",
	-- {object:2160} The Argent Dawn · {object:92525} Argent Dawn · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["{object:2160} quartermasters sell Enriched Manna Biscuits, five for 60 silver, once the {object:92525} is Friendly with you: {npc:10857} at {area:3197} or {npc:11536} at {area:2268}. Scourgestones and the Plaguelands quests raise the standing."] = "{object:92525} 평판이 우호적이 되면 {object:2160} 병참장교가 영양 만나빵을 5개에 60실버로 팝니다. {area:3197}의 {npc:10857} 또는 {area:2268}의 {npc:11536}. 스컬지석과 역병지대 퀘스트로 평판이 오릅니다.",
	-- {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits: {npc:10857}, {area:3197}"] = "맛 좋은 만나빵: {npc:10857}, {area:3197}",

	-- Step 13: Merideth Carlson
	-- {npc:2357} Merideth Carlson · {area:271} Southshore · {quest:7645} Manna-Enriched Horse Feed
	["{npc:2357} breeds horses in {area:271}'s stable. She makes the {quest:7645} from the 20 biscuits and 50 gold, taken at the hand-in."] = "{npc:2357}은(는) {area:271}의 마구간에서 말을 기릅니다. 그녀가 만나빵 20개와 50골드로 {quest:7645}을(를) 만들며, 골드는 제출할 때 가져갑니다.",

	-- Step 14: Dire Maul: Tendris Warpwood
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {item:18249} Crescent Key · {npc:11489} Tendris Warpwood · {npc:11459} Ironbark Protector · {quest:7643} Ancient Equine Spirit · {item:18753} Arcanite Barding
	["{area:2577} lies in central {zone:1444}. From the gate at the foot of the ruins, walk up through the outer courtyards to the West wing's door at their north end; it needs a {item:18249} (from Pusillin in Dire Maul East) or a rogue's lockpicking. {npc:11489} (level 60 elite) stands at the far end of the West wing's first courtyard. Once attacked he calls every {npc:11459} still alive in the courtyard: kill them first. His death frees the {quest:7643}: talk to it to give it the horse feed and the {item:18753}, and it blesses the barding. A group of five at 60."] = "",
	["Dire Maul West's door"] = "",
	-- {npc:11489} Tendris Warpwood
	["{npc:11489}, inside the West wing"] = "{npc:11489}, 서쪽 구역 안",

	-- Step 16: Two diamonds
	["Two diamonds"] = "다이아몬드 두 개",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {npc:14695} Lord Blackwood
	["An {item:12800} comes from Thorium veins and obsidian, about one vein in a hundred; a {item:18335} drops rarely from elites of level 59 and up (Revanchion and {npc:14695} about one kill in nine and one in a hundred). The Auction House is the usual source of both."] = "",

	-- Step 17: Lord Grayson Shadowbreaker
	-- {item:18804} Lord Grayson's Satchel · {item:18746} Divination Scryer · {item:18792} Blessed Arcanite Barding
	["Lord Grayson hands you {item:18804}: open it for the {item:18746} and the {item:18792}. Keep both."] = "",
	-- {item:18792} Blessed Arcanite Barding
	["{item:18792}, from the satchel"] = "",

	-- Step 18: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {object:179746} The Great Ossuary (no name in this language: may be words) · {item:18746} Divination Scryer · {spell:1105} Seal of Wisdom · {npc:14516} Death Knight Darkreaver · {item:18749} Charger's Lost Soul · {item:18792} Blessed Arcanite Barding · {npc:14568} Darkreaver's Fallen Charger
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}; the door needs the {item:13704} (The Key to {area:2057}). Clear the {object:179746}, Rattlegore's room in the basement, then use the {item:18746} at its centre. Four waves of spirits come, each ending with an Aspect: players judge them with {spell:1105}, Justice, Righteousness and then Light, which stuns them. {npc:14516} (level 62 elite) comes after the last; he mind-controls players. Loot the {item:18749}, use it inside the Ossuary to redeem it, and give it and the {item:18792} to {npc:14568}. If the group wipes, the gates lock and the scryer is gone: abandon the quest and take it again from Lord Grayson for a new satchel. A group of five at 60. Again Into the {object:179746}, after the mount, lets you fight him again."] = "",
	-- {item:18749} Charger's Lost Soul · {object:179746} The Great Ossuary (no name in this language: may be words)
	["{item:18749}, inside the {object:179746}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: the Auction House is the usual source."] = "{item:12800}은(는) 토륨 광맥에서, {item:18335}은(는) {zone:1422}의 정예 몹에게서 나오며 둘 다 드뭅니다. 보통은 경매장에서 구합니다.",
	-- ["Bring 150 gold for {npc:1416} along with the materials."] = "재료와 함께 {npc:1416}에게 줄 150골드를 가져가세요.",
	-- ["Supply Crates, inside"] = "보급품 상자, 던전 안",
	-- ["The {spell:23214} chain is long: it takes you through {area:2279}, {area:2577} and {area:2057}, and costs about 350 gold in donations on top of the materials. Lord Grayson stands in the Cathedral of Light."] = "{spell:23214} 연계 퀘스트는 깁니다. {area:2279}, {area:2577}, {area:2057}을(를) 거치며, 재료 외에 기부금으로 약 350골드가 듭니다. 그레이슨 경은 빛의 대성당에 서 있습니다.",
	-- ["he hands you the {item:18746}"] = "그가 {item:18746}을(를) 줍니다",
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057}은(는) {zone:1422} 남동쪽의 섬 마을인 {area:2298} 아래에 있습니다. 거대한 납골당 지하실 중앙에서 {item:18746}을(를) 사용하고, 나타나는 영혼들과 {npc:14516}을(를) 물리친 뒤, 그의 쓰러진 군마에게 {item:18799}와(과) {item:18792}을(를) 주세요. 모두 정예이니 파티를 데려가세요. 실패하면 그레이슨 경이 다시 거대한 납골당으로 퀘스트를 통해 새 점술 도구를 줍니다.",
	-- ["{area:2279} is a group of five, level 58-60, at the north end of the {zone:1423}. The Supply Crates scattered through the city hold the {item:13180}."] = "{area:2279}은(는) {zone:1423} 북쪽 끝의 58-60레벨 5인 던전입니다. 도시 곳곳에 흩어진 보급품 상자에 {item:13180}이(가) 들어 있습니다.",
	-- ["{area:2577} lies in central {zone:1444}; {npc:11489} guards the start of the West wing. Defeat him to free the {quest:7643}, feed it the {item:18775} and hand it the {item:18753} to bless. Bring a group."] = "{area:2577}은(는) {zone:1444} 중부에 있습니다. {npc:11489}이(가) 서쪽 구역 입구를 지킵니다. 그를 물리쳐 {quest:7643}을(를) 풀어준 뒤, {item:18775}을(를) 먹이고 {item:18753}을(를) 건네 축복을 받으세요. 파티를 데려가세요.",
	-- ["{area:2627} lies in the far north-west of the {zone:1423}, by the {zone:1422} border. Use the {item:18752} there to drive out the spirits, then defeat them."] = "{area:2627}은(는) {zone:1423} 북서쪽 끝, {zone:1422} 경계 옆에 있습니다. 그곳에서 {item:18752}을(를) 사용해 영혼을 몰아낸 뒤 물리치세요.",
	-- ["{item:14047} drops from humanoids around level 50 and up; {item:8836} is an herb of the Plaguelands and {zone:1448}; Arcanite Bars are an {skill:171} transmute. The Auction House in {zone:1453}'s {object:2096} sells all three, and so do crafters."] = "{item:14047}은(는) 약 50레벨 이상의 인간형 몹이 떨어뜨립니다. {item:8836}은(는) 역병지대와 {zone:1448}의 약초이고, 아케이나이트 주괴는 {skill:171} 변환으로 만듭니다. 셋 다 {zone:1453} {object:2096}의 경매장이나 제작자에게서 살 수 있습니다.",
	-- ["{npc:11406} is in {zone:1455}'s {object:32362}. Bring 150 gold: the censer is yours for a donation."] = "{npc:11406}은(는) {zone:1455}의 {object:32362}에 있습니다. 150골드를 가져가세요. 기부를 하면 향로를 받습니다.",
}
