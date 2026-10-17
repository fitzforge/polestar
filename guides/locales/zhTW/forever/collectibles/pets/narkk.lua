-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/narkk (forever/collectibles/pets/narkk.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:2663} Narkk
	["{npc:2663}'s Parrots"] = "{npc:2663}的鸚鵡",

	-- Step 1: Narkk
	-- {npc:2663} Narkk · {area:35} Booty Bay · {area:392} Ratchet
	["{npc:2663}, the pirate supplier in {area:35}, sells two parrots (40s each). {area:35} is neutral: the boat from {area:392} and the Stranglethorn road both arrive there. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{area:35}的海盜補給商{npc:2663}出售兩種鸚鵡（每隻40銀）。{area:35}是中立的：從{area:392}出發的船和荊棘谷的道路都通到那裡。每個寵物物品使用後會教你召喚該寵物；之後目標會保持勾選。",
	-- {item:8495} Parrot Cage (Senegal)
	["{item:8495}, 40s"] = "{item:8495}，40銀",
	-- {item:8496} Parrot Cage (Cockatiel)
	["{item:8496}, 40s"] = "{item:8496}，40銀",
}
