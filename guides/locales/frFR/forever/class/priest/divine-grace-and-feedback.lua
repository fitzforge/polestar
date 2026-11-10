-- French (frFR): the guide forever/class/priest/divine-grace-and-feedback (forever/class/priest/divine-grace-and-feedback.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["{quest:94773} and {spell:13896}"] = "{quest:94773} et {spell:13896}",
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["The Human priest spells: {quest:94773} at 10 (new in Forever), {spell:13896} at 20. Free, no objectives."] = "Les sorts de prêtre humain : {quest:94773} au niveau 10 (nouveau dans Forever), {spell:13896} au niveau 20. Gratuits, sans objectif.",

	-- Step 1: Divine Grace: Priestess Josetta
	-- {npc:377} Priestess Josetta · {area:87} Goldshire · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["At 10, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you a letter for {npc:376}. {area:87} is on the road north to {zone:1453}, so it costs no detour."] = "Au niveau 10, {npc:377}, à l'étage de l'auberge de la Fierté du lion à {area:87}, vous remet une lettre pour {npc:376}. {area:87} est sur la route qui monte vers le nord à {zone:1453} : aucun détour.",
	-- {npc:377} Priestess Josetta · {quest:94773} Divine Grace
	["{npc:377}: take her {quest:94773} letter"] = "{npc:377} : prenez sa lettre {quest:94773}",

	-- Step 2: Divine Grace: Laurna Morninglight
	-- {zone:1438} Teldrassil · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["A Human priest in {zone:1438} at 10: {npc:3600}, in the building at the north edge of {area:186}, hands you a letter for {npc:376} in {zone:1453}."] = "Un prêtre humain à {zone:1438} au niveau 10 : {npc:3600}, dans le bâtiment au bord nord de {area:186}, vous remet une lettre pour {npc:376} à {zone:1453}.",
	-- {npc:3600} Laurna Morninglight · {quest:94773} Divine Grace
	["{npc:3600}: take her {quest:94773} letter"] = "{npc:3600} : prenez sa lettre {quest:94773}",

	-- Step 3: Divine Grace: High Priestess Laurena
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {object:2098} Cathedral Square · {quest:94773} Divine Grace · {spell:6788} Weakened Soul
	["At 10, go to {npc:376} at the altar of the Cathedral of Light, in {zone:1453}'s {object:2098}, and take her quest: she teaches {quest:94773} on the spot. No letter needed; one from another trainer works too (next steps). {quest:94773} instantly heals a friend below half health and clears {spell:6788}, so you can shield them again (5-minute cooldown); it does not work on yourself. Human priests do not get Desperate Prayer in Forever: this is their spell instead."] = "Au niveau 10, allez voir {npc:376} à l'autel de la cathédrale de la Lumière, sur la {object:2098} de {zone:1453}, et acceptez sa quête : elle vous apprend {quest:94773} sur-le-champ. Pas besoin de lettre ; celle d'un autre maître fonctionne aussi (étapes suivantes). {quest:94773} soigne instantanément un allié sous la moitié de sa vie et dissipe {spell:6788}, ce qui vous permet de lui remettre un bouclier (temps de recharge de 5 minutes) ; ne fonctionne pas sur vous-même. Les prêtres humains n'ont pas Prière du désespoir dans Forever : c'est leur sort à la place.",

	-- Step 4: Divine Grace: Josetta's letter
	-- {quest:94774} Divine Grace
	["{quest:94774}: Josetta's letter"] = "{quest:94774} : la lettre de Josetta",
	-- {npc:376} High Priestess Laurena · {quest:94774} Divine Grace
	["Hand Josetta's letter to {npc:376} at the altar of the Cathedral of Light: she teaches {quest:94774}."] = "Remettez la lettre de Josetta à {npc:376}, à l'autel de la cathédrale de la Lumière : elle vous apprend {quest:94774}.",

	-- Step 5: Divine Grace: Laurna Morninglight's letter
	-- {quest:94775} Divine Grace · {npc:3600} Laurna Morninglight
	["{quest:94775}: {npc:3600}'s letter"] = "{quest:94775} : la lettre de {npc:3600}",
	-- {npc:3600} Laurna Morninglight · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {zone:1438} Teldrassil · {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor · {quest:94775} Divine Grace
	["Hand {npc:3600}'s letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (from {zone:1438}: the boat from {area:702} to {area:442}, then the boat to {area:17203}): she teaches {quest:94775}."] = "Remettez la lettre de {npc:3600} à {npc:376}, à l'autel de la cathédrale de la Lumière de {zone:1453} (depuis {zone:1438} : le bateau du {area:702} à {area:442}, puis le bateau pour le {area:17203}) : elle vous apprend {quest:94775}.",

	-- Step 6: Divine Grace: a letter from another trainer
	-- {quest:94776} Divine Grace
	["{quest:94776}: a letter from another trainer"] = "{quest:94776} : une lettre d'un autre maître",
	-- {quest:94776} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94776} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Toute lettre {quest:94776} va à {npc:376}, à l'autel de la cathédrale de la Lumière.",

	-- Step 7: Divine Grace: a letter from another trainer
	-- {quest:94777} Divine Grace
	["{quest:94777}: a letter from another trainer"] = "{quest:94777} : une lettre d'un autre maître",
	-- {quest:94777} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94777} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Toute lettre {quest:94777} va à {npc:376}, à l'autel de la cathédrale de la Lumière.",

	-- Step 8: Divine Grace: a letter from another trainer
	-- {quest:94778} Divine Grace
	["{quest:94778}: a letter from another trainer"] = "{quest:94778} : une lettre d'un autre maître",
	-- {quest:94778} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94778} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Toute lettre {quest:94778} va à {npc:376}, à l'autel de la cathédrale de la Lumière.",

	-- Step 9: Divine Grace: a letter from another trainer
	-- {quest:94779} Divine Grace
	["{quest:94779}: a letter from another trainer"] = "{quest:94779} : une lettre d'un autre maître",
	-- {quest:94779} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94779} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Toute lettre {quest:94779} va à {npc:376}, à l'autel de la cathédrale de la Lumière.",

	-- Step 10: Feedback: High Priest Rohan
	-- {zone:1455} Ironforge · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town
	["At 20 in {zone:1455}, {npc:11406} in the {object:32386} ({object:32362}) hands you a letter for {npc:376} in {zone:1453}. The {area:2257} from {object:171524} takes you there."] = "Au niveau 20 à {zone:1455}, {npc:11406}, dans la salle des Mystères ({object:32362}), vous remet une lettre pour {npc:376} à {zone:1453}. Le {area:2257}, depuis {object:171524}, vous y emmène.",
	-- {npc:11406} High Priest Rohan · {quest:5676} Arcane Feedback
	["{npc:11406}: take his {quest:5676} letter"] = "{npc:11406} : prenez sa lettre {quest:5676}",

	-- Step 11: Feedback: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["At 20 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a letter for {npc:376} in {zone:1453}."] = "Au niveau 20 à {zone:1457}, {npc:11401}, sur le balcon supérieur du temple de la Lune à côté de {npc:7999}, vous remet une lettre pour {npc:376} à {zone:1453}.",
	-- {npc:11401} Priestess Alathea · {quest:5676} Arcane Feedback
	["{npc:11401}: take her {quest:5676} letter"] = "{npc:11401} : prenez sa lettre {quest:5676}",

	-- Step 12: Feedback: High Priestess Laurena
	-- {npc:376} High Priestess Laurena · {spell:13896} Feedback
	["At 20, {npc:376} at the altar of the Cathedral of Light teaches {spell:13896} with a quest she gives and takes back at once."] = "Au niveau 20, {npc:376}, à l'autel de la cathédrale de la Lumière, vous apprend {spell:13896} avec une quête qu'elle donne et reprend aussitôt.",

	-- Step 13: Feedback: Rohan's letter
	-- {spell:13896} Feedback
	["{spell:13896}: Rohan's letter"] = "{spell:13896} : la lettre de Rohan",
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1455} Ironforge · {spell:13896} Feedback
	["Hand Rohan's letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (the {area:2257} from {object:171524} in {zone:1455}): she teaches {spell:13896}."] = "Remettez la lettre de Rohan à {npc:376}, à l'autel de la cathédrale de la Lumière de {zone:1453} (le {area:2257} depuis {object:171524}, à {zone:1455}) : elle vous apprend {spell:13896}.",

	-- Step 14: Feedback: Alathea's letter
	-- {spell:13896} Feedback
	["{spell:13896}: Alathea's letter"] = "{spell:13896} : la lettre d'Alathea",
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor · {spell:13896} Feedback
	["Hand Alathea's letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (from {zone:1457}: the portal down to {area:702}, the boat to {area:442}, then the boat to {area:17203}): she teaches {spell:13896}."] = "Remettez la lettre d'Alathea à {npc:376}, à l'autel de la cathédrale de la Lumière de {zone:1453} (depuis {zone:1457} : le portail qui descend au {area:702}, le bateau pour {area:442}, puis le bateau pour le {area:17203}) : elle vous apprend {spell:13896}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:376} in the Cathedral of Light. {npc:377} in {area:87} sends you to her with a quest of the same name."] = "Au niveau 10, allez voir {npc:376} dans la cathédrale de la Lumière. {npc:377}, à {area:87}, vous envoie la voir avec une quête du même nom.",
	-- ["At 20, {npc:376} teaches {spell:13896}. {npc:11406} in {zone:1455} and {npc:11401} in {zone:1457} send you to her with a quest of the same name."] = "Au niveau 20, {npc:376} enseigne {spell:13896}. {npc:11406}, à {zone:1455}, et {npc:11401}, à {zone:1457}, vous envoient la voir avec une quête du même nom.",
	-- ["The Human priest spells: {quest:94773} at 10, {spell:13896} at 20."] = "Les sorts de prêtre humain : {quest:94773} au niveau 10, {spell:13896} au niveau 20.",
}
