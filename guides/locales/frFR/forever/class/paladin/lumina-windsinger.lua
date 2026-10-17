-- French (frFR): the guide forever/class/paladin/lumina-windsinger (forever/class/paladin/lumina-windsinger.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:91862} Lumina Windsinger
	["Rescuing {quest:91862}"] = "Secourir {quest:91862}",
	-- {item:268484} Moonsilver Blade
	["No item yet: a Forsaken paladin rescue story; its sequel, the {item:268484}, cannot be finished yet."] = "Pas encore d'objet : une histoire de sauvetage pour paladin réprouvé ; sa suite, la {item:268484}, ne peut pas encore être terminée.",
	-- {zone:1458} Undercity
	["{zone:1458} and Earthen Ring reputation"] = "Réputation auprès de {zone:1458} et du Cercle terrestre",

	-- Step 1: Danitha Morr
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {area:156} Solliden Farmstead
	["{npc:246378} leads the Paladins of Tyr's Watch from inside {area:16602}, on the bluffs north-west of the {area:156}."] = "{npc:246378} dirige les paladins de Tyr's Watch depuis {area:16602}, sur les hauteurs au nord-ouest de la {area:156}.",

	-- Step 2: The Sepulcher
	-- {zone:1421} Silverpine Forest · {area:228} The Sepulcher · {npc:248840} Trevan Rol · {npc:259611} Deathguard Baldren
	["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "Allez vers le sud à travers {zone:1421} jusqu'au {area:228}. {npc:248840} se trouve dans le bourg ; {npc:259611} monte la garde près de l'entrée.",

	-- Step 3: The pyre on Fenris Isle
	-- {area:172} Fenris Isle
	["The pyre on {area:172}"] = "Le bûcher de {area:172}",
	-- {area:172} Fenris Isle · {area:228} The Sepulcher
	["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172} se trouve dans le lac à l'est du {area:228}. Les restes calcinés sont sur sa rive.",
	-- {object:566037} Charred Remains
	["from the {object:566037}"] = "sur {object:566037}",

	-- Step 4: Fenris Keep
	-- {quest:91862} Lumina Windsinger · {area:235} Fenris Keep
	["{quest:91862} is caged inside {area:235}, at the north end of the isle. The Rot Hide gnolls around her carry the key."] = "{quest:91862} est enfermée dans une cage à l'intérieur de {area:235}, à l'extrémité nord de l'île. Les gnolls Poil-Putride autour d'elle portent la clé.",
	-- {item:267412} Fenris Isle Key
	["{item:267412}, from the Rot Hide gnolls"] = "{item:267412}, sur les gnolls Poil-Putride",

	-- Step 5: Free Lumina Windsinger
	-- {npc:248755} Lumina Windsinger
	["Free {npc:248755}"] = "Libérer {npc:248755}",
	["Free her with the key, then stay close while she fights her way out of the keep."] = "Libérez-la avec la clé, puis restez près d'elle pendant qu'elle se fraie un chemin hors du donjon.",

	-- Step 6: Back to the The Sepulcher
	-- {area:228} The Sepulcher
	["Back to the {area:228}"] = "Retour au {area:228}",
	-- {area:235} Fenris Keep · {npc:259620} Lumina Windsinger · {area:228} The Sepulcher
	["Once she is clear of {area:235}, {npc:259620} waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Une fois sortie de {area:235}, {npc:259620} vous attend au {area:228}. Parlez-lui de nouveau pour apprendre ce qui s'est vraiment passé sur la route.",
	-- {npc:259620} Lumina Windsinger · {area:228} The Sepulcher
	["{npc:259620}, the {area:228}"] = "{npc:259620}, au {area:228}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:228}"] = "Retour au {area:228}",
	-- ["Once she is clear of {area:235}, Lumina waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Une fois sortie de {area:235}, Lumina vous attend au {area:228}. Parlez-lui de nouveau pour apprendre ce qui s'est vraiment passé sur la route.",
	-- ["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "Allez vers le sud à travers {zone:1421} jusqu'au {area:228}. {npc:248840} se trouve dans le bourg ; {npc:259611} monte la garde près de l'entrée.",
	-- ["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172} se trouve dans le lac à l'est du {area:228}. Les restes calcinés sont sur sa rive.",
	-- ["{item:267412}, from the {npc:14235} Hide gnolls"] = "{item:267412}, sur les gnolls poil-putride ({npc:14235})",
	-- ["{npc:259620}, the {area:228}"] = "{npc:259620}, au {area:228}",
	-- ["{quest:91862} is caged inside {area:235}, at the north end of the isle. {npc:14235} Hide gnolls around her carry the key."] = "{quest:91862} est enfermée dans une cage à {area:235}, au nord de l'île. Les gnolls poil-putride ({npc:14235}) qui l'entourent portent la clé.",
}
