-- Korean (koKR): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "나무구렁 요새 평판",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold
	["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576} 평판은 적대적에서 시작하며, 약간 적대적이 될 때까지 동굴의 나무구렁일족 퍼볼그가 공격합니다. 마른가지일족과 눈사태일족 퍼볼그를 처치할 때마다 평판이 오르므로 아래 퀘스트는 두 배로 보상합니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:11554} Grazle · {npc:15395} Nafien
	["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "마른가지일족 퍼볼그(레벨 48-50)가 {zone:1448} 남쪽 끝에 진을 치고 있습니다. 이들이 떨어뜨리는 {item:21377}은(는) 모두 챙기세요. 나중에 {npc:11554}와(과) {npc:15395}이(가) 받습니다.",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "{npc:11554}에게 돌아가기",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood · {faction:576} Timbermaw Hold
	["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395}은(는) {zone:1448} 북쪽, {faction:576}(으)로 들어가는 동굴 입구에서 기다립니다.",

	-- Step 5: Deadwood of the North
	["The northern Deadwood (level 53-55) hold the camps just south of the tunnel. Keep their feathers too."] = "북쪽의 마른가지일족(레벨 53-55)이 동굴 바로 남쪽의 야영지를 차지하고 있습니다. 이들의 깃털도 챙기세요.",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "{npc:15395}에게 돌아가기",

	-- Step 7: Salfa
	-- {faction:576} Timbermaw Hold · {zone:1452} Winterspring · {npc:11556} Salfa
	["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "{faction:576}을(를) 지나 {zone:1452} 쪽 출구로 가세요. {npc:11556}은(는) 출구 바로 밖에 있습니다. 지금까지의 퀘스트와 처치로 보통 약간 적대적에 도달하며, 그러면 나무구렁일족이 지나가게 해 줍니다. 아직 빨간색이면 먼저 동굴 근처의 마른가지일족을 더 처치하세요.",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {item:21383} Winterfall Spirit Beads · {npc:11556} Salfa
	["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "{area:2244}은(는) {zone:1452} 동쪽에 있습니다. 획득한 {item:21383}은(는) 모두 챙기세요. {npc:11556}이(가) 받습니다.",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "{npc:11556}에게 돌아가기",

	-- Step 10: Feathers and beads to Friendly
	["Feathers and beads to Friendly"] = "깃털과 구슬로 약간 우호적까지",
	-- {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {item:21383} Winterfall Spirit Beads · {area:2244} Winterfall Village
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "{npc:11554}을(를) 위한 깃털, {npc:15395}을(를) 위한 깃털(마른가지일족 깃털 머리장식), {npc:11556}에게 구슬 가져다주기({item:21383})는 원하는 만큼 반복할 수 있습니다. 마른가지일족이나 눈사태일족 처치도 평판에 포함됩니다. 구슬은 {area:2244}에서 가장 많이 나옵니다.",
	-- {npc:11556} Salfa
	["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556}: {npc:11556}에게 정기의 구슬 가져다주기",

	-- Step 11: Feathers to Honored
	["Feathers to Honored"] = "깃털로 우호적까지",
	-- {npc:15395} Nafien · {npc:11554} Grazle
	["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "동굴 옆 북쪽 마른가지일족 야영지가 깃털이 가장 많이 나오는 곳입니다(획득 확률 35%). 깃털은 동굴 입구의 {npc:15395}(이)나 남쪽의 {npc:11554}에게 건네세요.",
	-- {npc:15395} Nafien
	["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395}: {npc:15395}을(를) 위한 깃털",

	-- Step 12: Timbermaw Hold to Revered
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Revered"] = "{faction:576}: 매우 우호적까지",
	-- {npc:15395} Nafien · {npc:11556} Salfa
	["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "덜 붐비는 야영지에 따라 마른가지일족 깃털({npc:15395})과 눈사태일족 구슬({npc:11556})을 번갈아 모으세요.",

	-- Step 13: Timbermaw Hold to Exalted
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Exalted"] = "{faction:576}: 확고한 동맹까지",
	["Keep turning in feathers and beads until Exalted."] = "확고한 동맹이 될 때까지 깃털과 구슬을 계속 제출하세요.",
}
