-- Russian (ruRU): the guide forever/class/mage/spellfire-robes (forever/class/mage/spellfire-robes.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest
	["A robe at 15 for Horde mages, from the {zone:1458} and {zone:1421}."] = "Роба на 15-м уровне для магов Орды: {zone:1458} и {zone:1421}.",

	-- Step 1: Uthel'nay (Orgrimmar)
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["{npc:7311} is one of {zone:1454}'s mage trainers. Then take the zeppelin to {zone:1420} from the tower outside {zone:1454}'s main gate."] = "{npc:7311} — один из учителей магов ({zone:1454}). Затем сядьте на дирижабль до зоны {zone:1420} у башни за главными воротами города {zone:1454}.",

	-- Step 2: Cain Firesong (Brill)
	-- {npc:2128} Cain Firesong · {area:159} Brill
	["{npc:2128} is the {area:159} mage trainer."] = "{npc:2128} — учитель магов. Локация: {area:159}.",

	-- Step 3: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:4568} stands in the {object:36082}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:4568} стоит здесь: {object:36082}. {item:7247} и {item:7308} лежат позади нее.",

	-- Step 4: The alchemist shop
	["The alchemist shop"] = "Лавка алхимика",
	-- {item:7308} Cantation of Manifestation · {npc:6492} Rift Spawn · {item:7247} Chest of Containment Coffers
	["Algernon's alchemist shop is in the Apothecarium. Use the {item:7308} there to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "Алхимическая лавка Алжернона находится в квартале аптекарей Подгорода. Используйте там {item:7308}, чтобы сделать видимым NPC {npc:6492}, ослабьте одного своими заклинаниями, затем используйте {item:7247}, чтобы бросить шкатулку и поймать его.",

	-- Step 5: Back to Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell
	["Back to {npc:4568}"] = "Вернитесь: {npc:4568}",

	-- Step 6: Linen Cloth
	-- {item:2589} Linen Cloth
	["Humanoids drop {item:2589}; the Undercity Auction House sells it."] = "С гуманоидов падает {item:2589}; его продают на аукционе Подгорода.",

	-- Step 7: Ambermill
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:279} Dalaran · {area:233} Ambermill · {area:228} Sepulcher · {npc:1867} Dalaran Apprentice · {item:7293} Dalaran Mana Gem
	["Leave the {zone:1458} and follow the road south through {zone:1421}. The {area:279} mages hold {area:233}, south-east of the {area:228}; every {npc:1867}, Mage, Protector, Warder, Conjuror, Watcher and Wizard can drop a {item:7293}."] = "Покиньте город {zone:1458} и идите по дороге на юг через зону {zone:1421}. Маги ({area:279}) удерживают {area:233}, к юго-востоку от места {area:228}; {item:7293} может выпасть с любого NPC {npc:1867}, а также с даларанских магов, заступников, тюремщиков, окудников, дозорных и волшебников.",

	-- Step 8: Josef Gregorian
	-- {zone:1458} Undercity · {npc:4576} Josef Gregorian · {npc:11048} Victor Ward · {npc:11049} Rhiannon Davis
	["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop."] = "Вернитесь в город {zone:1458}. {npc:4576}, {npc:11048} и {npc:11049} держат лавку портного.",
}
