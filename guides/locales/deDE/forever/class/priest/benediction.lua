-- German (deDE): the guide forever/class/priest/benediction (forever/class/priest/benediction.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:18608} Benediction
	["{item:18608} and Anathema"] = "{item:18608} und Bannfluch",
	-- {npc:14494} Eris Havenfire · {item:18608} Benediction
	["{npc:14494}'s splinter and the two Eyes make {item:18608}, the epic priest staff that turns into Anathema."] = "Der Splitter von {npc:14494} und die beiden Augen ergeben {item:18608}, den epischen Priesterstab, der sich in Bannfluch verwandelt.",

	-- Step 1: The Eye of Shadow
	-- {item:18646} The Eye of Divinity · {object:179703} Cache of the Firelord · {npc:12018} Majordomo Executus · {area:2717} Molten Core · {item:18665} The Eye of Shadow · {npc:12397} Lord Kazzak
	-- plural, as words: Doomguard Commanders = {npc:12396} Doomguard Commander
	["You need {item:18646} first: it comes from the {object:179703} after {npc:12018} in {area:2717}. {item:18665} drops from elite demons ({npc:12397}, a world boss, always; Doomguard Commanders and Manahounds rarely); it binds when equipped, so buying one works too."] = "Zuerst brauchst du {item:18646}: Es stammt aus dem {object:179703} nach {npc:12018} in {area:2717}. {item:18665} droppt von Elitedämonen ({npc:12397}, ein Weltboss, immer; Kommandanten der Verdammniswache und Manahunde selten); es wird beim Anlegen gebunden, Kaufen geht also auch.",

	-- Step 2: Eris Havenfire
	-- {item:18646} The Eye of Divinity · {npc:14494} Eris Havenfire · {zone:1423} Eastern Plaguelands · {item:8956} Oil of Immolation
	-- plural, as words: Major Mana Potions = {item:13444} Major Mana Potion
	["Equip {item:18646} to see {npc:14494}, a ghost on the mountainside in the north-west of the {zone:1423}. Come with full mana, Major Mana Potions and {item:8956}: if you fail, the event takes about two hours to return."] = "Leg {item:18646} an, um {npc:14494} zu sehen, einen Geist am Berghang im Nordwesten von {zone:1423}. Komm mit vollem Mana, Erheblichen Manatränken und {item:8956}: Scheiterst du, dauert es etwa zwei Stunden, bis das Ereignis wiederkommt.",

	-- Step 3: The Balance of Light and Shadow
	-- {spell:139} Renew
	["Save 50 peasants before 15 die. Kill the skeletons that attack them, cure their diseases (the purple ones first) and heal the wounded with {spell:139}. Friends may buff you beforehand but must stay out of the fight, or a demon appears and kills everyone."] = "Rette 50 Bauern, bevor 15 sterben. Töte die Skelette, die sie angreifen, heile ihre Krankheiten (zuerst die lila) und heile die Verwundeten mit {spell:139}. Freunde dürfen dich vorher buffen, müssen aber aus dem Kampf bleiben, sonst erscheint ein Dämon und tötet alle.",

	-- Step 4: Benediction
	-- {item:18608} Benediction
	["With both Eyes in your bags: {item:18608}"] = "Mit beiden Augen in den Taschen: {item:18608}",
}
