-- Korean (koKR): the guide forever/class/warrior/fire-hardened-armor (forever/class/warrior/fire-hardened-armor.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Fire Hardened Armor"] = "불에 달궈 만든 갑옷",
	["Starts now at 20 with a shield; a hauberk at 28, then a coif, leggings and gauntlets from three smiths."] = "",

	-- Step 1: Yorus Barleybrew (Stormwind)
	-- {npc:5479} Wu Shen · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5479}, beside {npc:5480} in the warrior trainers' building of {object:2100}, sends you to {quest:1698} in Redridge."] = "20레벨에 {object:2100} 전사 상급자 건물의 {npc:5480} 옆에 있는 {npc:5479}이(가) 붉은마루 산맥의 {quest:1698}에게 보냅니다.",

	-- Step 2: Yorus Barleybrew (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {quest:1698} in Redridge."] = "20레벨에 {zone:1455}의 전사 상급자 {npc:5113}이(가) 붉은마루 산맥의 {quest:1698}에게 보냅니다.",

	-- Step 3: Yorus Barleybrew (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {quest:1698} Yorus Barleybrew
	["At 20, {npc:7315}, the warrior trainer of {zone:1457}, sends you to {quest:1698} in Redridge."] = "20레벨에 {zone:1457}의 전사 상급자 {npc:7315}이(가) 붉은마루 산맥의 {quest:1698}에게 보냅니다.",

	-- Step 4: Yorus Barleybrew
	-- {quest:1698} Yorus Barleybrew · {area:69} Lakeshire · {area:98} Rethban Caverns
	["{quest:1698} sits in the inn at {area:69}. His test is timed: before you take it, clear the Redridge gnolls on the path to the {area:98} in the hills north-west of {area:69}, including the two on the rock by the cave mouth (climb it from its right side)."] = "",

	-- Step 5: The Rethban Gauntlet
	-- {npc:6166} Yorus Barleybrew · {spell:8553} Barleybrew Scalder · {area:98} Rethban Caverns · {area:69} Lakeshire
	["You have one hour, and {npc:6166}'s {spell:8553} leaves you drunk for 8-10 minutes. Run north-west into the {area:98}, keeping close to the cliff wall to miss most gnoll packs, and go in as far as the first fork; then come back to {npc:6166} (from the ridge you can jump down into {area:69}). Dying and releasing your spirit fails the quest: abandon it and {npc:6166} gives it again."] = "",
	-- {area:98} Rethban Caverns
	["The {area:98}"] = "{area:98}",
	-- {area:98} Rethban Caverns
	["Enter the {area:98} and come back; below ground, at the first fork"] = "{area:98}에 들어갔다가 돌아오기. 지하의 첫 번째 갈림길",

	-- Step 6: The Shieldsmith
	-- {npc:5413} Furen Longbeard · {item:6843} Cask of Scalder · {npc:6166} Yorus Barleybrew · {item:6970} Furen's Favor · {quest:1701} Fire Hardened Mail · {item:6842} Furen's Instructions
	["{npc:5413} works in the Dwarven District of Stormwind. He takes the {item:6843} (lost it? abandon the quest and {npc:6166} gives a new one) and gives you {item:6970}, a shield; {quest:1701} is a level 28 quest, with {item:6842} listing what it needs."] = "{npc:5413}은(는) 스톰윈드 드워프 지구에서 일합니다. 그가 {item:6843}을(를) 받고(잃어버렸다면 퀘스트를 포기하면 {npc:6166}이(가) 새것을 줍니다) 방패인 {item:6970}을(를) 줍니다. {quest:1701}은(는) 28레벨 퀘스트이며, {item:6842}에 필요한 것이 적혀 있습니다.",

	-- Step 7: Scorched Spider Fangs
	-- plural, as words: Scorched Spider Fangs = {item:6838} Scorched Spider Fang
	["Scorched Spider Fangs"] = "그을린 거미 송곳니",
	-- {zone:1437} Wetlands · {area:836} Dun Algaz
	-- plural, as words: Leech Stalkers = {npc:1111} Leech Stalker · Cave Stalkers = {npc:4040} Cave Stalker
	["You need 50 fangs. The Leech Stalkers and Cave Stalkers (level 21-22) crawl in the middle of the {zone:1437}, north of {area:836}; every one drops a fang. They poison; back in 5 minutes."] = "",

	-- Step 8: Charred and Galvanized Horns
	-- plural, as words: Galvanized Horns = {item:6840} Galvanized Horn
	["Charred and Galvanized Horns"] = "까맣게 탄 뿔과 번개 뿔",
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch · {spell:3396} Corrosive Poison · {spell:403} Lightning Bolt · {area:467} Stonetalon Peak
	-- plural, as words: Charred Horns = {item:6839} Charred Horn · Young Chimaeras = {npc:4032} Young Chimaera
	["The chimaeras live south-west of {area:460} in the {area:465}; the guide waits for level 26 first. You need 12 Charred Horns from the Fledgling (level 25-27) and Young Chimaeras (23-25), four kills in five, and the {item:6840} from the {npc:6167} (28, the big one), also four in five. Only three Fledglings, two Young and one Matriarch live there, each back in 5 minutes, so expect to wait. Fledglings and the Matriarch spit {spell:3396}, the Young cast {spell:403}. Alliance: fly to {area:467} and head south."] = "키메라는 {area:460} 남서쪽의 {area:465}에 삽니다. 가이드는 먼저 26레벨까지 기다립니다. 어린 키메라(25-27레벨)와 새끼 키메라(23-25)에게서 까맣게 탄 뿔 12개가 필요하며 다섯 마리 중 네 마리꼴로 떨어지고, {npc:6167}(28, 큰 녀석)에게서 {item:6840}도 필요한데 역시 다섯 번에 네 번 떨어집니다. 그곳에는 어린 키메라 세 마리, 새끼 두 마리, 우두머리 한 마리만 살며 각각 5분 뒤에 다시 나타나므로 기다릴 각오를 하세요. 어린 키메라와 우두머리는 {spell:3396}을(를) 뱉고, 새끼는 {spell:403}을(를) 시전합니다. 얼라이언스: {area:467}(으)로 날아가서 남쪽으로 가세요.",
	-- {item:6839} Charred Horn
	["{item:6839}, from the young chimaeras"] = "{item:6839}, 새끼 키메라에게서",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840}, from the {npc:6167}"] = "{item:6840}, {npc:6167}에게서",

	-- Step 9: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "{area:1717}의 루구그",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {spell:403} Lightning Bolt
	["Roogug is an elite quilboar (level 28) inside {area:1717}, the dungeon at the south end of the {zone:1413}; a five-player dungeon: needs a group of five, and his guards come with him. Inside take the left path at the first fork, cross the root bridge, go past the big empty cauldron: he is in a dead end on the right, with about ten elites on the way. He casts {spell:403} and calls Earth Rumblers. The vial always drops."] = "",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, 루구그에게서",

	-- Step 10: Furen's Armor
	-- {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Back to {npc:5413} in the {object:28027} for the hauberk. He then sends you to the smith of your race; the other two smiths' pieces are open to you as well: talk to them directly."] = "사슬 갑옷을 위해 {object:28027}의 {npc:5413}에게 돌아가십시오. 그다음 그가 당신 종족의 대장장이에게 보냅니다. 다른 두 대장장이의 부위도 받을 수 있으니 직접 말을 거십시오.",

	-- Step 11: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {object:28027} Dwarven District · {npc:5413} Furen Longbeard · {quest:1705} Burning Blood · {item:6845} Burning Rock
	["{npc:1416} keeps the weapon shop in the north-west of the {object:28027}, a short walk from {npc:5413}. He wants 20 {quest:1705} and the {item:6845}."] = "",

	-- Step 12: Burning Blood
	-- {zone:1431} Duskwood · {area:42} Darkshire · {quest:1705} Burning Blood · {spell:3427} Infected Wound
	["The Nightbane worgen of {zone:1431} (Dark Runners, Vile Fangs, Shadow Weavers, Worgen and Tainted Ones, level 26-31) south and west of {area:42} drop the {quest:1705} four kills in five. The Tainted Ones poison and howl; Vile Fangs cause {spell:3427}."] = "{area:42} 남쪽과 서쪽에 있는 {zone:1431}의 파멸의어둠일족 늑대인간(암흑길잡이, 송곳니투사, 흑마술사, 늑대인간, 타락전사, 26-31레벨)은 다섯 마리 중 네 마리꼴로 {quest:1705}을(를) 떨어뜨립니다. 타락전사는 독을 쓰고 울부짖으며, 송곳니투사는 {spell:3427}을(를) 겁니다.",
	-- {quest:1705} Burning Blood
	["{quest:1705}, from the Nightbane worgen"] = "{quest:1705}, 파멸의어둠일족 늑대인간에게서",

	-- Step 13: Gutspill
	-- {npc:6170} Gutspill · {item:6845} Burning Rock · {area:2161} Roland's Doom · {area:42} Darkshire
	["{npc:6170} (level 32, not elite) carries the {item:6845}, four kills in five; the guide waits for level 30 first. He walks between the inside and the mouth of the {area:2161} mine south-east of {area:42}, so wait at the entrance and pull him outside. He poisons and howls."] = "{npc:6170}(32레벨, 정예 아님)은(는) {item:6845}을(를) 지니고 있으며 다섯 번에 네 번꼴로 떨어뜨립니다. 가이드는 먼저 30레벨까지 기다립니다. 그는 {area:42} 남동쪽 {area:2161} 광산의 안쪽과 입구 사이를 오가므로, 입구에서 기다렸다가 밖으로 끌어내세요. 독을 쓰고 울부짖습니다.",
	-- {item:6845} Burning Rock · {npc:6170} Gutspill
	["{item:6845}, from {npc:6170}"] = "{item:6845}, {npc:6170}에게서",

	-- Step 15: Mathiel
	-- {quest:1703} Mathiel · {area:1660} Warrior's Terrace · {zone:1457} Darnassus · {quest:1710} Sunscorched Shells
	["{quest:1703} works on the south side of the {area:1660} in {zone:1457}. He wants 20 {quest:1710}."] = "",

	-- Step 16: Sunscorched Shells
	-- {area:482} Highperch · {zone:1441} Thousand Needles
	-- plural, as words: Highperch Wyverns = {npc:4107} Highperch Wyvern
	["The shells lie on the ground under the wyvern nests at {area:482} in western {zone:1441}, deeper into the gorge. Only nine exist and each returns 3 minutes after you pick it, so you will wait; some shell-like things there cannot be looted. Highperch Wyverns (level 28-31) guard them and sometimes come several at once."] = "",

	-- Step 18: Klockmort Spannerspan
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1455} Ironforge · {quest:1704} Klockmort Spannerspan · {object:171524} Tinker Town · {item:6848} Searing Coral
	["Ride the {area:2257} from {zone:1453} to {zone:1455}. {quest:1704}, a gnome smith, works in {object:171524} near the engineering trainers. He wants 20 {item:6848}."] = "",

	-- Step 19: Iron Coral
	-- {quest:1708} Iron Coral · {area:150} Menethil Harbor · {item:5996} Draught of Water Breathing
	["The {quest:1708} grows on the sea floor just south of {area:150}, by the murloc huts and a wrecked boat: eight there and two south-east of the harbor, each back in 3 minutes, so you will wait for respawns to reach 20. The murlocs can net you underwater: watch your breath, and a {item:5996} removes the risk."] = "",
	-- {item:6848} Searing Coral · {quest:1708} Iron Coral
	["{item:6848}, from {quest:1708}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A hauberk at 28, a coif, leggings or gauntlets by race, and a shield on the way."] = "28레벨에 사슬 갑옷, 종족에 따라 사슬 두건, 다리보호구 또는 건틀릿, 그리고 도중에 방패.",
	-- ["Ride the {area:2257} from {zone:1453} to {zone:1455}."] = "{zone:1453}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가십시오.",
	-- ["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "루구그는 {zone:1413} 남쪽 끝 던전인 {area:1717} 안의 정예 가시멧돼지입니다. {item:6841}을(를) 떨어뜨립니다. {area:1717}은(는) 던전입니다. 파티를 권장합니다.",
	-- ["The Fledgling and Young Chimaeras roam the south-west of Stonetalon, with the {npc:6167} among them: the young ones drop the {item:6839}, the Matriarch the {item:6840}."] = "어린 키메라와 새끼 키메라가 {npc:6167}과(와) 함께 돌발톱 산맥 남서쪽을 돌아다닙니다. 새끼들은 {item:6839}을(를), 우두머리는 {item:6840}을(를) 떨어뜨립니다.",
	-- ["The Leech Stalkers and Cave Stalkers crawl around 46,61 in the middle of the {zone:1437}; they drop the {item:6838}."] = "긴다리흡혈거미와 긴다리동굴거미가 {zone:1437} 중앙 46,61 주변을 기어 다닙니다. 이들이 {item:6838}을(를) 떨어뜨립니다.",
	-- ["The Nightbane worgen of {zone:1431} drop the {quest:1705}. {npc:6170} walks in the far south-east of {zone:1431} and carries the {item:6845}."] = "{zone:1431}의 파멸의어둠일족 늑대인간이 {quest:1705}을(를) 떨어뜨립니다. {npc:6170}은(는) {zone:1431} 남동쪽 끝을 돌아다니며 {item:6845}을(를) 가지고 있습니다.",
	-- ["The {quest:1708} grows along the {zone:1437}' west coast, south of {area:150}."] = "{quest:1708}은(는) {area:150} 남쪽, {zone:1437} 서쪽 해안을 따라 자랍니다.",
	-- ["The {quest:1710} lie along the western edge of {zone:1441}."] = "{quest:1710}은(는) {zone:1441} 서쪽 가장자리를 따라 있습니다.",
	-- ["{npc:1416} is in {zone:1453}, a short walk from {npc:5413}."] = "{npc:1416}은(는) {zone:1453}에 있으며, {npc:5413}에게서 조금만 걸어가면 됩니다.",
	-- ["{quest:1698} is in {area:69}, at the inn. His test is timed: run north-west into the {area:98}, reach the first fork and come back to him before the timer runs out. Do not die and release your spirit."] = "{quest:1698}은(는) {area:69} 여관에 있습니다. 그의 시험에는 시간 제한이 있습니다. 북서쪽 {area:98}(으)로 달려가 첫 갈림길에 닿은 뒤 시간이 다 되기 전에 그에게 돌아오십시오. 죽어서 영혼을 해방하면 안 됩니다.",
	-- ["{quest:1703} is a smith in {zone:1457}."] = "{quest:1703}은(는) {zone:1457}의 대장장이입니다.",
}
