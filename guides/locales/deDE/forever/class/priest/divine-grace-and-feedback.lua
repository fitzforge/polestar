-- German (deDE): the guide forever/class/priest/divine-grace-and-feedback (forever/class/priest/divine-grace-and-feedback.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["{quest:94773} and {spell:13896}"] = "{quest:94773} und {spell:13896}",
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["The Human priest spells: {quest:94773} at 10 (new in Forever), {spell:13896} at 20. Free, no objectives."] = "Die Priesterzauber der Menschen: {quest:94773} mit 10 (neu in Forever), {spell:13896} mit 20. Kostenlos, keine Ziele.",

	-- Step 1: Divine Grace: Priestess Josetta
	-- {npc:377} Priestess Josetta · {area:87} Goldshire · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["At 10, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you a letter for {npc:376}. {area:87} is on the road north to {zone:1453}, so it costs no detour."] = "Mit 10 gibt dir {npc:377}, oben im Lion's Pride Inn in {area:87}, einen Brief für {npc:376}. {area:87} liegt an der Straße nach Norden zu {zone:1453}, also kostet es keinen Umweg.",
	-- {npc:377} Priestess Josetta · {quest:94773} Divine Grace
	["{npc:377}: take her {quest:94773} letter"] = "{npc:377}: Nimm ihren Brief {quest:94773} an",

	-- Step 2: Divine Grace: Laurna Morninglight
	-- {zone:1438} Teldrassil · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["A Human priest in {zone:1438} at 10: {npc:3600}, in the building at the north edge of {area:186}, hands you a letter for {npc:376} in {zone:1453}."] = "Ein menschlicher Priester in {zone:1438} mit 10: {npc:3600}, im Gebäude am Nordrand von {area:186}, gibt dir einen Brief für {npc:376} in {zone:1453}.",
	-- {npc:3600} Laurna Morninglight · {quest:94773} Divine Grace
	["{npc:3600}: take her {quest:94773} letter"] = "{npc:3600}: Nimm ihren Brief {quest:94773} an",

	-- Step 3: Divine Grace: High Priestess Laurena
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {object:2098} Cathedral Square · {quest:94773} Divine Grace · {spell:6788} Weakened Soul
	["At 10, go to {npc:376} at the altar of the Cathedral of Light, in {zone:1453}'s {object:2098}, and take her quest: she teaches {quest:94773} on the spot. No letter needed; one from another trainer works too (next steps). {quest:94773} instantly heals a friend below half health and clears {spell:6788}, so you can shield them again (5-minute cooldown); it does not work on yourself. Human priests do not get Desperate Prayer in Forever: this is their spell instead."] = "Geh mit 10 zu {npc:376} am Altar der Kathedrale des Lichts, in {object:2098} von {zone:1453}, und nimm ihre Quest an: Sie bringt dir {quest:94773} auf der Stelle bei. Kein Brief nötig; einer von einem anderen Lehrer funktioniert auch (nächste Schritte). {quest:94773} heilt einen Freund unter der Hälfte seines Lebens sofort und entfernt {spell:6788}, sodass du ihn erneut abschirmen kannst (5 Minuten Abklingzeit); auf dich selbst wirkt es nicht. Menschliche Priester bekommen in Forever kein Verzweifeltes Gebet: Das ist stattdessen ihr Zauber.",

	-- Step 4: Divine Grace: Josetta's letter
	-- {quest:94774} Divine Grace
	["{quest:94774}: Josetta's letter"] = "{quest:94774}: Josettas Brief",
	-- {npc:376} High Priestess Laurena · {quest:94774} Divine Grace
	["Hand Josetta's letter to {npc:376} at the altar of the Cathedral of Light: she teaches {quest:94774}."] = "Gib Josettas Brief bei {npc:376} am Altar der Kathedrale des Lichts ab: Sie bringt dir {quest:94774} bei.",

	-- Step 5: Divine Grace: Laurna Morninglight's letter
	-- {quest:94775} Divine Grace · {npc:3600} Laurna Morninglight
	["{quest:94775}: {npc:3600}'s letter"] = "{quest:94775}: der Brief von {npc:3600}",
	-- {npc:3600} Laurna Morninglight · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {zone:1438} Teldrassil · {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor · {quest:94775} Divine Grace
	["Hand {npc:3600}'s letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (from {zone:1438}: the boat from {area:702} to {area:442}, then the boat to {area:17203}): she teaches {quest:94775}."] = "Gib den Brief von {npc:3600} bei {npc:376} am Altar der Kathedrale des Lichts in {zone:1453} ab (von {zone:1438}: das Boot von {area:702} nach {area:442}, dann das Boot nach {area:17203}): Sie bringt dir {quest:94775} bei.",

	-- Step 6: Divine Grace: a letter from another trainer
	-- {quest:94776} Divine Grace
	["{quest:94776}: a letter from another trainer"] = "{quest:94776}: ein Brief eines anderen Lehrers",
	-- {quest:94776} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94776} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Jeder Brief {quest:94776} geht an {npc:376} am Altar der Kathedrale des Lichts.",

	-- Step 7: Divine Grace: a letter from another trainer
	-- {quest:94777} Divine Grace
	["{quest:94777}: a letter from another trainer"] = "{quest:94777}: ein Brief eines anderen Lehrers",
	-- {quest:94777} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94777} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Jeder Brief {quest:94777} geht an {npc:376} am Altar der Kathedrale des Lichts.",

	-- Step 8: Divine Grace: a letter from another trainer
	-- {quest:94778} Divine Grace
	["{quest:94778}: a letter from another trainer"] = "{quest:94778}: ein Brief eines anderen Lehrers",
	-- {quest:94778} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94778} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Jeder Brief {quest:94778} geht an {npc:376} am Altar der Kathedrale des Lichts.",

	-- Step 9: Divine Grace: a letter from another trainer
	-- {quest:94779} Divine Grace
	["{quest:94779}: a letter from another trainer"] = "{quest:94779}: ein Brief eines anderen Lehrers",
	-- {quest:94779} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94779} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Jeder Brief {quest:94779} geht an {npc:376} am Altar der Kathedrale des Lichts.",

	-- Step 10: Feedback: High Priest Rohan
	-- {zone:1455} Ironforge · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town
	["At 20 in {zone:1455}, {npc:11406} in the {object:32386} ({object:32362}) hands you a letter for {npc:376} in {zone:1453}. The {area:2257} from {object:171524} takes you there."] = "Mit 20 gibt dir in {zone:1455} {npc:11406} im {object:32386} ({object:32362}) einen Brief für {npc:376} in {zone:1453}. {area:2257} von {object:171524} bringt dich dorthin.",
	-- {npc:11406} High Priest Rohan · {quest:5676} Arcane Feedback
	["{npc:11406}: take his {quest:5676} letter"] = "{npc:11406}: Nimm seinen Brief {quest:5676} an",

	-- Step 11: Feedback: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["At 20 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a letter for {npc:376} in {zone:1453}."] = "Mit 20 gibt dir in {zone:1457} {npc:11401}, auf dem oberen Balkon des Tempels des Mondes neben {npc:7999}, einen Brief für {npc:376} in {zone:1453}.",
	-- {npc:11401} Priestess Alathea · {quest:5676} Arcane Feedback
	["{npc:11401}: take her {quest:5676} letter"] = "{npc:11401}: Nimm ihren Brief {quest:5676} an",

	-- Step 12: Feedback: High Priestess Laurena
	-- {npc:376} High Priestess Laurena · {spell:13896} Feedback
	["At 20, {npc:376} at the altar of the Cathedral of Light teaches {spell:13896} with a quest she gives and takes back at once."] = "Mit 20 bringt dir {npc:376} am Altar der Kathedrale des Lichts {spell:13896} mit einer Quest bei, die sie dir gibt und sofort zurücknimmt.",

	-- Step 13: Feedback: Rohan's letter
	-- {spell:13896} Feedback
	["{spell:13896}: Rohan's letter"] = "{spell:13896}: Rohans Brief",
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1455} Ironforge · {spell:13896} Feedback
	["Hand Rohan's letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (the {area:2257} from {object:171524} in {zone:1455}): she teaches {spell:13896}."] = "Gib Rohans Brief bei {npc:376} am Altar der Kathedrale des Lichts in {zone:1453} ab ({area:2257} von {object:171524} in {zone:1455}): Sie bringt dir {spell:13896} bei.",

	-- Step 14: Feedback: Alathea's letter
	-- {spell:13896} Feedback
	["{spell:13896}: Alathea's letter"] = "{spell:13896}: Alatheas Brief",
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor · {spell:13896} Feedback
	["Hand Alathea's letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (from {zone:1457}: the portal down to {area:702}, the boat to {area:442}, then the boat to {area:17203}): she teaches {spell:13896}."] = "Gib Alatheas Brief bei {npc:376} am Altar der Kathedrale des Lichts in {zone:1453} ab (von {zone:1457}: das Portal hinunter nach {area:702}, das Boot nach {area:442}, dann das Boot nach {area:17203}): Sie bringt dir {spell:13896} bei.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:376} in the Cathedral of Light. {npc:377} in {area:87} sends you to her with a quest of the same name."] = "Geh mit 10 zu {npc:376} in der Kathedrale des Lichts. {npc:377} in {area:87} schickt dich mit einer gleichnamigen Quest zu ihr.",
	-- ["At 20, {npc:376} teaches {spell:13896}. {npc:11406} in {zone:1455} and {npc:11401} in {zone:1457} send you to her with a quest of the same name."] = "Mit 20 lehrt dich {npc:376} {spell:13896}. {npc:11406} in {zone:1455} und {npc:11401} in {zone:1457} schicken dich mit einer gleichnamigen Quest zu ihr.",
	-- ["The Human priest spells: {quest:94773} at 10, {spell:13896} at 20."] = "Die Priesterzauber der Menschen: {quest:94773} mit 10, {spell:13896} mit 20.",
}
