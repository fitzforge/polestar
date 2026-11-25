-- Korean (koKR): the guide forever/collectibles/pets/worg-carrier (forever/collectibles/pets/worg-carrier.guide).
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
	-- {npc:10260} Kibler · {area:251} Flame Crest · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {item:12262} Empty Worg Pup Cage · {item:12529} Smolderweb Carrier
	["{npc:10260} stands inside the cave at {area:251}, the camp in northern {zone:1428} east of {area:254}. He gives you an {item:12262}. He also gives En-Ay-Es-Tee-Why (the {item:12529}): take both, they are done in the same run."] = "{npc:10260}은(는) 북부 {zone:1428}의 {area:254} 동쪽 야영지 {area:251} 동굴 안에 있습니다. 빈 우리 {item:12262}을(를) 줍니다. 엔-아이-에스-티-와이({item:12529})도 주니 둘 다 받으세요. 한 번에 끝납니다.",

	-- Step 2: Lower Blackrock Spire: Halycon's pups
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}: Halycon's pups"] = "{area:1583} 하층: 할리콘의 새끼들",
	-- {npc:10584} Urok Doomhowl · {npc:10221} Bloodaxe Worg Pup
	["The pups are in Lower Blackrock Spire (a group of five, level 55-60), not Upper: they run with Halycon, the great worg, deep in the dungeon beyond {npc:10584}'s ogres. Use the cage on a living {npc:10221} before the pack is dead. Taking damage interrupts the cast, so let the tank hold the pups and cage one from the side. A rogue or druid can sneak in, cage a pup from a corner, then vanish."] = "새끼들은 상층이 아니라 블랙록 첨탑 하층(5인, 55-60레벨)에 있습니다. {npc:10584}의 오우거 지나 깊은 곳에서 대형 워그 할리콘과 함께 있습니다. 무리가 죽기 전에 살아 있는 {npc:10221}에게 우리를 사용하세요. 피해를 받으면 시전이 끊기니 탱크가 새끼들을 붙잡아 두고 옆에서 우리에 넣으세요. 도적이나 드루이드는 몰래 들어가 구석에서 새끼를 우리에 넣고 은신제를 쓸 수 있습니다.",
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}"] = "{area:1583} 하층",

	-- Step 3: Back to Kibler
	-- {npc:10260} Kibler
	["Back to {npc:10260}"] = "{npc:10260}에게 돌아가기",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Upper {area:1583}"] = "상층 {area:1583}",
	-- ["Upper {area:1583} is a raid group of up to ten, level 58-60. Use {npc:10260}'s cage on a {npc:10221} (Halycon's den) to get the {item:12263}."] = "상층 {area:1583}은(는) 58-60레벨, 최대 10인 공격대 던전입니다. {npc:10260}의 우리를 {npc:10221}(할리콘의 굴)에게 사용해 {item:12263}을(를) 얻으세요.",
	-- ["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260}은(는) {zone:1428} 북부의 {area:251}, {area:254}(으)로 가는 길 근처에 서 있습니다.",
}
