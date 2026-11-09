-- German (deDE): the guide forever/class/paladin/holy-mightstone (forever/class/paladin/holy-mightstone.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A one-use stone that makes you much stronger against undead for 10 minutes; the old item choice may be gone in Forever."] = "Ein Einmalstein, der dich 10 Minuten lang viel stärker gegen Untote macht; die alte Gegenstandsauswahl gibt es auf Forever womöglich nicht mehr.",

	-- Step 1: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge
	["At 50 {npc:928}, the paladin trainer in the Cathedral of Light, sends you to {area:3197} in the {zone:1422}. {npc:5149} in {zone:1455} gives the same quest."] = "Mit Stufe 50 schickt dich {npc:928}, der Paladinlehrer in der Kathedrale des Lichts, zum {area:3197} in den {zone:1422}. {npc:5149} in {zone:1455} gibt dieselbe Quest.",

	-- Step 2: Brandur Ironhammer
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward (no name in this language: may be words) · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {npc:928} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 50 {npc:5149}, the paladin trainer in the {object:32362}, sends you to {area:3197} in the {zone:1422}. {npc:928} in {zone:1453} gives the same quest."] = "Mit Stufe 50 schickt dich {npc:5149}, der Paladinlehrer im {object:32362}, zum {area:3197} in den {zone:1422}. {npc:928} in {zone:1453} gibt dieselbe Quest.",

	-- Step 3: Chillwind Camp
	-- {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {npc:10838} Commander Ashlam Valorfist · {npc:10840} Argent Officer Pureheart
	["{area:3197} is the Alliance camp at the south end of the {zone:1422}, north of the Alterac foothills. {npc:10838} commands it; {npc:10840} stands in the same camp."] = "{area:3197} ist das Allianzlager am Südende der {zone:1422}, nördlich der Ausläufer von Alterac. {npc:10838} befehligt es; {npc:10840} steht im selben Lager.",

	-- Step 4: The Argent Dawn Commission
	-- {quest:5401} Argent Dawn Commission
	["The {quest:5401}"] = "{quest:5401}",
	-- {quest:5401} Argent Dawn Commission · {npc:10840} Argent Officer Pureheart · {area:2268} Light's Hope Chapel
	["The Scourge drop no Scourgestones unless you wear an {quest:5401}. {npc:10840} gives you one through her quest, {quest:5401}, which you hand in straight away (if you already have one from {area:2268}, wear that). Equip it in a trinket slot: it shows as a buff that never runs out. Keep it on until you have 20 stones."] = "Die Geißel lässt keine Geißelsteine fallen, wenn du keine {quest:5401} trägst. {npc:10840} gibt dir eine durch ihre Quest, {quest:5401}, die du sofort abgibst (hast du schon eine aus {area:2268}, trag diese). Leg sie in einen Schmuckplatz an: Sie erscheint als Buff, der nie ausläuft. Behalte sie an, bis du 20 Steine hast.",
	-- {quest:5401} Argent Dawn Commission
	["the {quest:5401} trinket: equip it"] = "das {quest:5401}-Schmuckstück: anlegen",

	-- Step 5: Minion's Scourgestones
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones"] = "Geißelsteine des Dieners",
	-- {zone:1422} Western Plaguelands · {item:12840} Minion's Scourgestone · {area:197} Sorrow Hill · {area:3197} Chillwind Camp · {area:196} Uther's Tomb · {spell:120} Cone of Cold · {spell:1449} Arcane Explosion
	-- plural, as words: Flesh Golems = {npc:1805} Flesh Golem · Skeletal Guardians = {npc:10390} Skeletal Guardian · Dark Summoners = {npc:8551} Dark Summoner
	["Kill the Scourge of the {zone:1422} with the Commission on: skeletons, ghouls and cultists (level 50-58) drop a {item:12840} about two kills in five. {area:197}, just east of {area:3197} around {area:196}, is the closest farm. Avoid the Flesh Golems that patrol the fields; Skeletal Guardians cast {spell:120} and {spell:1449} up close, Dark Summoners run for help at low health."] = "Töte die Geißel der {zone:1422} mit angelegter Kommission: Skelette, Ghule und Kultisten (Stufe 50-58) lassen in etwa zwei von fünf Fällen {item:12840} fallen. {area:197}, direkt östlich von {area:3197} um {area:196}, ist die nächste Farmstelle. Meide die Flesh Golems, die über die Felder patrouillieren; Skeletal Guardians wirken {spell:120} und {spell:1449} aus der Nähe, Dark Summoners holen bei niedriger Gesundheit Hilfe.",
	-- {item:12840} Minion's Scourgestone
	["{item:12840} x20"] = "{item:12840} x20",

	-- Step 6: High Priest Thel'danis
	-- {npc:1854} High Priest Thel'danis · {area:196} Uther's Tomb · {area:197} Sorrow Hill · {item:20612} Inert Scourgestone
	["{npc:1854} keeps watch at {area:196} on {area:197}, east of the camp. He turns your 20 stones into one {item:20612}: keep it."] = "{npc:1854} hält Wache bei {area:196} auf {area:197}, östlich des Lagers. Er macht aus deinen 20 Steinen einen {item:20612}: Behalte ihn.",

	-- Step 7: Commander Ashlam Valorfist
	-- {area:3197} Chillwind Camp · {area:1417} Sunken Temple
	["Back to {area:3197}. Ashlam needs the voodoo of the {area:1417}'s trolls for the stone."] = "Zurück zum {area:3197}. Ashlam braucht das Voodoo der Trolle des {area:1417} für den Stein.",

	-- Step 8: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1477} The Temple of Atal'Hakkar · {area:1417} Sunken Temple · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:5716} Zul'Lor
	-- plural, as words: Shadow Bolt Volleys = {spell:9081} Shadow Bolt Volley
	["{area:1477}, the {area:1417}, lies in the {area:74} in eastern {zone:1435}: go up the ruin's stairs, dive into the flooded hall and follow the stairs down to the portal. It is a dungeon for a group of five at about 50-55. Six elite troll minibosses (level 51-52) stand on the balconies around the temple's great round room, each behind a pack of elites on its side path. Each drops its feather every time: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green; you need all six. Hukku calls guardians and throws Shadow Bolt Volleys, Mijan heals: kill them first."] = "{area:1477}, der {area:1417}, liegt in {area:74} im Osten von {zone:1435}: Geh die Treppen der Ruine hinauf, tauch in die geflutete Halle und folge den Treppen nach unten zum Portal. Es ist ein Dungeon für eine Gruppe aus fünf mit etwa Stufe 50-55. Sechs Troll-Zwischenbosse (Elite, Stufe 51-52) stehen auf den Balkonen um den großen runden Raum des Tempels, jeder hinter einem Rudel Elite auf seinem Seitenpfad. Jeder lässt jedes Mal seine Feder fallen: Gasher und {npc:5716} (Bernstein), Hukku und Mijan (Blau), Zolo und Loro (Grün); du brauchst alle sechs. Hukku ruft Wächter und wirft Schattenblitzsalven, Mijan heilt: Töte sie zuerst.",
	-- {item:20606} Amber Voodoo Feather · {npc:5716} Zul'Lor
	["{item:20606} x2: Gasher, {npc:5716}"] = "{item:20606} x2: Gasher, {npc:5716}",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607} x2: Hukku, Mijan"] = "{item:20607} x2: Hukku, Mijan",
	-- {item:20608} Green Voodoo Feather
	["{item:20608} x2: Zolo, Loro"] = "{item:20608} x2: Zolo, Loro",

	-- Step 9: Forging the Mightstone
	-- {area:3197} Chillwind Camp · {item:20620} Holy Mightstone · {item:20505} Chivalrous Signet · {item:20504} Lightforged Blade · {item:20512} Sanctified Orb · {area:2279} Stratholme · {area:2057} Scholomance
	["Back to Ashlam in {area:3197}: he forges the {item:20620}. Look at the reward window before you hand in: Classic also offered the {item:20505}, the {item:20504} or the {item:20512}, and Forever's notes say that choice may be gone. Use the stone before a fight against undead ({area:2279}, {area:2057}): it lasts ten minutes and is gone after one use."] = "Zurück zu Ashlam im {area:3197}: Er schmiedet {item:20620}. Sieh dir das Belohnungsfenster an, bevor du abgibst: Classic bot außerdem {item:20505}, {item:20504} oder {item:20512}, und die Hinweise von Forever sagen, dass diese Auswahl entfallen könnte. Benutze den Stein vor einem Kampf gegen Untote ({area:2279}, {area:2057}): Er hält zehn Minuten und ist nach einem Einsatz weg.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A one-use stone that makes you much stronger against undead for 10 minutes; the old choice rewards are gone."] = "Ein Stein zum einmaligen Gebrauch, der dich 10 Minuten lang viel stärker gegen Untote macht; die alten Belohnungen zur Auswahl gibt es nicht mehr.",
	-- ["The Scourge throughout the {zone:1422} drop Minion's Scourgestones."] = "Die Geißel überall in {zone:1422} lässt Geißelsteine des Dieners fallen.",
	-- ["{area:1477} lies in the {area:74} in eastern {zone:1435}. Inside, Gasher and {npc:5716} drop the {item:20606}, Hukku and Mijan the Blue, Zolo and Loro the Green."] = "{area:1477} liegt in {area:74} im Osten von {zone:1435}. Drinnen lassen Schlitzer und {npc:5716} {item:20606} fallen, Hukku und Mijan die blaue, Zolo und Loro die grüne.",
	-- ["{item:20606}, inside"] = "{item:20606}, drinnen",
	-- ["{item:20607}, inside"] = "{item:20607}, drinnen",
	-- ["{item:20608}, inside"] = "{item:20608}, drinnen",
	-- ["{npc:10838} commands {area:3197} in the south of the {zone:1422}."] = "{npc:10838} befehligt {area:3197} im Süden von {zone:1422}.",
	-- ["{npc:5149} is in the {object:32362}."] = "{npc:5149} ist in {object:32362}.",
	-- ["{npc:928} is in the Cathedral of Light."] = "{npc:928} ist in der Kathedrale des Lichts.",
}
