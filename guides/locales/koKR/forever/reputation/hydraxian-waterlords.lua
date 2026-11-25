-- Korean (koKR): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "히드락시안 물의 군주 평판",
	-- {item:22754} Eternal Quintessence · {area:2717} Molten Core
	["The reputation kills to Honored, and the reusable {item:22754} at Revered once the {area:2717} opens."] = "우호까지의 평판 처치, 그리고 {area:2717}이(가) 열리면 존경에서 받는 재사용 가능한 {item:22754}.",

	-- Step 1: Elementals to Honored
	["Elementals to Honored"] = "",
	-- {npc:13278} Duke Hydraxis · {area:2717} Molten Core · {npc:11744} Dust Stormer · {npc:11746} Desert Rumbler · {area:2740} Crystal Vale · {zone:1451} Silithus · {npc:7032} Greater Obsidian Elemental · {zone:1428} Burning Steppes · {npc:14478} Huricanian · {npc:9017} Lord Incendius · {object:174825} Black Anvil (no name in this language: may be words) · {area:1584} Blackrock Depths
	["Everyone starts Neutral with the Waterlords, and their reputation comes from killing the servants of fire, air and earth. {npc:13278}'s quests aren't offered on Forever yet: they come back when the {area:2717} opens. The numbers in this guide leave out the Legacy perk Diplomat, which adds up to 10%.\nNeutral to Honored is 9,000 reputation. It comes from the elementals: 5 per {npc:11744} or {npc:11746}, which drift around the {area:2740} in the north-west of {zone:1451}, or {npc:7032} (the {zone:1428}), about 1,800 kills from Neutral. They stop at 5,999 of 6,000 Friendly, one point short, so the last point needs a kill that still counts there: {npc:14478}, a rare air elemental in the {area:2740} (25), or {npc:9017} at the {object:174825} in {area:1584} (15, a five-player dungeon). Those two keep paying through Honored as well."] = "누구나 물의 군주들과 중립으로 시작하며, 평판은 불, 바람, 대지의 하수인을 처치해 얻습니다. {npc:13278}의 퀘스트는 아직 Forever에서 제공되지 않습니다: {area:2717}이(가) 열리면 돌아옵니다. 이 가이드의 수치는 유산 혜택 외교관(최대 10% 추가)을 빼고 계산했습니다.\n중립에서 우호까지 평판 9,000입니다. 원소에게서 얻습니다: {zone:1451} 북서쪽 {area:2740} 주변을 떠도는 {npc:11744} 또는 {npc:11746} 하나당 5, 또는 {npc:7032}({zone:1428}), 중립부터 약 1,800마리. 친근 5,999/6,000에서 멈춰 한 점이 모자라므로, 마지막 한 점은 그 단계에서도 집계되는 처치가 필요합니다: {area:2740}의 희귀 바람 원소 {npc:14478}(25), 또는 {area:1584}의 {object:174825}에 있는 {npc:9017}(15, 5인 던전). 이 둘은 우호 단계에서도 계속 평판을 줍니다.",
	-- {npc:14478} Huricanian
	["{npc:14478}, rare, 25"] = "",
	-- {npc:9017} Lord Incendius · {area:1584} Blackrock Depths
	["{npc:9017}, {area:1584}: 15, group up"] = "",

	-- Step 2: Pyroguard Emberseer
	-- {npc:9816} Pyroguard Emberseer · {area:254} Blackrock Mountain · {item:12344} Seal of Ascension
	["{npc:9816} is a boss in Upper Blackrock Spire, inside {area:254}: a group of up to ten, and someone needs the {item:12344} to open the door. He pays 50 reputation per kill up to 11,999 of 12,000 Honored."] = "{npc:9816}은(는) {area:254} 안 검은바위 첨탑 상층의 우두머리입니다: 최대 열 명의 파티이며, 문을 열려면 누군가 {item:12344}이(가) 있어야 합니다. 처치마다 평판 50을 우호 11,999/12,000까지 줍니다.",
	-- {npc:9816} Pyroguard Emberseer
	["{npc:9816}: raid of ten"] = "{npc:9816}: 10인 공격대",

	-- Step 3: Molten Core to Revered
	-- {area:2717} Molten Core
	["{area:2717} to Revered"] = "",
	-- {npc:227939} The Molten Core · {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros · {npc:9017} Lord Incendius · {npc:9816} Pyroguard Emberseer
	-- plural, as words: Firewalkers = {npc:11666} Firewalker · Flameguards = {npc:11667} Flameguard · Lava Elementals = {npc:12076} Lava Elemental · Lava Reavers = {npc:12100} Lava Reaver · Molten Destroyers = {npc:11659} Molten Destroyer · Lava Surgers = {npc:12101} Lava Surger · Molten Giants = {npc:11658} Molten Giant · Ancient Core Hounds = {npc:11673} Ancient Core Hound
	["{npc:227939} is a raid of 40 and not open on Forever yet. Once it is: every elemental there pays, Firewalkers, Flameguards, Lava Elementals, Lava Reavers and Molten Destroyers 40, Firelords, Lava Surgers, Molten Giants and Ancient Core Hounds 20, up to 11,999 of 12,000 Honored; about 3,360 for a full clear of the trash.\nHonored to Revered is 12,000 reputation. The trash still counts, so a full clear pays about 3,360 plus 700 from the seven bosses, 150 from {npc:11988} and 200 from {npc:11502}: about three clears. {npc:9017} (15) and {npc:9816} (50) count too while you are Honored. The trash stops at 11,999 of 12,000 Honored; the bosses carry you over."] = "{npc:227939}은(는) 40인 공격대이며 아직 Forever에서 열리지 않았습니다. 열리면: 그곳의 모든 원소가 평판을 주며, 화염발걸음({npc:11666}), 화염 수호병({npc:11667}), 용암 정령({npc:12076}), 용암 약탈자({npc:12100}), 녹아내린 파괴자({npc:11659})는 40, 화염의 군주, 용암 돌진자({npc:12101}), 녹아내린 거인({npc:11658}), 고대 심장부 사냥개({npc:11673})는 20, 우호 11,999/12,000까지 줍니다. 일반 몹을 모두 처치하면 약 3,360입니다.\n우호에서 존경까지 평판 12,000입니다. 일반 몹도 계속 집계되므로 전체 처치 한 번에 약 3,360, 우두머리 일곱에서 700, {npc:11988}에게서 150, {npc:11502}에게서 200: 약 세 번. {npc:9017}(15)와(과) {npc:9816}(50)도 우호 동안 집계됩니다. 일반 몹은 우호 11,999/12,000에서 멈추고, 우두머리가 넘겨 줍니다.",
	-- {npc:12118} Lucifron
	["{npc:12118} and the other bosses, 100: they carry you past 11,999"] = "",

	-- Step 4: The Eternal Quintessence
	-- {item:22754} Eternal Quintessence
	["The {item:22754}"] = "{item:22754}",
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara · {item:22754} Eternal Quintessence · {area:2717} Molten Core · {npc:12018} Majordomo Executus · {npc:11502} Ragnaros
	["{npc:13278} stands on a small island off the east coast of {zone:1447}; swim out to him. At Revered he gives you the {item:22754}: pour it on a rune in the {area:2717} to douse it. It is not used up, so you never come back for another. With every rune doused, {npc:12018} comes out, and after him {npc:11502}."] = "{npc:13278}은(는) {zone:1447} 동쪽 해안 앞 작은 섬에 서 있습니다. 헤엄쳐 가십시오. 존경이 되면 {item:22754}을(를) 줍니다: {area:2717}의 룬에 부어 불을 끄십시오. 소모되지 않으므로 다시 받으러 올 필요가 없습니다. 모든 룬을 끄면 {npc:12018}이(가) 나오고, 그 뒤에 {npc:11502}이(가) 나옵니다.",
	-- {item:22754} Eternal Quintessence
	["{item:22754}, ask the Duke"] = "",

	-- Step 5: Molten Core to Exalted
	-- {area:2717} Molten Core
	["{area:2717} to Exalted"] = "",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	["Revered to Exalted is 21,000 reputation. The trash has stopped, but all nine bosses still pay while you are Revered: 100 each from the seven, 150 from {npc:11988} and 200 from {npc:11502}, 1,050 a clear: about 20 clears. The seven stop at 20,999 of 21,000 Revered, so the last point comes from {npc:11988} or {npc:11502}, and from Exalted on only those two pay."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:13278}"] = "{npc:13278}에게 돌아가기",
	-- ["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "두 정령 모두 {zone:1451} 북서부를 돌아다닙니다. 우레의 모래정령은 조금 더 북쪽에 모여 있습니다.",
	-- ["Dust Stormers and Desert Rumblers"] = "{npc:11744}와(과) {npc:11746}",
	-- ["Keep clearing the {area:2717} until Exalted."] = "확고한 동맹이 될 때까지 {area:2717}을(를) 계속 공략하세요.",
	-- ["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "{area:2717}에서 {npc:11668}, {npc:11658}, {npc:11673}, {npc:12101}을(를) 하나씩 처치하세요. {area:2717}의 모든 정령과 우두머리도 물의 군주 평판에 반영됩니다.",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12)."] = "{zone:1423}의 오염된 물의 정령에게 {item:17310}을(를) 사용한 뒤 {item:17309}(12)을(를) 획득하세요.",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "{zone:1423}의 오염된 물의 정령에게 {item:17310}을(를) 사용한 뒤 {item:17309}(12)을(를) 획득하세요. 그 정령들의 생성 위치는 데이터에 없습니다.",
	-- ["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "나머지는 {area:2717} 공략으로 채웁니다. 우두머리는 항상 반영되지만, 클래식에서는 일반 몹 처치가 중간부터 물의 군주 평판을 주지 않으므로 후반에는 우두머리가 평판을 책임집니다.",
	-- ["{faction:749} to Exalted"] = "{faction:749}: 확고한 동맹까지",
	-- ["{faction:749} to Revered"] = "{faction:749}: 매우 우호적까지",
	-- ["{npc:12118}, {npc:12259}, {npc:12264} and {npc:12098} are {area:2717} bosses: each drops his hand for the quest."] = "{npc:12118}, {npc:12259}, {npc:12264}, {npc:12098}은(는) {area:2717}의 우두머리이며, 각각 퀘스트에 필요한 자신의 손을 떨어뜨립니다.",
	-- ["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278}은(는) {zone:1447} 동쪽 해안 앞 작은 섬에 서 있습니다. 헤엄치거나 얕은 물을 걸어 가세요. {faction:749}은(는) 중립에서 시작합니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- ["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "검은바위 첨탑 상층의 {npc:9816}이(가) {quest:6821}을(를) 떨어뜨립니다. 공격대가 필요합니다.",
	-- ["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823}에는 우호적이 필요합니다. 우호적이 되면 {npc:13278}이(가) {area:2717}에서 {npc:12018}을(를) 소환하는 룬을 끄는 데 쓰는 {item:17333}을(를) 주고, 매우 우호적이 되면 재사용 가능한 {item:22754}을(를) 줍니다.",
}
