-- German (deDE): the guide forever/class/paladin/lumina-windsinger (forever/class/paladin/lumina-windsinger.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:91862} Lumina Windsinger
	["Rescuing {quest:91862}"] = "{quest:91862} retten",
	-- {item:268484} Moonsilver Blade
	["No item yet: a Forsaken paladin rescue story; its sequel, the {item:268484}, cannot be finished yet."] = "Noch kein Gegenstand: eine Rettungsgeschichte für Paladine der Verlassenen; die Fortsetzung, die {item:268484}, kann noch nicht abgeschlossen werden.",
	-- {zone:1458} Undercity
	["{zone:1458} and Earthen Ring reputation"] = "Ruf bei {zone:1458} und beim Irdenen Ring",

	-- Step 1: Danitha Morr
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {area:156} Solliden Farmstead
	["{npc:246378} leads the Paladins of Tyr's Watch from inside {area:16602}, on the bluffs north-west of the {area:156}."] = "{npc:246378} führt die Paladine von Tyrs Wacht aus {area:16602} heraus, auf den Klippen nordwestlich von {area:156}.",

	-- Step 2: The Sepulcher
	-- {zone:1421} Silverpine Forest · {area:228} The Sepulcher · {npc:248840} Trevan Rol · {npc:259611} Deathguard Baldren
	["Head south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "Geh nach Süden durch {zone:1421} zum {area:228}. {npc:248840} steht in der Stadt; {npc:259611} hält in der Nähe des Eingangs Wache.",

	-- Step 3: The pyre on Fenris Isle
	-- {area:172} Fenris Isle
	["The pyre on {area:172}"] = "Der Scheiterhaufen auf der {area:172}",
	-- {area:172} Fenris Isle · {area:228} The Sepulcher
	["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "Die {area:172} liegt im See östlich vom {area:228}. Die verkohlten Überreste sind am Ufer.",
	-- {object:566037} Charred Remains
	["from the {object:566037}"] = "von den {object:566037}",

	-- Step 4: Fenris Keep
	-- {quest:91862} Lumina Windsinger · {area:235} Fenris Keep
	["{quest:91862} is caged inside {area:235}, at the north end of the isle. The Rot Hide gnolls around her carry the key."] = "{quest:91862} ist in {area:235} eingesperrt, am Nordende der Insel. Die Gnolle der Moderfelle um sie herum tragen den Schlüssel.",
	-- {item:267412} Fenris Isle Key
	["{item:267412}, from the Rot Hide gnolls"] = "{item:267412}, von den Gnollen der Moderfelle",

	-- Step 5: Free Lumina Windsinger
	-- {npc:248755} Lumina Windsinger
	["Free {npc:248755}"] = "Befreie {npc:248755}",
	["Free her with the key, then stay close while she fights her way out of the keep."] = "Befreie sie mit dem Schlüssel und bleib dann in ihrer Nähe, während sie sich aus der Burg kämpft.",

	-- Step 6: Back to the The Sepulcher
	-- {area:228} The Sepulcher
	["Back to the {area:228}"] = "Zurück zum {area:228}",
	-- {area:235} Fenris Keep · {npc:259620} Lumina Windsinger · {area:228} The Sepulcher
	["Once she is clear of {area:235}, {npc:259620} waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Sobald sie aus {area:235} heraus ist, wartet {npc:259620} im {area:228} auf dich. Sprich erneut mit ihr, um zu erfahren, was auf der Straße wirklich geschah.",
	-- {npc:259620} Lumina Windsinger · {area:228} The Sepulcher
	["{npc:259620}, the {area:228}"] = "{npc:259620}, das {area:228}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:228}"] = "Zurück zum Ort {area:228}",
	-- ["Once she is clear of {area:235}, Lumina waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Sobald sie aus {area:235} heraus ist, wartet Lumina im Ort {area:228} auf dich. Sprich erneut mit ihr, um zu erfahren, was auf der Straße wirklich geschah.",
	-- ["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "Reite nach Süden durch {zone:1421} zum {area:228}. {npc:248840} steht im Ort; {npc:259611} hält nahe dem Eingang Wache.",
	-- ["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "Die {area:172} liegt im See östlich vom Ort {area:228}. Die verkohlten Überreste sind am Ufer.",
	-- ["{npc:259620}, the {area:228}"] = "{npc:259620}, {area:228}",
}
