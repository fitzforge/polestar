-- German (deDE): the guide forever/class/shaman/spirit-totem (forever/class/shaman/spirit-totem.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:8412} Spirit Totem · {quest:8413} Da Voodoo
	["{quest:8412} and {quest:8413}"] = "{quest:8412} und {quest:8413}",
	-- {area:1417} Sunken Temple
	["Experience and gold at 50, ending in the {area:1417}; Forever removed the Classic item choice."] = "Erfahrung und Gold mit 50, mit Abschluss in {area:1417}; Forever hat die Gegenstandsauswahl aus Classic entfernt.",
	["Experience and gold"] = "Erfahrung und Gold",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom · {npc:6176} Bath'rah the Windwatcher
	["At 50 {npc:13417}, the shaman trainer in the {object:172957}, sends you to {npc:6176}."] = "Mit 50 schickt dich {npc:13417}, der Schamanenlehrer in {object:172957}, zu {npc:6176}.",

	-- Step 2: Beram Skychaser
	-- {npc:3032} Beram Skychaser · {zone:1456} Thunder Bluff · {npc:6176} Bath'rah the Windwatcher
	["At 50 {npc:3032}, a shaman trainer in {zone:1456}, sends you to {npc:6176}."] = "Mit 50 schickt dich {npc:3032}, ein Schamanenlehrer in {zone:1456}, zu {npc:6176}.",

	-- Step 3: The four elements
	["The four elements"] = "Die vier Elemente",
	-- {item:7069} Elemental Air
	["One each of {item:7069}, Fire, Earth and Water. The Exiles of Arathi Highlands drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "Je eins von {item:7069}, Elementarfeuer, Elementarerde und Elementarwasser. Die Verbannten im Arathihochland lassen sie fallen, je ein Element pro Art, etwa bei jedem zehnten Kill: Donnernde (Luft), Brennende (Feuer), Rumpelnde (Erde) und Schäumende (Wasser). Oder kauf sie im Auktionshaus.",
	-- {item:7069} Elemental Air
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:7069}: Thundering Exiles"] = "{item:7069}: Donnernde Verbannte",
	-- {item:7068} Elemental Fire
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:7068}: Burning Exiles"] = "{item:7068}: Brennende Verbannte",
	-- {item:7067} Elemental Earth
	-- plural, as words: Rumbling Exiles = {npc:2592} Rumbling Exile
	["{item:7067}: Rumbling Exiles"] = "{item:7067}: Rumpelnde Verbannte",
	-- {item:7070} Elemental Water
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{item:7070}: Cresting Exiles"] = "{item:7070}: Schäumende Verbannte",

	-- Step 4: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill
	["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176} lagert im Osten von {zone:1416}, nordöstlich von {area:272}.",

	-- Step 5: Spider eye and bear claw
	["Spider eye and bear claw"] = "Spinnenauge und Bärenklaue",
	-- {zone:1422} Western Plaguelands · {item:20610} Bloodshot Spider Eye · {item:20611} Thick Black Claw
	-- plural, as words: Venom Mist Lurkers = {npc:1822} Venom Mist Lurker · Diseased Black Bears = {npc:1815} Diseased Black Bear
	["In the {zone:1422}, the Venom Mist Lurkers drop the {item:20610} and the Diseased Black Bears the {item:20611} (about one kill in five each)."] = "In {zone:1422} lassen die Giftnebellauerer {item:20610} und die Kranken Schwarzbären {item:20611} fallen (jeweils etwa bei jedem fünften Kill).",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1417} Sunken Temple · {area:1477} Temple of Atal'Hakkar · {area:74} Pool of Tears · {npc:5716} Zul'Lor · {item:20606} Amber Voodoo Feather
	["The {area:1417} ({area:1477}) lies under the {area:74}; the arrow points at its entrance. Gasher or {npc:5716} drop the {item:20606}, Hukku or Mijan the Blue, Zolo or Loro the Green: all six are elite trolls inside. Bring a group."] = "{area:1417} ({area:1477}) liegt unter {area:74}; der Pfeil zeigt auf den Eingang. Schlitzer oder {npc:5716} lassen {item:20606} fallen, Hukku oder Mijan die blaue, Zolo oder Loro die grüne: Alle sechs sind Elitetrolle drinnen. Nimm eine Gruppe mit.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["One each of {item:7069}, Fire, Earth and Water. The Exiles of {zone:1417} drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "Je eins von {item:7069}, Elementarfeuer, Elementarerde und Elementarwasser. Die Verbannten in {zone:1417} lassen sie fallen, je ein Element pro Art, etwa bei jedem zehnten Kill: Donnernde (Luft), Brennende (Feuer), Rumpelnde (Erde) und Schäumende (Wasser). Oder kauf sie im Auktionshaus.",
}
