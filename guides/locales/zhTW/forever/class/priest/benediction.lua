-- Chinese (traditional) (zhTW): the guide forever/class/priest/benediction (forever/class/priest/benediction.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:18608} Benediction
	["{item:18608} and Anathema"] = "{item:18608}與咒逐",
	-- {npc:14494} Eris Havenfire · {item:18608} Benediction
	["{npc:14494}'s splinter and the two Eyes make {item:18608}, the epic priest staff that turns into Anathema."] = "{npc:14494}的碎片和兩顆眼睛可以製成{item:18608}，這把史詩牧師法杖可以轉變成咒逐。",

	-- Step 1: The Eye of Shadow
	-- {item:18646} The Eye of Divinity · {object:179703} Cache of the Firelord · {npc:12018} Majordomo Executus · {area:2717} Molten Core · {item:18665} The Eye of Shadow · {npc:12397} Lord Kazzak
	-- plural, as words: Doomguard Commanders = {npc:12396} Doomguard Commander
	["You need {item:18646} first: it comes from the {object:179703} after {npc:12018} in {area:2717}. {item:18665} drops from elite demons ({npc:12397}, a world boss, always; Doomguard Commanders and Manahounds rarely); it binds when equipped, so buying one works too."] = "你需要先取得{item:18646}：它來自{area:2717}擊敗{npc:12018}後的{object:179703}。{item:18665}由精英惡魔掉落（世界首領{npc:12397}必定掉落；{npc:12396}和法力犬極少掉落）；它是裝備後綁定，所以也可以用買的。",

	-- Step 2: Eris Havenfire
	-- {item:18646} The Eye of Divinity · {npc:14494} Eris Havenfire · {zone:1423} Eastern Plaguelands · {item:8956} Oil of Immolation
	-- plural, as words: Major Mana Potions = {item:13444} Major Mana Potion
	["Equip {item:18646} to see {npc:14494}, a ghost on the mountainside in the north-west of the {zone:1423}. Come with full mana, Major Mana Potions and {item:8956}: if you fail, the event takes about two hours to return."] = "裝備{item:18646}才能看見{npc:14494}，她是{zone:1423}西北部山坡上的一個鬼魂。帶著滿法力、極效法力藥水和{item:8956}前往：如果失敗，事件大約要兩小時才會重新出現。",

	-- Step 3: The Balance of Light and Shadow
	-- {spell:139} Renew
	["Save 50 peasants before 15 die. Kill the skeletons that attack them, cure their diseases (the purple ones first) and heal the wounded with {spell:139}. Friends may buff you beforehand but must stay out of the fight, or a demon appears and kills everyone."] = "在15個農民死亡之前救出50個。擊殺攻擊他們的骷髏，治癒他們的疾病（先治紫色的），並用{spell:139}治療傷者。朋友可以事先為你施加增益，但必須遠離戰鬥，否則會出現一個惡魔殺死所有人。",

	-- Step 4: Benediction
	-- {item:18608} Benediction
	["With both Eyes in your bags: {item:18608}"] = "兩顆眼睛都在背包裡時：{item:18608}",
}
