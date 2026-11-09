-- German (deDE): the guide forever/class/warlock/voidwalker-horde (forever/class/warlock/voidwalker-horde.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Voidwalker (Horde)"] = "Leerwandler (Horde)",
	["Your tank demon at 10: the voidwalker, after a stolen book and a fight at a summoning circle."] = "Dein Tank-Dämon auf Stufe 10: der Leerwandler, nach einem gestohlenen Buch und einem Kampf an einem Beschwörungskreis.",

	-- Step 1: Gan'rul's Summons (Orcs and Trolls)
	-- {quest:1506} Gan'rul's Summons
	["{quest:1506} (Orcs and Trolls)"] = "{quest:1506} (Orcs und Trolle)",
	-- {npc:3294} Ophek · {npc:5875} Gan'rul Bloodeye · {area:362} Razor Hill · {npc:3172} Dhugru Gorelust · {object:172960} Cleft of Shadow · {zone:1454} Orgrimmar · {object:172982} Valley of Strength · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {npc:5724} Ageron Kargal · {area:159} Brill
	["At 10 {npc:3294} sends you to {npc:5875}. He stands outside at the back of {area:362}'s barracks, the big building on the east side of town (not the inn), a few steps from {npc:3172}, the warlock trainer. {npc:5875} stands with the senior warlocks in the {object:172960}, the cavern under {zone:1454}'s {object:172982}. An Orc or Troll leveling in {zone:1420} can take the {zone:1458} version from {npc:5724} in {area:159} instead (the {zone:1458} steps below): you can do only one of the two."] = "Mit Stufe 10 schickt dich {npc:3294} zu {npc:5875}. Er steht draußen hinten an der Kaserne von {area:362}, dem großen Gebäude an der Ostseite der Stadt (nicht das Gasthaus), ein paar Schritte von {npc:3172}, dem Hexenmeisterlehrer. {npc:5875} steht bei den älteren Hexenmeistern in {object:172960}, der Höhle unter {object:172982} von {zone:1454}. Ein Orc oder Troll, der in {zone:1420} levelt, kann stattdessen die Version von {zone:1458} bei {npc:5724} in {area:159} nehmen (die Schritte zu {zone:1458} weiter unten): Du kannst nur eine der beiden machen.",

	-- Step 2: Skull Rock
	-- {area:817} Skull Rock · {zone:1454} Orgrimmar · {object:58595} Burning Blade Stash · {npc:3204} Gazz'uz
	-- plural, as words: Burning Blade Apprentices = {npc:3198} Burning Blade Apprentice
	["{area:817} is the cave in the cliffs just east of {zone:1454}'s gate. Inside, take the right-hand ramp up and follow it to the top: the {object:58595} sits on that upper ledge, which cannot be reached from the lower floor. The cave is packed with Burning Blade Apprentices and Fanatics (level 9-11, many with voidwalkers) that respawn quickly, and {npc:3204}, a level 14 Burning Blade warlock, stands near the stash. Old notes call him elite; Forever's data lists him as normal. At 10 it is hard alone: pull one pack at a time and Fear the extra, wait for 11, or go with a friend. The stash always holds the tablet."] = "{area:817} ist die Höhle in den Klippen direkt östlich des Tors von {zone:1454}. Nimm drinnen die rechte Rampe nach oben und folge ihr bis zum Ende: {object:58595} liegt auf dem oberen Felsvorsprung, der vom unteren Boden aus nicht erreichbar ist. Die Höhle ist voll von Burning Blade Apprentices und Fanatics (Stufe 9-11, viele mit Leerwandlern), die schnell respawnen, und {npc:3204}, ein Burning-Blade-Hexenmeister der Stufe 14, steht nahe dem Versteck. Alte Notizen nennen ihn Elite; die Daten von Forever führen ihn als normal. Mit 10 ist es allein schwer: Pull ein Pack nach dem anderen und schick den überzähligen in Furcht, warte bis Stufe 11 oder geh mit einem Freund. Im Versteck liegt immer die Tafel.",
	-- {item:6535} Tablet of Verga · {object:58595} Burning Blade Stash
	["{item:6535}, in the {object:58595}"] = "{item:6535}, in {object:58595}",

	-- Step 3: The Binding (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {item:7464} Glyphs of Summoning · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:5875}. He hands you the {item:7464}: take them across the {object:172960} to {npc:3216}'s tent, stand on the purple circle on its floor and use them. The voidwalker (level 10, not elite) hits hard at 30% health and leaves after three minutes, so start at once: {spell:14868}, Corruption and {spell:348}, send your imp in, and Fear it when you need a breather. If it beats you or leaves, the glyphs are not used up: use them again on the circle. Keep the glyphs: {npc:5875} takes them back."] = "Zurück zu {npc:5875}. Er gibt dir {item:7464}: Bring sie über {object:172960} zum Zelt von {npc:3216}, stell dich auf den violetten Kreis auf seinem Boden und benutze sie. Der Leerwandler (Stufe 10, kein Elite) schlägt bei 30 % Gesundheit hart zu und verschwindet nach drei Minuten, fang also sofort an: {spell:14868}, Verderbnis und {spell:348}, schick deinen Wichtel hinein und schick den Leerwandler in Furcht, wenn du eine Verschnaufpause brauchst. Besiegt er dich oder verschwindet er, sind die Glyphen nicht verbraucht: Benutze sie erneut auf dem Kreis. Behalte die Glyphen: {npc:5875} nimmt sie zurück.",
	-- {item:7464} Glyphs of Summoning
	["{item:7464}, on the circle in Neeru's tent"] = "{item:7464}, auf dem Kreis in Neerus Zelt",

	-- Step 4: Halgar's Summons (Undercity)
	-- {npc:5724} Ageron Kargal · {area:2119} Gallows' End Tavern · {area:159} Brill · {npc:5675} Carendin Halgar · {zone:1420} Tirisfal Glades · {npc:5875} Gan'rul Bloodeye · {zone:1458} Undercity · {object:36082} Magic Quarter
	["At 10 {npc:5724}, upstairs in the {area:2119} in {area:159}, sends you to {npc:5675}: the version for the Undead, and for Orcs and Trolls who level in {zone:1420} instead of taking {npc:5875}'s. {npc:5675} stands in the {zone:1458}'s {object:36082}, by the Temple of the Damned."] = "Mit Stufe 10 schickt dich {npc:5724}, im Obergeschoss von {area:2119} in {area:159}, zu {npc:5675}: die Version für die Untoten und für Orcs und Trolle, die stattdessen in {zone:1420} leveln und nicht {npc:5875} nehmen. {npc:5675} steht im {object:36082} von {zone:1458}, beim Temple of the Damned.",
	-- {npc:5724} Ageron Kargal · {area:159} Brill
	["{npc:5724}, upstairs in the {area:159} inn"] = "{npc:5724}, im Obergeschoss des Gasthauses von {area:159}",

	-- Step 5: Perrine's Chest
	-- {zone:1458} Undercity · {area:154} Deathknell · {npc:1662} Captain Perrine · {npc:1537} Scarlet Zealot
	["The Scarlet tower stands in the fields west of the {zone:1458}'s ruins (not the tower near {area:154}). The grimoire is in the small chest on the ground floor, under the stairs; ignore the chest upstairs. {npc:1662} (level 9) and a {npc:1537} guard it: kill them, or Fear the zealot while you deal with Perrine. Scarlet Missionaries and Zealots (level 7-9) walk the fields around the tower. The chest is back three seconds after anyone opens it."] = "Der Scharlachrote Turm steht in den Feldern westlich der Ruinen von {zone:1458} (nicht der Turm bei {area:154}). Das Grimoire liegt in der kleinen Truhe im Erdgeschoss, unter der Treppe; ignoriere die Truhe oben. {npc:1662} (Stufe 9) und ein {npc:1537} bewachen sie: Töte sie oder schick den Eiferer in Furcht, während du dich um Perrine kümmerst. Scarlet Missionaries und Zealots (Stufe 7-9) laufen in den Feldern um den Turm. Die Truhe ist drei Sekunden, nachdem jemand sie geöffnet hat, wieder da.",
	-- {item:6285} Egalin's Grimoire · {object:37098} Perrine's Chest
	["{item:6285}, in {object:37098}"] = "{item:6285}, in {object:37098}",

	-- Step 6: The Binding (Undercity)
	-- {npc:5675} Carendin Halgar · {item:6284} Runes of Summoning · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:5675}. He hands you the {item:6284}: go down the stairs from him to the summoning circle and use them while standing on it. Fight the voidwalker (level 10, not elite) on the circle: if it wanders off, the city guards may kill it and the kill does not count. {spell:14868}, Corruption and {spell:348} with your imp tanking bring it down; it hits harder below 30%. If you lose, use the runes again. Keep the runes: {npc:5675} takes them back."] = "Zurück zu {npc:5675}. Er gibt dir {item:6284}: Geh die Treppe von ihm aus hinunter zum Beschwörungskreis und benutze sie, während du darauf stehst. Bekämpfe den Leerwandler (Stufe 10, kein Elite) auf dem Kreis: Wenn er davonwandert, töten ihn vielleicht die Stadtwachen und der Kill zählt nicht. {spell:14868}, Verderbnis und {spell:348} mit deinem tankenden Wichtel erledigen ihn; unter 30 % schlägt er härter zu. Verlierst du, benutze die Runen erneut. Behalte die Runen: {npc:5675} nimmt sie zurück.",
	-- {item:6284} Runes of Summoning · {npc:5675} Carendin Halgar
	["{item:6284}, on the circle below {npc:5675}"] = "{item:6284}, auf dem Kreis unter {npc:5675}",
}
