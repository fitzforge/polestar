-- German (deDE): the guide forever/class/warlock/enchanted-gold-bloodrobe (forever/class/warlock/enchanted-gold-bloodrobe.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6266} Menara Voidrender
	["A rare cloth robe for your 30s, which {npc:6266} makes from the parts you bring her."] = "Eine seltene Stoffrobe für deine 30er, die {npc:6266} aus den Teilen fertigt, die du ihr bringst.",

	-- Step 1: In Search of Menara Voidrender (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "Auf Stufe 31 schickt dich {npc:461} im {object:2164} im {object:2101} zu {npc:6266} in {area:392}.",

	-- Step 2: In Search of Menara Voidrender (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "Auf Stufe 31 schickt dich {npc:5172} in {zone:1455} zu {npc:6266} in {area:392}.",

	-- Step 3: In Search of Menara Voidrender (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "Auf Stufe 31 schickt dich {npc:3326} in der {object:172960} zu {npc:6266} in {area:392}.",

	-- Step 4: In Search of Menara Voidrender (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "Auf Stufe 31 schickt dich {npc:4563} im {object:36082} zu {npc:6266} in {area:392}. Der Zeppelin von {zone:1420} fliegt nach {zone:1411}.",

	-- Step 5: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["{npc:6266} stands in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266} steht im Turm auf dem Hügel über {area:392}, neben {npc:6251}.",

	-- Step 6: Robes of Arcana
	-- {npc:6266} Menara Voidrender · {item:5770} Robes of Arcana · {item:3577} Gold Bar · {item:2776} Gold Ore
	["Bring {npc:6266} a {item:5770}: tailors sew it from a pattern that drops; otherwise buy one at the Auction House. Her next errand needs a {item:3577}: smelted from {item:2776}, or from the Auction House."] = "Bring {npc:6266} eine {item:5770}: Schneider nähen sie nach einem Muster, das als Beute fällt; sonst kauf eine im Auktionshaus. Ihr nächster Auftrag braucht einen {item:3577}: geschmolzen aus {item:2776} oder aus dem Auktionshaus.",

	-- Step 7: Xizk Goodstitch
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay · {item:3577} Gold Bar
	["{npc:2670} sells tailoring supplies in {area:35}. Bring him the {item:3577}."] = "{npc:2670} verkauft Schneiderbedarf in {area:35}. Bring ihm den {item:3577}.",

	-- Step 8: Back to Menara Voidrender
	-- {npc:6266} Menara Voidrender
	["Back to {npc:6266}"] = "Zurück zu {npc:6266}",

	-- Step 9: Desolace demons
	-- {zone:1443} Desolace
	["{zone:1443} demons"] = "Dämonen in {zone:1443}",
	-- {area:603} Sargeron · {zone:1443} Desolace
	-- plural, as words: Lesser Infernals = {npc:4676} Lesser Infernal
	["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of Mannoroc Coven, in the south, the stone."] = "Die Satyrn der Zornsäer von {area:603} im Nordosten von {zone:1443} tragen das Blut; die Geringen Höllenbestien von Mannorocs Koven im Süden den Stein.",
	["Vials of Hatefury Blood"] = "Phiolen mit Zornsäerblut",

	-- Step 10: Menara Voidrender again
	-- {npc:6266} Menara Voidrender
	["{npc:6266} again"] = "Wieder zu {npc:6266}",

	-- Step 11: Fine Gold Thread
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay
	["{npc:2670} in {area:35} has the thread for you."] = "{npc:2670} in {area:35} hat den Faden für dich.",

	-- Step 12: Smoldering Coal
	-- {zone:1417} Arathi Highlands
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["The Burning Exiles, fire elementals in western {zone:1417}, drop the coal."] = "Die Brennenden Verbannten, Feuerelementare im westlichen {zone:1417}, lassen die Kohle fallen.",

	-- Step 13: The Completed Robe
	-- {npc:6266} Menara Voidrender · {item:6265} Soul Shard
	["Back to {npc:6266} with the thread, the coal and a {item:6265}. Wait while she completes the robe, then speak to her again."] = "Zurück zu {npc:6266} mit dem Faden, der Kohle und einem {item:6265}. Warte, während sie die Robe fertigstellt, und sprich sie dann erneut an.",
	["Wait for the robe"] = "Auf die Robe warten",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of {area:602}, in the south, the stone."] = "Die Zornsäer-Satyrn von {area:603} im Nordosten von {zone:1443} tragen das Blut; die Geringen Höllenbestien vom {area:602} im Süden den Stein.",
}
