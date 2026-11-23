-- Korean (koKR): the guide forever/collectibles/pets/smolderweb-carrier (forever/collectibles/pets/smolderweb-carrier.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kibler at Flame Crest
	-- {npc:10260} Kibler · {area:251} Flame Crest
	["{npc:10260} at {area:251}"] = "{area:251}의 {npc:10260}",
	-- {npc:10260} Kibler · {area:251} Flame Crest · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {item:12264} Worg Carrier
	["{npc:10260} stands inside the cave at {area:251}, the camp in northern {zone:1428} east of {area:254}. He also gives {npc:10260}'s Exotic Pets (the {item:12264}): take both, they are done in the same run."] = "{npc:10260}은(는) 북부 {zone:1428}의 {area:254} 동쪽 야영지 {area:251} 동굴 안에 있습니다. {npc:10260}의 이색 애완동물({item:12264})도 주니 두 개 다 받으세요. 한 번에 끝납니다.",

	-- Step 2: Lower Blackrock Spire
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}"] = "{area:1583} 하층",
	-- {area:1583} Blackrock Spire · {area:254} Blackrock Mountain · {npc:10596} Mother Smolderweb
	-- plural, as words: Spire Spider Eggs = {item:12530} Spire Spider Egg
	["Lower {area:1583} is a group of five, level 55-60, inside {area:254}. The Spire Spider Eggs lie around {npc:10596}'s nest in the Skitterweb Tunnels, the spider halls: click them until you have 15 (each gives one to three). Hard-hitting spiderlings can hatch as you loot. By player reports the eggs cannot be looted in a raid group, so keep the party at five or fewer."] = "{area:1583} 하층은 {area:254} 안의 55-60레벨 5인 던전입니다. 첨탑 거미 알은 거미굴인 스키터웹 터널의 {npc:10596} 둥지 주변에 있습니다. 15개가 될 때까지 클릭하세요(하나에 1~3개). 줍는 동안 강력한 새끼 거미가 부화할 수 있습니다. 플레이어 보고에 따르면 공격대 편성으로는 줍지 못하니 파티를 5명 이하로 유지하세요.",

	-- Step 3: Back to Kibler
	-- {npc:10260} Kibler
	["Back to {npc:10260}"] = "{npc:10260}에게 돌아가기",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Lower {area:1583} is a group of five, level 55-60. Collect 15 Spire Spider Eggs from the nests near {npc:10596}."] = "{area:1583} 하층은 5인 파티용, 55-60레벨입니다. {npc:10596} 근처 둥지에서 {item:12530} 15개를 모으세요.",
	-- ["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260}은(는) {zone:1428} 북부의 {area:251}, {area:254}(으)로 가는 길 근처에 있습니다.",
}
