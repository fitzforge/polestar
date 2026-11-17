-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/lil-timmy (forever/collectibles/pets/lil-timmy.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Lil Timmy
	-- {npc:8666} Lil Timmy · {npc:7386} White Kitten · {object:2098} Cathedral Square · {object:2096} Trade District · {object:2100} Old Town · {object:28027} Dwarven District
	["{npc:8666} sells the {npc:7386} (60s). He starts at {object:2098} and walks through the {object:2096}, {object:2100} and the {object:28027} before he vanishes near the square again; if he is not around, wait for him at {object:2098}. By beta reports he carries one kitten at a time: if he has none, someone just bought it. Each pet item teaches its companion when you use it; the goal stays ticked afterwards."] = "{npc:8666}出售{npc:7386}（60銀）。他從{object:2098}出發，穿過{object:2096}、{object:2100}和{object:28027}，然後在廣場附近再次消失；如果找不到他，就在{object:2098}等他。據測試服報告，他一次只帶一隻小貓：如果他沒有，那就是剛被人買走了。每件寵物物品在使用時都會教會對應的夥伴；之後該目標仍保持打勾。",
	-- {item:8489} Cat Carrier (White Kitten)
	["{item:8489}, 60s"] = "{item:8489}，60銀",

	-- Step 2: Xaphod Bizznox
	-- {npc:7386} White Kitten · {npc:262471} Xaphod Bizznox · {area:2539} Malaka'jin · {zone:1442} Stonetalon Mountains · {zone:1413} Barrens
	["Horde players buy the {npc:7386} (60s) from {npc:262471}, a trader new in Forever, at {area:2539}, the Darkspear camp at the southern tip of {zone:1442}, on the way up from the {zone:1413}. He keeps one kitten at a time: if he has none, someone just bought it. Each pet item teaches its companion when you use it; the goal stays ticked afterwards."] = "部落玩家從{npc:262471}那裡買{npc:7386}（60銀），他是 Forever 裡新來的商人，在{area:2539}——{zone:1442}南端的暗矛營地，從{zone:1413}上來的路上。他一次只備一隻小貓：要是他沒有，就是剛被人買走了。每個寵物物品使用後會教會對應的夥伴；之後目標仍然保持勾選。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:8666} sells the {npc:7386} (60s). He walks around the city, so the waypoint is only one point on his path; look along the nearby streets if he is not there. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8666}出售{npc:7386}（60銀）。他會在城裡走動，所以路徑點只是他路線上的一點；如果他不在，請沿附近街道尋找。使用每件寵物物品即可學會對應的小寵物；之後目標會保持勾選。",
}
