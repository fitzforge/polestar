-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/shylenai (forever/collectibles/pets/shylenai.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8665} Shylenai
	["{npc:8665}'s Owls"] = "{npc:8665}的貓頭鷹",

	-- Step 1: Shylenai
	-- {npc:8665} Shylenai · {zone:1457} Darnassus · {item:280803} Eagle Owl
	["{npc:8665} sells three owls in {zone:1457} (50s each); the {item:280803} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8665}在{zone:1457}出售三種貓頭鷹（每隻50銀）；{item:280803}是Forever新增的。每個寵物物品使用後會教你召喚該寵物；之後目標會保持勾選。",
	-- {item:8500} Great Horned Owl
	["{item:8500}, 50s"] = "{item:8500}，50銀",
	-- {item:8501} Hawk Owl
	["{item:8501}, 50s"] = "{item:8501}，50銀",
	["50s"] = "50銀",
}
