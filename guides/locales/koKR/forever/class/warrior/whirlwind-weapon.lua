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
	["At 30, {npc:5479}, beside {npc:5480} in the warrior trainers' building of {object:2100}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "",

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
	-- {npc:6176} Bath'rah the Windwatcher · {area:272} Tarren Mill · {zone:1416} Alterac Mountains · {area:271} Southshore · {quest:1712} Cyclonian · {item:6929} Bath'rah's Parchment · {item:3357} Liferoot · {quest:1714} Essence of the Exile
	-- plural, as words: Bloodscalp Tusks = {item:3901} Bloodscalp Tusk
	["{npc:6176} camps by ruins on the east bank of the river that runs past {area:272}, a short walk north-east of the town, just over the border in {zone:1416}; his cauldron stands beside him. Horde: fly to {area:272}. Alliance: fly to {area:271} and go north along the river; {area:272}'s guards are level 42 elites, so keep away from the town. Accepting {quest:1712} gives you {item:6929}, the list of what he needs: 8 {item:3357}, 30 Bloodscalp Tusks and the {quest:1714} from his cauldron. Click the cauldron for that quest."] = "",

	-- Step 9: The exiles of Arathi
	["The exiles of Arathi"] = "아라시 고원의 떠도는 정령",
	-- {area:334} Circle of West Binding · {area:320} Refuge Pointe · {area:336} Circle of Outer Binding · {spell:403} Lightning Bolt · {area:333} Circle of East Binding · {area:321} Hammerfall · {spell:122} Frost Nova
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["The cauldron wants 8 of each charm, 24 in all, and each exile drops its charm about one kill in three, so plan on some 70 kills. All are level 38-39, not elite, and hit hard at 30-33: bring a friend or come at 35 or more. Burning Exiles (fire) by the {area:334} in the north-west, north-west of {area:320}; Thundering Exiles (air) by the {area:336} south-east of {area:320}, casting {spell:403} from 40 yards; Cresting Exiles (water) by the {area:333}, north-west of {area:321}, with {spell:122}. About a dozen of each, back in under 7 minutes. The charms trade and sell on the auction house; using one banishes another kind of exile for a while (Burning on Thundering, Thundering on Cresting, Cresting on Burning)."] = "",
	-- {item:4479} Burning Charm
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:4479}, from Burning Exiles"] = "",
	-- {item:4480} Thundering Charm
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:4480}, from Thundering Exiles"] = "",
	-- {item:4481} Cresting Charm
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{item:4481}, from Cresting Exiles"] = "",

	-- Step 10: Essence of the Exile
	-- {object:89931} Bath'rah's Cauldron · {quest:1714} Essence of the Exile
	["Put the 24 charms into {object:89931}: it hands you the {quest:1714}."] = "",
	-- {quest:1714} Essence of the Exile · {npc:6176} Bath'rah the Windwatcher
	["{quest:1714}, from the cauldron by {npc:6176}"] = "",

	-- Step 11: Liferoot
	-- {item:3357} Liferoot · {zone:1437} Wetlands · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale · {npc:1302} Bernard Gump · {npc:1313} Maria Lumere · {zone:1453} Stormwind · {npc:844} Antonio Perelli · {area:460} Sun Rock Retreat · {zone:1441} Thousand Needles
	["You need 8 {item:3357}. Herbalists pick it by rivers and lakes in the {zone:1437}, {zone:1417} and {zone:1434}; otherwise the auction house. Herb vendors keep only one at a time and restock every two hours: {npc:1302} and {npc:1313} in {zone:1453}, {npc:844} on the road in eastern Elwynn, Jeeda at {area:460} in Stonetalon, Montarr in {zone:1441}. Kurzen Medicine Men in northern Stranglethorn drop one about one kill in twelve."] = "",

	-- Step 12: Bloodscalp Tusks
	-- plural, as words: Bloodscalp Tusks = {item:3901} Bloodscalp Tusk
	["Bloodscalp Tusks"] = "",
	-- {area:117} Grom'gol Base Camp · {area:123} Bal'lal Ruins
	["You need 30 tusks. Every Bloodscalp troll (level 33-37) of north-west Stranglethorn drops one about one kill in three, so plan on some 80 kills: the camps and ruins north and north-west of {area:117} and around the {area:123} on the coast. They enrage below 30% health and the Warriors disarm; back in 5 minutes."] = "",

	-- Step 13: The Summoning
	-- {npc:6176} Bath'rah the Windwatcher · {quest:1713} The Summoning · {quest:1712} Cyclonian · {item:6052} Nature Protection Potion · {spell:10101} Knock Away · {item:6894} Whirlwind Heart
	["Back to {npc:6176}. Accepting {quest:1713} starts his ritual, and {quest:1712} appears just north of his camp. {quest:1712} is elite (level 40): grouping up is encouraged; it needs a group of two or three around level 40. It deals nature damage (a {item:6052} soaks it), whirls, and {spell:10101} throws you far while it heals itself as you run back: fight with your back to a slope or rock. The {item:6894} always drops. If the fight fails {npc:6176} stops answering: abandon {quest:1713} and take it again for a new summon; the earlier items are not needed again."] = "",
	-- {item:6894} Whirlwind Heart · {quest:1712} Cyclonian
	["{item:6894}, from {quest:1712}"] = "",
	-- {npc:6176} Bath'rah the Windwatcher · {item:6975} Whirlwind Axe
	["{npc:6176}: {item:6975}, Sword or Warhammer"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30레벨에 돼지와 휘파람 선술집 옆 {object:2100}의 {npc:5479}이(가) {zone:1413} {area:720}의 {npc:6236}에게 보냅니다.",
	-- ["Defeat the challengers and {npc:6238}"] = "도전자들과 {npc:6238} 물리치기",
	-- ["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "{area:392}에서 해안을 따라 남쪽으로 {area:720}까지 가십시오. {npc:6236}은(는) 투기장 옆에 있습니다. 쇠창살을 밟으면 싸움이 시작됩니다. 도전자가 한 명씩 나온 뒤 {npc:6238}(33)이(가) 나옵니다.",
	-- ["The Bloodscalp trolls hold the north-west of {zone:1434}; they drop the {item:3901}."] = "붉은머리부족 트롤이 {zone:1434} 북서쪽을 차지하고 있으며, {item:3901}을(를) 떨어뜨립니다.",
	-- ["Three kinds of elemental exiles roam {zone:1417}: Burning Exiles in the north-west, Thundering Exiles in the middle, Cresting Exiles in the north-east. Each drops its charm."] = "세 종류의 떠도는 정령이 {zone:1417}을(를) 돌아다닙니다. 북서쪽에는 떠도는 불의 정령, 중앙에는 떠도는 천둥 정령, 북동쪽에는 떠도는 물의 정령이 있습니다. 각각 자신의 부적을 떨어뜨립니다.",
	-- ["{item:3357}: {skill:182}, or the auction house"] = "{item:3357}: {skill:182} 또는 경매장",
	-- ["{item:4479} from the Burning Exiles"] = "{item:4479}, 떠도는 불의 정령에게서",
	-- ["{item:4480} from the Thundering Exiles"] = "{item:4480}, 떠도는 천둥 정령에게서",
	-- ["{item:4481} from the Cresting Exiles"] = "{item:4481}, 떠도는 물의 정령에게서",
	-- ["{item:6894} from {quest:1712}"] = "{item:6894}, {quest:1712}에게서",
	-- ["{npc:6176} camps in the south-east of {zone:1416}, above {zone:1424}; his cauldron stands beside him. He asks for a {item:3357}, a {item:3901} and the {quest:1714}, which his cauldron brews from three charms."] = "{npc:6176}은(는) {zone:1424} 위쪽, {zone:1416} 남동쪽에서 야영하며 가마솥이 옆에 있습니다. {item:3357}, {item:3901}, 그리고 가마솥에서 부적 세 개로 끓이는 {quest:1714}을(를) 요구합니다.",
	-- ["{quest:1712} waits just north of {npc:6176}'s camp and carries the {item:6894}. {quest:1712} is elite: grouping up is advised."] = "{quest:1712}은(는) {npc:6176}의 야영지 바로 북쪽에서 기다리며 {item:6894}을(를) 가지고 있습니다. {quest:1712}은(는) 정예입니다. 파티를 권장합니다.",
}
