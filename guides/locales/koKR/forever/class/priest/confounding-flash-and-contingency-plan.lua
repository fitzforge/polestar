-- Korean (koKR): the guide forever/class/priest/confounding-flash-and-contingency-plan (forever/class/priest/confounding-flash-and-contingency-plan.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94817} Confounding Flash · {quest:94818} Contingency Plan
	["{quest:94817} and {quest:94818}"] = "{quest:94817}와(과) {quest:94818}",
	["The Gnome priest spells, new in Forever: one at 10, one at 20."] = "Forever에 새로 추가된 노움 사제 주문입니다. 하나는 10레벨, 하나는 20레벨.",

	-- Step 1: Confounding Flash
	-- {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:1226} Maxan Anvol · {area:131} Kharanos · {npc:377} Priestess Josetta · {area:87} Goldshire · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["At 10, go to {npc:258785} in the {object:32386}, in {zone:1455}'s {object:32362}. {npc:1226} in {area:131}, {npc:377} in {area:87} and {npc:376} in {zone:1453} send you to her with a quest of the same name (its text may say {zone:1453}: Mims is in {zone:1455})."] = "10레벨에 {zone:1455} {object:32362}의 {object:32386}에 있는 {npc:258785}에게 가세요. {area:131}의 {npc:1226}, {area:87}의 {npc:377}, {zone:1453}의 {npc:376}이(가) 같은 이름의 퀘스트로 당신을 그녀에게 보냅니다(퀘스트 내용에는 {zone:1453}(이)라고 나올 수 있지만 밈스는 {zone:1455}에 있습니다).",

	-- Step 2: Contingency Plan
	-- {npc:258785} High Priestess Mims · {quest:94818} Contingency Plan · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["At 20, {npc:258785} teaches {quest:94818}. {npc:376} in {zone:1453} sends you to her with a quest of the same name."] = "20레벨에 {npc:258785}이(가) {quest:94818}을(를) 가르쳐 줍니다. {zone:1453}의 {npc:376}이(가) 같은 이름의 퀘스트로 당신을 그녀에게 보냅니다.",
}
