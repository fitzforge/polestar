-- German (deDE): the guide forever/class/priest/blood-of-morphaz (forever/class/priest/blood-of-morphaz.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["17,060 XP and 1g55s at 50: {zone:1447}, then Morphaz in the {area:1417} (group of 5). The item choice may be gone."] = "17.060 EP und 1g55s mit 50: {zone:1447}, dann Morphaz im {area:1417} (Gruppe aus 5). Die Gegenstandswahl könnte entfallen sein.",
	["17,060 experience and 1 gold 55 silver"] = "17.060 Erfahrung und 1 Gold 55 Silber",

	-- Step 1: Cenarion Aid: High Priest Rohan
	-- {zone:1455} Ironforge · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:8254} Cenarion Aid · {item:7972} Ichor of Undeath
	["At 50 in {zone:1455}, {npc:11406} in the {object:32386} ({object:32362}) offers {quest:8254}. Before you leave a city, buy an {item:7972} at the Auction House (a few silver): the third quest asks for one and it drops rarely."] = "Mit 50 bietet dir in {zone:1455} {npc:11406} im {object:32386} ({object:32362}) {quest:8254} an. Kaufe, bevor du eine Stadt verlässt, einen {item:7972} im Auktionshaus (ein paar Silber): Die dritte Quest verlangt einen, und er fällt selten.",

	-- Step 2: Cenarion Aid: Brother Joshua
	-- {npc:5489} Brother Joshua · {zone:1453} Stormwind · {quest:8254} Cenarion Aid · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {item:7972} Ichor of Undeath · {object:2096} Trade District
	["At 50, {npc:5489} at the altar of {zone:1453}'s Cathedral of Light offers {quest:8254} ({npc:11406} in {zone:1455} has it too). Before you leave, buy an {item:7972} at the Auction House in the {object:2096} (a few silver): the third quest asks for one and it drops rarely."] = "Mit 50 bietet dir {npc:5489} am Altar der Kathedrale des Lichts in {zone:1453} {quest:8254} an ({npc:11406} in {zone:1455} hat sie auch). Kaufe, bevor du gehst, einen {item:7972} im Auktionshaus im {object:2096} (ein paar Silber): Die dritte Quest verlangt einen, und er fällt selten.",

	-- Step 3: Cenarion Aid: Ur'kyo
	-- {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits · {quest:8254} Cenarion Aid · {item:7972} Ichor of Undeath
	["At 50, {npc:6018} in {zone:1454}'s {object:172961} offers {quest:8254}. Before you leave, buy an {item:7972} at the Auction House (a few silver): the third quest asks for one and it drops rarely."] = "Mit 50 bietet dir {npc:6018} im {object:172961} von {zone:1454} {quest:8254} an. Kaufe, bevor du gehst, einen {item:7972} im Auktionshaus (ein paar Silber): Die dritte Quest verlangt einen, und er fällt selten.",

	-- Step 4: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405}, a furbolg, lives on the clifftop north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}. Ride east and leave the road at the fork before the ruins, then follow the northern cliff edge east to him: the naga ruins and the beach below are walled in by cliffs with no way up."] = "{npc:8405}, ein Furbolg, lebt auf der Klippe nordöstlich von {area:1221}. Allianz: Flieg nach {area:3137}; Horde: Flieg nach {area:1237}. Reite nach Osten und verlasse die Straße an der Gabelung vor den Ruinen, folge dann dem nördlichen Klippenrand nach Osten bis zu ihm: Die Naga-Ruinen und der Strand darunter sind von Klippen umschlossen, ohne Weg nach oben.",

	-- Step 5: Of Coursers We Know
	-- {zone:1447} Azshara · {npc:8405} Ogtinc · {item:20027} Healthy Courser Gland · {item:7972} Ichor of Undeath
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers (level 52-53, not elite) graze all over {zone:1447}, thickest north-east of {npc:8405} and south of the mountains; about one in three drops a {item:20027}, so plan on a dozen kills for four. They enrage at 30% health: finish them fast. Killing them costs no Cenarion Circle reputation. Keep any {item:7972} you loot."] = "Mosshoof Coursers (Stufe 52-53, nicht Elite) grasen überall in {zone:1447}, am dichtesten nordöstlich von {npc:8405} und südlich der Berge; etwa jeder dritte lässt eine {item:20027} fallen, rechne also mit einem Dutzend Kills für vier. Sie toben bei 30 % Leben: Erledige sie schnell. Sie zu töten kostet keinen Ruf beim Zirkel des Cenarius. Behalte jeden {item:7972}, den du erbeutest.",

	-- Step 7: The Ichor of Undeath
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne · {area:1221} Ruins of Eldarath · {npc:8405} Ogtinc · {zone:1447} Azshara · {zone:1440} Ashenvale · {npc:7523} Suffering Highborne · {zone:1452} Winterspring
	["Carrying an {item:7972} already? It counts at once. Otherwise any undead may drop one, rarely: the {npc:7864} (level 48) in the {area:1221} below {npc:8405}'s cliff drop it about one kill in ten, the highborne ghosts on {zone:1447}'s border with {zone:1440} (level 45-46) a little less, the Anguished and {npc:7523} in {zone:1452} (54-55) about one in eight. The Auction House is usually quicker."] = "Hast du schon einen {item:7972}? Er zählt sofort. Sonst lässt ihn jeder Untote selten fallen: die {npc:7864} (Stufe 48) in {area:1221} unter der Klippe von {npc:8405} etwa bei jedem zehnten Kill, die Geister der Hochgeborenen an der Grenze von {zone:1447} zu {zone:1440} (Stufe 45-46) etwas seltener, die Anguished und {npc:7523} in {zone:1452} (54-55) etwa bei jedem achten. Das Auktionshaus ist meist schneller.",

	-- Step 9: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz im {area:1417}",
	-- {area:1417} Sunken Temple · {area:75} Stonard · {area:1438} Nethergarde Keep · {zone:1419} Blasted Lands · {area:74} Pool of Tears · {npc:5710} Jammal'an the Prophet
	["Morphaz is a level 52 elite green dragon inside the {area:1417}, a five-player dungeon: bring a group of five (a level 60 group clears it with ease). Horde: fly to {area:75}; Alliance: fly to {area:1438} in the {zone:1419} and ride north. The temple stands in the middle of the {area:74}: climb the steps on its south side, swim down through the flooded hall and take the stairs to the portal. Inside, Morphaz only appears late: kill the six troll minibosses on the upper balconies, then {npc:5710} below them; that wakes the drakes Weaver and Dreamscythe in the Pit of Sacrifice, and killing both brings Morphaz and Hazzas. The pair patrols together and cannot be split: pull them into a hallway and have the tank face them away from the group (breath and a knockback). Loot him in a party, not a raid group: the blood always drops."] = "Morphaz ist ein grüner Elite-Drache der Stufe 52 im {area:1417}, einem Dungeon für fünf Spieler: Bring eine Gruppe aus fünf mit (eine Gruppe der Stufe 60 räumt ihn mühelos). Horde: Flieg nach {area:75}; Allianz: Flieg nach {area:1438} im {zone:1419} und reite nach Norden. Der Tempel steht mitten im {area:74}: Steig die Stufen an seiner Südseite hinauf, schwimm durch die überflutete Halle nach unten und nimm die Treppe zum Portal. Drinnen erscheint Morphaz erst spät: Töte die sechs Troll-Minibosse auf den oberen Balkonen, dann {npc:5710} darunter; das weckt die Drachen Weaver und Dreamscythe in der Pit of Sacrifice, und wenn du beide tötest, erscheinen Morphaz und Hazzas. Das Paar patrouilliert zusammen und lässt sich nicht trennen: Zieh sie in einen Gang und lass den Tank sie von der Gruppe weg ausrichten (Atem und Rückstoß). Plündere ihn in einer Gruppe, nicht in einem Schlachtzug: Das Blut fällt immer.",
	-- {quest:8257} Blood of Morphaz · {area:1417} Sunken Temple
	["{quest:8257}: the {area:1417} entrance"] = "{quest:8257}: Eingang zum {area:1417}",

	-- Step 10: Greta Mosshoof
	-- {npc:10922} Greta Mosshoof · {area:2479} Emerald Sanctuary · {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:415} Astranaar · {zone:1440} Ashenvale · {item:19990} Blessed Prayer Beads · {item:20006} Circle of Hope
	["{npc:10922} is at the {area:2479} in southern {zone:1448}. Horde: fly to {area:1997} and ride south-east; Alliance: fly to {area:415} in {zone:1440} and ride north into {zone:1448}. She takes the blood for experience and gold. Look at the reward window before you hand in: Classic let you pick {item:19990}, {item:20006} or Woestave, and Forever's notes say that choice may be gone."] = "{npc:10922} ist im {area:2479} im Süden von {zone:1448}. Horde: Flieg nach {area:1997} und reite nach Südosten; Allianz: Flieg nach {area:415} in {zone:1440} und reite nach Norden in {zone:1448}. Sie nimmt das Blut gegen Erfahrung und Gold. Sieh dir das Belohnungsfenster an, bevor du abgibst: In Classic konntest du {item:19990}, {item:20006} oder Woestave wählen, und Forevers Hinweise besagen, dass diese Wahl entfallen sein könnte.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Already carrying an {item:7972}? It counts as soon as you take this stage. Otherwise any undead can drop it. The {npc:7864} in the {area:1221}, below {npc:8405}'s cliffs, are the nearest; Highborne Apparitions and Lichlings haunt the ruins near {area:3137}."] = "Trägst du schon {item:7972}? Es zählt, sobald du diese Stufe annimmst. Sonst kann es jeder Untote fallen lassen. Die {npc:7864} in den {area:1221} unter den Klippen von {npc:8405} sind am nächsten; Erscheinungen der Hochgeborenen und Lichlinge spuken in den Ruinen bei {area:3137}.",
	-- ["Any undead can drop it. The {npc:7864} in the {area:1221}, below {npc:8405}'s cliffs, are the nearest; Highborne Apparitions and Lichlings haunt the ruins near {area:3137}."] = "Jeder Untote kann es fallen lassen. Die {npc:7864} im Gebiet {area:1221}, unterhalb der Klippen von {npc:8405}, sind am nächsten; Erscheinungen von Hochgeborenen und Lichlinge von Hochgeborenen spuken in den Ruinen nahe der {area:3137}.",
	-- ["At 50 {npc:5489} in {zone:1453}'s Cathedral of Light or {npc:11406} in {zone:1455}'s {object:32386} offers it."] = "Mit Stufe 50 bietet sie {npc:5489} in der Kathedrale des Lichts in {zone:1453} oder {npc:11406} in der {object:32386} in {zone:1455} an.",
	-- ["At 50 {npc:6018} in {zone:1454}'s {object:172961} offers it."] = "Mit Stufe 50 bietet sie {npc:6018} im {object:172961} in {zone:1454} an.",
	-- ["Experience and gold"] = "Erfahrung und Gold",
	-- ["Experience and gold at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "Erfahrung und Gold mit Stufe 50 durch {zone:1447} und den {area:1417}; Forever hat die Gegenstandsauswahl aus Classic entfernt.",
	-- ["Morphaz is an elite dragon boss inside the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "Morphaz ist ein Elite-Drachenboss im {area:1417}, einem Dungeon der Stufe 50: Nimm eine Gruppe aus fünf mit. Der Tempel liegt mitten im {area:74}; tauch hinab, um den Eingang zu erreichen. Horde: Flieg nach {area:75}; Allianz: Flieg nach {area:42} oder zur {area:1438} und reite weiter.",
	-- ["Mosshoof Coursers graze all over {zone:1447}; about one in three drops a {item:20027}."] = "Mooshufrenner grasen überall in {zone:1447}; etwa jeder dritte lässt eine {item:20027} fallen.",
	-- ["Mosshoof Coursers graze all over {zone:1447}; about one in three drops a {item:20027}. Keep any {item:7972} you loot: {npc:8405}'s next stage asks for one."] = "Mooshufrenner grasen überall im {zone:1447}; etwa jeder dritte lässt {item:20027} fallen. Behalte jedes {item:7972}, das du erbeutest: Die nächste Stufe von {npc:8405} verlangt eines.",
	-- ["{npc:10922} is at the {area:2479} in southern {zone:1448}."] = "{npc:10922} ist im Gebiet {area:2479} im Süden von {zone:1448}.",
	-- ["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405} lebt oben auf den Klippen nordöstlich des Gebiets {area:1221}. Allianz: Flieg zur {area:3137}; Horde: Flieg nach {area:1237}.",
	-- ["{quest:8254} (Alliance)"] = "{quest:8254} (Allianz)",
	-- ["{quest:8254} (Horde)"] = "{quest:8254} (Horde)",
}
