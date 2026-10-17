-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/bitter-baitling (forever/collectibles/pets/bitter-baitling.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Extravagant Extravaganza Coin
	-- {item:276275} Bitter Baitling · {npc:15078} Jang · {item:274026} Extravagant Extravaganza Coin · {area:35} Booty Bay
	["The {item:276275} is a fishing reward: {npc:15078} trades it for one {item:274026}, a reward of the fishing contest {npc:15078} runs in {area:35}. The coin's exact source is not published yet."] = "{item:276275}是釣魚獎勵：{npc:15078}會用它交換一枚{item:274026}，那是{npc:15078}在{area:35}舉辦的釣魚比賽的獎勵。這枚硬幣的確切來源尚未公布。",

	-- Step 2: Jang
	-- {npc:15078} Jang · {area:35} Booty Bay
	["{npc:15078} stands on the {area:35} docks."] = "{npc:15078}站在{area:35}的碼頭上。",
}
