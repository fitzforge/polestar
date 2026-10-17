-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/flik (forever/collectibles/pets/flik.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darkmoon Faire Frogs"] = "暗月馬戲團的青蛙",

	-- Step 1: Flik at the Darkmoon Faire
	-- {npc:14860} Flik
	["{npc:14860} at the Darkmoon Faire"] = "暗月馬戲團的{npc:14860}",
	-- {npc:14860} Flik · {area:87} Goldshire · {zone:1429} Elwynn Forest · {zone:1456} Thunder Bluff · {zone:1412} Mulgore
	["{npc:14860} sells two frogs (1g each) while the Darkmoon Faire is in town. In Era the Faire sets up south of {area:87} in {zone:1429} one month and near {zone:1456} in {zone:1412} the next; go to whichever is up. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "暗月馬戲團來訪期間，{npc:14860}出售兩種青蛙（各1金）。在經典版中，馬戲團一個月在{zone:1429}的{area:87}南邊紮營，下個月在{zone:1412}的{zone:1456}附近；去正在開放的那一處。使用每件寵物物品即可學會對應的小寵物；之後目標會保持勾選。",
	-- {item:11026} Tree Frog Box
	["{item:11026}, 1g"] = "{item:11026}，1金",
	-- {item:11027} Wood Frog Box
	["{item:11027}, 1g"] = "{item:11027}，1金",
}
