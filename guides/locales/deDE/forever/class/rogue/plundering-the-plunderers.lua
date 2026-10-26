-- German (deDE): the guide forever/class/rogue/plundering-the-plunderers (forever/class/rogue/plundering-the-plunderers.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7676} Thistle Tea
	["Ten {item:7676}, the rogue energy drink, from the Horde lockpicking jobs at 16."] = "Zehn {item:7676}, das Energiegetränk der Schurken, aus den Schlossknack-Aufträgen der Horde auf Stufe 16.",

	-- Step 1: To Orgrimmar!
	-- {npc:3170} Kaplak · {area:362} Razor Hill · {npc:3401} Shenthul · {zone:1454} Orgrimmar
	["At 16 {npc:3170}, the rogue trainer in {area:362}, sends you to {npc:3401} in {zone:1454}."] = "Auf Stufe 16 schickt dich {npc:3170}, der Schurkenlehrer in {area:362}, zu {npc:3401} in {zone:1454}.",

	-- Step 2: Find the Shattered Hand
	-- {npc:6467} Mennet Carkad · {object:36073} Rogues' Quarter · {npc:3401} Shenthul · {zone:1454} Orgrimmar · {quest:1998} Fenwick Thatros · {zone:1421} Silverpine Forest
	["At 16 {npc:6467} in the {object:36073} sends you to {npc:3401} in {zone:1454}. Take {quest:1998} from him too; it is done in {zone:1421} at the end of this guide."] = "Auf Stufe 16 schickt dich {npc:6467} im {object:36073} zu {npc:3401} in {zone:1454}. Nimm bei ihm auch {quest:1998} an; sie wird am Ende dieses Guides in {zone:1421} erledigt.",

	-- Step 3: Shenthul and Zando'zan
	-- {npc:3401} Shenthul · {quest:2379} Zando'zan
	["{npc:3401} and {quest:2379}"] = "{npc:3401} und {quest:2379}",
	-- {zone:1458} Undercity · {zone:1411} Durotar · {npc:3401} Shenthul · {quest:2379} Zando'zan · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["Undead take the zeppelin from the towers outside the {zone:1458} to {zone:1411}. {npc:3401} and {quest:2379} stand in the {object:172960}, the canyon under the {object:172982}."] = "Untote nehmen den Zeppelin von den Türmen außerhalb von {zone:1458} nach {zone:1411}. {npc:3401} und {quest:2379} stehen in der {object:172960}, der Schlucht unter dem {object:172982}.",

	-- Step 4: Wrenix the Wretched
	-- {area:392} Ratchet · {zone:1413} Barrens · {npc:7161} Wrenix the Wretched · {item:7970} E.C.A.C. · {item:5060} Thieves' Tools
	["Fly or walk to {area:392} on the {zone:1413} coast. {npc:7161} stands in town with his Gizmotronic Apparatus: buy an {item:7970} and {item:5060} from the apparatus before you go."] = "Flieg oder geh nach {area:392} an der Küste von {zone:1413}. {npc:7161} steht in der Stadt mit seinem Gizmotronischen Apparat: Kaufe vor dem Aufbruch {item:7970} und {item:5060} am Apparat.",

	-- Step 5: Southsea Treasure
	-- {area:392} Ratchet · {item:7970} E.C.A.C.
	["South along the coast from {area:392}, at the Southsea pirates' camp. If an unusually hostile parrot attacks you, use the {item:7970} on it (the quest's own advice)."] = "Südlich entlang der Küste von {area:392}, im Lager der Südmeerfreibeuter. Greift dich ein ungewöhnlich feindseliger Papagei an, benutze den {item:7970} an ihm (der eigene Rat der Quest).",

	-- Step 6: Back to Wrenix the Wretched
	-- {npc:7161} Wrenix the Wretched
	["Back to {npc:7161}"] = "Zurück zu {npc:7161}",
	-- {npc:7161} Wrenix the Wretched · {item:7676} Thistle Tea
	["{npc:7161}: ten {item:7676}"] = "{npc:7161}: zehn {item:7676}",

	-- Step 7: Fenwick Thatros
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {quest:1998} Fenwick Thatros · {area:228} Sepulcher
	["Take the zeppelin from {zone:1454} to the {zone:1458} and head south into Silverpine. {quest:1998} stands north-east of the {area:228}."] = "Nimm den Zeppelin von {zone:1454} nach {zone:1458} und geh nach Süden in den Silberwald. {quest:1998} steht nordöstlich des {area:228}.",

	-- Step 9: Ambermill
	-- {area:233} Ambermill · {object:103815} Ambermill Strongbox
	["The Kirin Tor keep their reports at {area:233}, in south-east Silverpine: pick the lock on the {object:103815}."] = "Die Kirin Tor bewahren ihre Berichte in {area:233} auf, im Südosten des Silberwalds: Knack das Schloss des {object:103815}.",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "Zurück zu {npc:6467}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly or ride to {area:392} on the {zone:1413} coast. {npc:7161} stands in town with his Gizmotronic Apparatus: buy an {item:7970} and {item:5060} from the apparatus before you go."] = "Flieg oder reite nach {area:392} an der Küste von {zone:1413}. {npc:7161} steht mit Wrenix' Elektrodingsda-Apparat im Ort: Kauf vor dem Aufbruch einen {item:7970} und {item:5060} am Apparat.",
	-- ["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south into Silverpine. {quest:1998} stands north-east of the {area:228}."] = "Nimm den Zeppelin von {zone:1454} nach {zone:1458} und reite nach Süden in den Silberwald. {quest:1998} steht nordöstlich von {area:228}.",
}
