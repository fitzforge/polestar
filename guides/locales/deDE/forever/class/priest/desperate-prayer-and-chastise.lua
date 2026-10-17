-- German (deDE): the guide forever/class/priest/desperate-prayer-and-chastise (forever/class/priest/desperate-prayer-and-chastise.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["{quest:5634} and {quest:5641}"] = "{quest:5634} und {quest:5641}",
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["The Human and Dwarf priest spells: {quest:5634} at 10, {quest:5641} for Dwarves at 20."] = "Die Priesterzauber der Menschen und Zwerge: {quest:5634} mit Stufe 10, {quest:5641} für Zwerge mit Stufe 20.",

	-- Step 1: Desperate Prayer
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {area:2257} Deeprun Tram
	["At 10, go to {npc:11406} in the {object:32386}, in {zone:1455}'s {object:32362}. Forever's quest text names Rohan, but the quest data has {npc:376} in {zone:1453}'s Cathedral of Light take it: try Rohan first, then Laurena (the {area:2257} links the cities)."] = "Geh mit Stufe 10 zu {npc:11406} in der {object:32386} im {object:32362} in {zone:1455}. Der Questtext von Forever nennt Rohan, laut Questdaten nimmt sie aber {npc:376} in der Kathedrale des Lichts in {zone:1453} an: Versuch es zuerst bei Rohan, dann bei Laurena ({area:2257} verbindet die Städte).",

	-- Step 2: High Priestess Laurena
	-- {npc:376} High Priestess Laurena · {area:2257} Deeprun Tram · {object:171524} Tinker Town
	["If Rohan did not take it: {npc:376} is in the Cathedral of Light. Take the {area:2257} from {object:171524}."] = "Falls Rohan sie nicht angenommen hat: {npc:376} ist in der Kathedrale des Lichts. Nimm in {object:171524} die Bahn {area:2257}.",

	-- Step 3: Chastise
	-- {npc:11406} High Priest Rohan · {quest:5641} Chastise · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 20, {npc:11406} teaches {quest:5641}. {npc:376} in {zone:1453} and {npc:11401} in {zone:1457} send you to him with a quest of the same name."] = "Mit Stufe 20 lehrt {npc:11406} {quest:5641}. {npc:376} in {zone:1453} und {npc:11401} in {zone:1457} schicken dich mit einer gleichnamigen Quest zu ihm.",
}
