-- Korean (koKR): the guide forever/class/warrior/whirlwind-weapon (forever/class/warrior/whirlwind-weapon.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2458} Berserker Stance · {spell:1680} Whirlwind
	["{spell:2458} at 30 and a {spell:1680} axe, sword or warhammer at 40."] = "30레벨에 {spell:2458}, 40레벨에 {spell:1680} 도끼, 검 또는 전투망치.",

	-- Step 1: The Islander (Stormwind)
	-- {npc:5479} Wu Shen · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:5479}, beside {npc:5480} in the warrior trainers' building of {object:2100}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30레벨에 {object:2100} 전사 상급자 건물의 {npc:5480} 옆에 있는 {npc:5479}이(가) {zone:1413} {area:720}의 {npc:6236}에게 보냅니다.",

	-- Step 2: The Islander (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30레벨에 {zone:1455}의 전사 상급자 {npc:5113}이(가) {zone:1413} {area:720}의 {npc:6236}에게 보냅니다.",

	-- Step 3: The Islander (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:3354} in the {object:172958} sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30레벨에 {object:172958}의 {npc:3354}이(가) {zone:1413} {area:720}의 {npc:6236}에게 보냅니다.",

	-- Step 4: The Islander (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30레벨에 {zone:1456}의 전사 상급자 {npc:3041}이(가) {zone:1413} {area:720}의 {npc:6236}에게 보냅니다.",

	-- Step 5: The Islander (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30레벨에 {zone:1458}의 전사 상급자 {npc:4595}이(가) {zone:1413} {area:720}의 {npc:6236}에게 보냅니다.",

	-- Step 6: Fray Island
	-- {area:392} Ratchet · {area:391} Merchant Coast · {area:720} Fray Island · {npc:6236} Klannoc Macleod
	["Fly to {area:392} and go south along the {area:391}. {area:720} lies offshore to the south-east: wade across on the shallow sand bar; off it the water is deep and fatigue sets in. {npc:6236} stands by the arena."] = "",

	-- Step 7: The Affray
	-- {npc:6248} Twiggy Flathead · {npc:6238} Big Will · {spell:1160} Demoralizing Shout
	["You have 10 minutes. Eat and drink to full, then step onto the grate in the middle of the crowd: {npc:6248} announces the challengers (level 26-27), who come one at a time, 15-20 seconds apart, and only while you stand near the grate. After each kill, step off the grate to eat or bandage; step back on when ready for the next. Six of them, then {npc:6238} (level 33, not elite) walks out; he stays neutral until you attack him, so bandage or eat first. Do not use {spell:1160}: it sends the challengers running and more of them pile in at once. If nothing starts, step off and on the grate again, or abandon the quest and take it again."] = "",

	-- Step 8: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {area:272} Tarren Mill · {zone:1416} Alterac Mountains · {area:271} Southshore · {quest:1712} Cyclonian · {item:6929} Bath'rah's Parchment · {item:3357} Liferoot · {item:6851} Essence of the Exile
	-- plural, as words: Bloodscalp Tusks = {item:3901} Bloodscalp Tusk
	["{npc:6176} camps by ruins on the east bank of the river that runs past {area:272}, a short walk north-east of the town, just over the border in {zone:1416}; his cauldron stands beside him. Horde: fly to {area:272}. Alliance: fly to {area:271} and go north along the river; {area:272}'s guards are level 42 elites, so keep away from the town. Accepting {quest:1712} gives you {item:6929}, the list of what he needs: 8 {item:3357}, 30 Bloodscalp Tusks and the {item:6851} from his cauldron. The cauldron's {item:6851} is not a quest you take: it never shows in your quest log. Come back with its charms and hand them in at the cauldron."] = "{npc:6176}은(는) {area:272} 옆을 흐르는 강의 동쪽 기슭 폐허 옆에 야영하고 있습니다. 마을에서 북동쪽으로 조금 걸어가 {zone:1416} 경계를 막 넘은 곳이며, 그의 가마솥이 옆에 있습니다. 호드: {area:272}(으)로 날아가세요. 얼라이언스: {area:271}(으)로 날아가서 강을 따라 북쪽으로 가세요. {area:272}의 경비병은 42레벨 정예이니 마을에서 멀리 떨어지세요. {quest:1712}을(를) 수락하면 그에게 필요한 것을 적은 {item:6929}을(를) 받습니다: {item:3357} 8개, 붉은머리부족의 어금니 30개, 그리고 그의 가마솥에서 얻는 {item:6851}. 가마솥의 {item:6851}은(는) 받는 퀘스트가 아니라 퀘스트 목록에 절대 나타나지 않습니다. 부적을 모아 돌아와서 가마솥에 제출하세요.",

	-- Step 9: Liferoot
	-- {item:3357} Liferoot · {zone:1437} Wetlands · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale · {npc:1302} Bernard Gump · {npc:1313} Maria Lumere · {zone:1453} Stormwind · {npc:844} Antonio Perelli · {area:460} Sun Rock Retreat · {zone:1441} Thousand Needles
	["You need 8 {item:3357}. Herbalists pick it by rivers and lakes in the {zone:1437}, {zone:1417} and {zone:1434}; otherwise the auction house. Herb vendors keep only one at a time and restock every two hours: {npc:1302} and {npc:1313} in {zone:1453}, {npc:844} on the road in eastern Elwynn, Jeeda at {area:460} in Stonetalon, Montarr in {zone:1441}. Kurzen Medicine Men in northern Stranglethorn drop one about one kill in twelve."] = "",

	-- Step 10: Bloodscalp Tusks
	-- plural, as words: Bloodscalp Tusks = {item:3901} Bloodscalp Tusk
	["Bloodscalp Tusks"] = "",
	-- {area:117} Grom'gol Base Camp · {area:123} Bal'lal Ruins
	["You need 30 tusks. Every Bloodscalp troll (level 33-37) of north-west Stranglethorn drops one about one kill in three, so plan on some 80 kills: the camps and ruins north and north-west of {area:117} and around the {area:123} on the coast. They enrage below 30% health and the Warriors disarm; back in 5 minutes."] = "",

	-- Step 11: The exiles of Arathi
	["The exiles of Arathi"] = "아라시 고원의 떠도는 정령",
	-- {area:334} Circle of West Binding · {area:320} Refuge Pointe · {area:336} Circle of Outer Binding · {spell:403} Lightning Bolt · {area:333} Circle of East Binding · {area:321} Hammerfall · {spell:122} Frost Nova
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["The cauldron wants 8 of each charm, 24 in all, and each exile drops its charm about one kill in three, so plan on some 70 kills. All are level 38-39, not elite: the guide waits for level 37 first, and a friend helps. Burning Exiles (fire) by the {area:334} in the north-west, north-west of {area:320}; Thundering Exiles (air) by the {area:336} south-east of {area:320}, casting {spell:403} from 40 yards; Cresting Exiles (water) by the {area:333}, north-west of {area:321}, with {spell:122}. About a dozen of each, back in under 7 minutes. The charms trade and sell on the auction house; using one banishes another kind of exile for a while (Burning on Thundering, Thundering on Cresting, Cresting on Burning)."] = "가마솥에는 부적이 종류별로 8개씩, 모두 24개 필요하며, 정령마다 대략 세 번에 한 번 자기 부적을 떨어뜨리므로 70마리쯤 잡을 생각을 하세요. 모두 38-39레벨이며 정예가 아닙니다. 가이드는 먼저 37레벨까지 기다리며, 친구가 있으면 도움이 됩니다. 떠도는 불의 정령(불)은 북서쪽 {area:334} 옆, {area:320} 북서쪽에 있고, 떠도는 천둥 정령(바람)은 {area:320} 남동쪽 {area:336} 옆에서 40미터 밖에서 {spell:403}을(를) 시전하며, 떠도는 물의 정령(물)은 {area:321} 북서쪽 {area:333} 옆에서 {spell:122}을(를) 씁니다. 종류별로 열두 마리쯤 있고, 7분 안에 다시 나타납니다. 부적은 거래하거나 경매장에서 팔 수 있으며, 하나를 쓰면 다른 종류의 정령을 잠시 추방합니다(불은 천둥에, 천둥은 물에, 물은 불에).",
	-- {item:4479} Burning Charm
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:4479}, from Burning Exiles"] = "{item:4479}, 떠도는 불의 정령에게서",
	-- {item:4480} Thundering Charm
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:4480}, from Thundering Exiles"] = "{item:4480}, 떠도는 천둥 정령에게서",
	-- {item:4481} Cresting Charm
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{item:4481}, from Cresting Exiles"] = "{item:4481}, 떠도는 물의 정령에게서",

	-- Step 12: Essence of the Exile
	-- {object:89931} Bath'rah's Cauldron · {quest:1712} Cyclonian · {quest:1714} Essence of the Exile
	["Click {object:89931} with the 24 charms in your bags and {quest:1712} in your log. Its window asks for the charms straight away, with nothing to accept: Continue, then Complete, and it hands you the {quest:1714}."] = "가방에 부적 24개가 있고 퀘스트 목록에 {quest:1712}이(가) 있을 때 {object:89931}을(를) 클릭하세요. 창이 수락할 것 없이 바로 부적을 요구합니다. '계속'을 누른 다음 '퀘스트 완료'를 누르면 {quest:1714}을(를) 줍니다.",
	-- {quest:1714} Essence of the Exile · {npc:6176} Bath'rah the Windwatcher
	["{quest:1714}, from the cauldron by {npc:6176}"] = "",

	-- Step 13: The Summoning
	-- {npc:6176} Bath'rah the Windwatcher · {quest:1713} The Summoning · {quest:1712} Cyclonian · {item:6052} Nature Protection Potion · {spell:10101} Knock Away · {item:6894} Whirlwind Heart
	["Back to {npc:6176}. Accepting {quest:1713} starts his ritual, and {quest:1712} appears just north of his camp. {quest:1712} is elite (level 40): grouping up is encouraged; it needs a group of two or three around level 40. It deals nature damage (a {item:6052} soaks it), whirls, and {spell:10101} throws you far while it heals itself as you run back: fight with your back to a slope or rock. The {item:6894} always drops. If the fight fails {npc:6176} stops answering: abandon {quest:1713} and take it again for a new summon; the earlier items are not needed again."] = "",
	-- {item:6894} Whirlwind Heart · {quest:1712} Cyclonian
	["{item:6894}, from {quest:1712}"] = "{item:6894}, {quest:1712}에게서",
	-- {npc:6176} Bath'rah the Windwatcher · {item:6975} Whirlwind Axe
	["{npc:6176}: {item:6975}, Sword or Warhammer"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Defeat the challengers and {npc:6238}"] = "도전자들과 {npc:6238} 물리치기",
	-- ["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "{area:392}에서 해안을 따라 남쪽으로 {area:720}까지 가십시오. {npc:6236}은(는) 투기장 옆에 있습니다. 쇠창살을 밟으면 싸움이 시작됩니다. 도전자가 한 명씩 나온 뒤 {npc:6238}(33)이(가) 나옵니다.",
	-- ["The Bloodscalp trolls hold the north-west of {zone:1434}; they drop the {item:3901}."] = "붉은머리부족 트롤이 {zone:1434} 북서쪽을 차지하고 있으며, {item:3901}을(를) 떨어뜨립니다.",
	-- ["Three kinds of elemental exiles roam {zone:1417}: Burning Exiles in the north-west, Thundering Exiles in the middle, Cresting Exiles in the north-east. Each drops its charm."] = "세 종류의 떠도는 정령이 {zone:1417}을(를) 돌아다닙니다. 북서쪽에는 떠도는 불의 정령, 중앙에는 떠도는 천둥 정령, 북동쪽에는 떠도는 물의 정령이 있습니다. 각각 자신의 부적을 떨어뜨립니다.",
	-- ["{item:3357}: {skill:182}, or the auction house"] = "{item:3357}: {skill:182} 또는 경매장",
	-- ["{npc:6176} camps in the south-east of {zone:1416}, above {zone:1424}; his cauldron stands beside him. He asks for a {item:3357}, a {item:3901} and the {quest:1714}, which his cauldron brews from three charms."] = "{npc:6176}은(는) {zone:1424} 위쪽, {zone:1416} 남동쪽에서 야영하며 가마솥이 옆에 있습니다. {item:3357}, {item:3901}, 그리고 가마솥에서 부적 세 개로 끓이는 {quest:1714}을(를) 요구합니다.",
	-- ["{quest:1712} waits just north of {npc:6176}'s camp and carries the {item:6894}. {quest:1712} is elite: grouping up is advised."] = "{quest:1712}은(는) {npc:6176}의 야영지 바로 북쪽에서 기다리며 {item:6894}을(를) 가지고 있습니다. {quest:1712}은(는) 정예입니다. 파티를 권장합니다.",
}
