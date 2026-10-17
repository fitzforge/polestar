-- French (frFR): the guide forever/class/priest/benediction (forever/class/priest/benediction.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:18608} Benediction
	["{item:18608} and Anathema"] = "{item:18608} et Anathème",
	-- {npc:14494} Eris Havenfire · {item:18608} Benediction
	["{npc:14494}'s splinter and the two Eyes make {item:18608}, the epic priest staff that turns into Anathema."] = "L'éclat d'{npc:14494} et les deux Yeux donnent {item:18608}, le bâton épique de prêtre qui se change en Anathème.",

	-- Step 1: The Eye of Shadow
	-- {item:18646} The Eye of Divinity · {object:179703} Cache of the Firelord · {npc:12018} Majordomo Executus · {area:2717} Molten Core · {item:18665} The Eye of Shadow · {npc:12397} Lord Kazzak
	-- plural, as words: Doomguard Commanders = {npc:12396} Doomguard Commander
	["You need {item:18646} first: it comes from the {object:179703} after {npc:12018} in {area:2717}. {item:18665} drops from elite demons ({npc:12397}, a world boss, always; Doomguard Commanders and Manahounds rarely); it binds when equipped, so buying one works too."] = "Il vous faut d'abord {item:18646} : il vient de la {object:179703} après {npc:12018} dans le {area:2717}. {item:18665} tombe sur des démons élites ({npc:12397}, un boss mondial, à coup sûr ; les Commandants de la Garde funeste et les Molosses de mana, rarement) ; il est lié quand équipé, vous pouvez donc aussi l'acheter.",

	-- Step 2: Eris Havenfire
	-- {item:18646} The Eye of Divinity · {npc:14494} Eris Havenfire · {zone:1423} Eastern Plaguelands · {item:8956} Oil of Immolation
	-- plural, as words: Major Mana Potions = {item:13444} Major Mana Potion
	["Equip {item:18646} to see {npc:14494}, a ghost on the mountainside in the north-west of the {zone:1423}. Come with full mana, Major Mana Potions and {item:8956}: if you fail, the event takes about two hours to return."] = "Équipez {item:18646} pour voir {npc:14494}, un fantôme à flanc de montagne au nord-ouest des {zone:1423}. Venez avec tout votre mana, des Potions de mana majeures et de l'{item:8956} : en cas d'échec, l'événement met environ deux heures à revenir.",

	-- Step 3: The Balance of Light and Shadow
	-- {spell:139} Renew
	["Save 50 peasants before 15 die. Kill the skeletons that attack them, cure their diseases (the purple ones first) and heal the wounded with {spell:139}. Friends may buff you beforehand but must stay out of the fight, or a demon appears and kills everyone."] = "Sauvez 50 paysans avant que 15 ne meurent. Tuez les squelettes qui les attaquent, guérissez leurs maladies (les violettes d'abord) et soignez les blessés avec {spell:139}. Des amis peuvent vous donner des améliorations avant, mais doivent rester hors du combat, sinon un démon apparaît et tue tout le monde.",

	-- Step 4: Benediction
	-- {item:18608} Benediction
	["With both Eyes in your bags: {item:18608}"] = "Avec les deux Yeux dans vos sacs : {item:18608}",
}
