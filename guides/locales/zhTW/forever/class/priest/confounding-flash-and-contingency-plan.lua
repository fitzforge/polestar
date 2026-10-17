-- Chinese (traditional) (zhTW): the guide forever/class/priest/confounding-flash-and-contingency-plan (forever/class/priest/confounding-flash-and-contingency-plan.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94817} Confounding Flash · {quest:94818} Contingency Plan
	["{quest:94817} and {quest:94818}"] = "{quest:94817}與{quest:94818}",
	["The Gnome priest spells, new in Forever: one at 10, one at 20."] = "地精的牧師法術，Forever 新增：10級一個，20級一個。",

	-- Step 1: Confounding Flash
	-- {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward · {npc:1226} Maxan Anvol · {area:131} Kharanos · {npc:377} Priestess Josetta · {area:87} Goldshire · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["At 10, go to {npc:258785} in the {object:32386}, in {zone:1455}'s {object:32362}. {npc:1226} in {area:131}, {npc:377} in {area:87} and {npc:376} in {zone:1453} send you to her with a quest of the same name (its text may say {zone:1453}: Mims is in {zone:1455})."] = "10級時，到{zone:1455}{object:32362}的{object:32386}找{npc:258785}。{area:131}的{npc:1226}、{area:87}的{npc:377}和{zone:1453}的{npc:376}會用同名任務派你去找她（任務文字可能寫{zone:1453}：敏絲在{zone:1455}）。",

	-- Step 2: Contingency Plan
	-- {npc:258785} High Priestess Mims · {quest:94818} Contingency Plan · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["At 20, {npc:258785} teaches {quest:94818}. {npc:376} in {zone:1453} sends you to her with a quest of the same name."] = "20級時，{npc:258785}會教你{quest:94818}。{zone:1453}的{npc:376}會用同名任務派你去找她。",
}
