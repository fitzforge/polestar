-- German (deDE): the guide forever/class/priest/desperate-prayer-and-chastise (forever/class/priest/desperate-prayer-and-chastise.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["{quest:5634} and {quest:5641}"] = "{quest:5634} und {quest:5641}",
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["The Dwarf priest spells: {quest:5634} at 10, {quest:5641} (new in Forever) at 20. Free, no objectives."] = "Die Priesterzauber der Zwerge: {quest:5634} mit 10, {quest:5641} (neu in Forever) mit 20. Kostenlos, keine Ziele.",

	-- Step 1: Desperate Prayer: Maxan Anvol
	-- {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10, {npc:1226}, the priest trainer inside the {area:2102} in {area:131}, hands you a {quest:5634} letter for {npc:11406}. {area:131} is on the road up to {zone:1455}."] = "Mit 10 gibt dir {npc:1226}, der Priesterlehrer in der {area:2102} in {area:131}, einen Brief {quest:5634} für {npc:11406}. {area:131} liegt an der Straße hinauf nach {zone:1455}.",
	-- {npc:1226} Maxan Anvol · {quest:5634} Desperate Prayer
	["{npc:1226}: take his {quest:5634} letter"] = "{npc:1226}: Nimm seinen Brief {quest:5634} an",

	-- Step 2: Desperate Prayer: Priestess Josetta
	-- {zone:1429} Elwynn Forest · {npc:377} Priestess Josetta · {area:87} Goldshire · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["At 10 in {zone:1429}, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455} (the {area:2257} from {zone:1453}'s {object:28027})."] = "Mit 10 gibt dir in {zone:1429} {npc:377}, oben im Lion's Pride Inn in {area:87}, einen Brief {quest:5634} für {npc:11406} in {zone:1455} ({area:2257} vom {object:28027} in {zone:1453}).",
	-- {npc:377} Priestess Josetta · {quest:5634} Desperate Prayer
	["{npc:377}: take her {quest:5634} letter"] = "{npc:377}: Nimm ihren Brief {quest:5634} an",

	-- Step 3: Desperate Prayer: Nara Meideros
	-- {zone:1453} Stormwind · {npc:11397} Nara Meideros · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {npc:376} High Priestess Laurena
	["At 10 in {zone:1453}, {npc:11397}, the priest trainer in the Park (the night elf quarter on the city's west side), hands you a {quest:5634} letter for {npc:11406} in {zone:1455}. {npc:376} in the Cathedral has none for Dwarves."] = "Mit 10 gibt dir in {zone:1453} {npc:11397}, die Priesterlehrerin im Park (dem Nachtelfenviertel an der Westseite der Stadt), einen Brief {quest:5634} für {npc:11406} in {zone:1455}. {npc:376} in der Kathedrale hat keinen für Zwerge.",
	-- {npc:11397} Nara Meideros · {quest:5634} Desperate Prayer
	["{npc:11397}: take her {quest:5634} letter"] = "{npc:11397}: Nimm ihren Brief {quest:5634} an",

	-- Step 4: Desperate Prayer: Laurna Morninglight
	-- {zone:1438} Teldrassil · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10 in {zone:1438}, {npc:3600}, in the building at the north edge of {area:186}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455}."] = "Mit 10 gibt dir in {zone:1438} {npc:3600}, im Gebäude am Nordrand von {area:186}, einen Brief {quest:5634} für {npc:11406} in {zone:1455}.",
	-- {npc:3600} Laurna Morninglight · {quest:5634} Desperate Prayer
	["{npc:3600}: take her {quest:5634} letter"] = "{npc:3600}: Nimm ihren Brief {quest:5634} an",

	-- Step 5: Desperate Prayer: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455}."] = "Mit 10 gibt dir in {zone:1457} {npc:11401}, auf dem oberen Balkon des Tempels des Mondes neben {npc:7999}, einen Brief {quest:5634} für {npc:11406} in {zone:1455}.",
	-- {npc:11401} Priestess Alathea · {quest:5634} Desperate Prayer
	["{npc:11401}: take her {quest:5634} letter"] = "{npc:11401}: Nimm ihren Brief {quest:5634} an",

	-- Step 6: Desperate Prayer: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:5634} Desperate Prayer
	["At 10, go to {npc:11406} in the {object:32386}, in {zone:1455}'s {object:32362} (north-west of the city): he gives {quest:5634} and takes it back at once. No letter needed. {quest:5634} heals you instantly, costs no mana and has a long cooldown: keep it for emergencies."] = "Geh mit 10 zu {npc:11406} im {object:32386}, in {object:32362} von {zone:1455} (nordwestlich der Stadt): Er gibt dir {quest:5634} und nimmt sie sofort zurück. Kein Brief nötig. {quest:5634} heilt dich sofort, kostet kein Mana und hat eine lange Abklingzeit: Spar es für Notfälle auf.",

	-- Step 7: Desperate Prayer: Maxan Anvol's letter
	-- {quest:5637} Desperate Prayer · {npc:1226} Maxan Anvol
	["{quest:5637}: {npc:1226}'s letter"] = "{quest:5637}: der Brief von {npc:1226}",
	-- {area:131} Kharanos · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {quest:5637} Desperate Prayer · {zone:1453} Stormwind
	["Follow the road up from {area:131} into {zone:1455} and west to the {object:32362}: {npc:11406} in the {object:32386} takes the letter and teaches {quest:5637}. The letter tells you to head to {zone:1453}, but the one who wants you is Rohan in {zone:1455}."] = "Folge der Straße von {area:131} hinauf nach {zone:1455} und nach Westen zu {object:32362}: {npc:11406} im {object:32386} nimmt den Brief entgegen und bringt dir {quest:5637} bei. Der Brief schickt dich nach {zone:1453}, aber wer dich braucht, ist Rohan in {zone:1455}.",

	-- Step 8: Desperate Prayer: Josetta's letter
	-- {quest:5635} Desperate Prayer
	["{quest:5635}: Josetta's letter"] = "{quest:5635}: Josettas Brief",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: the {area:2257} from {zone:1453}'s {object:28027}."] = "Gib den Brief bei {npc:11406} im {object:32386}, in {object:32362} von {zone:1455}, ab: {area:2257} vom {object:28027} in {zone:1453}.",

	-- Step 9: Desperate Prayer: Nara's letter
	-- {quest:5638} Desperate Prayer
	["{quest:5638}: Nara's letter"] = "{quest:5638}: Naras Brief",

	-- Step 10: Desperate Prayer: Laurna Morninglight's letter
	-- {quest:5636} Desperate Prayer · {npc:3600} Laurna Morninglight
	["{quest:5636}: {npc:3600}'s letter"] = "{quest:5636}: der Brief von {npc:3600}",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1438} Teldrassil · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: from {zone:1438}, the boat from {area:702} to {area:442}, the boat to {area:150} and the road north through the {zone:1437} and {zone:1432} (or the boat to {area:17203} and the {area:2257})."] = "Gib den Brief bei {npc:11406} im {object:32386}, in {object:32362} von {zone:1455}, ab: von {zone:1438} das Boot von {area:702} nach {area:442}, das Boot nach {area:150} und die Straße nach Norden durch {zone:1437} und {zone:1432} (oder das Boot nach {area:17203} und {area:2257}).",

	-- Step 11: Desperate Prayer: Alathea's letter
	-- {quest:5640} Desperate Prayer
	["{quest:5640}: Alathea's letter"] = "{quest:5640}: Alatheas Brief",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1453} Stormwind · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: its text says {zone:1453}, but Rohan is in {zone:1455}. From {zone:1457}, the portal down to {area:702}, the boat to {area:442}, then {area:150} and the road north (or {area:17203} and the {area:2257})."] = "Gib den Brief bei {npc:11406} im {object:32386}, in {object:32362} von {zone:1455}, ab: Im Text steht {zone:1453}, aber Rohan ist in {zone:1455}. Von {zone:1457} das Portal hinunter nach {area:702}, das Boot nach {area:442}, dann {area:150} und die Straße nach Norden (oder {area:17203} und {area:2257}).",

	-- Step 12: Desperate Prayer: an old letter
	-- {quest:5634} Desperate Prayer
	["{quest:5634}: an old letter"] = "{quest:5634}: ein alter Brief",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["This letter also goes to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}."] = "Auch dieser Brief geht an {npc:11406} im {object:32386}, in {object:32362} von {zone:1455}.",

	-- Step 13: Chastise: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena · {quest:5641} Chastise · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:28027} Dwarven District
	["At 20 in {zone:1453}, {npc:376} at the altar of the Cathedral of Light hands you a {quest:5641} letter for {npc:11406} in {zone:1455} (the {area:2257} from the {object:28027})."] = "Mit 20 gibt dir in {zone:1453} {npc:376} am Altar der Kathedrale des Lichts einen Brief {quest:5641} für {npc:11406} in {zone:1455} ({area:2257} vom {object:28027} aus).",
	-- {npc:376} High Priestess Laurena · {quest:5641} Chastise
	["{npc:376}: take her {quest:5641} letter"] = "{npc:376}: Nimm ihren Brief {quest:5641} an",

	-- Step 14: Chastise: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {quest:5641} Chastise · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 20 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a {quest:5641} letter for {npc:11406} in {zone:1455}."] = "Mit 20 gibt dir in {zone:1457} {npc:11401}, auf dem oberen Balkon des Tempels des Mondes neben {npc:7999}, einen Brief {quest:5641} für {npc:11406} in {zone:1455}.",
	-- {npc:11401} Priestess Alathea · {quest:5641} Chastise
	["{npc:11401}: take her {quest:5641} letter"] = "{npc:11401}: Nimm ihren Brief {quest:5641} an",

	-- Step 15: Chastise: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {quest:5641} Chastise · {spell:6346} Fear Ward
	["At 20, {npc:11406} in the {object:32386} teaches {quest:5641} with a quest he gives and takes back at once. Forever renamed it from A Lack of Fear: {quest:5641} damages a humanoid and roots it for 2 seconds (instant, 2-minute cooldown), and every priest now trains {spell:6346}."] = "Mit 20 bringt dir {npc:11406} im {object:32386} {quest:5641} mit einer Quest bei, die er dir gibt und sofort zurücknimmt. Forever hat sie von A Lack of Fear umbenannt: {quest:5641} fügt einem Humanoiden Schaden zu und bannt ihn 2 Sekunden lang (sofort, 2 Minuten Abklingzeit), und jeder Priester lernt jetzt {spell:6346}.",

	-- Step 16: Chastise: Laurena's letter
	-- {quest:5645} Chastise
	["{quest:5645}: Laurena's letter"] = "{quest:5645}: Laurenas Brief",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:5645} Chastise
	["Hand Laurena's letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: he teaches {quest:5645}."] = "Gib Laurenas Brief bei {npc:11406} im {object:32386}, in {object:32362} von {zone:1455}, ab: Er bringt dir {quest:5645} bei.",

	-- Step 17: Chastise: Alathea's letter
	-- {quest:5647} Chastise
	["{quest:5647}: Alathea's letter"] = "{quest:5647}: Alatheas Brief",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand Alathea's letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: from {zone:1457}, the boats via {area:702} and {area:442} to {area:150}, then the road north through the {zone:1437} and {zone:1432} (or the boat to {area:17203} and the {area:2257})."] = "Gib Alatheas Brief bei {npc:11406} im {object:32386}, in {object:32362} von {zone:1455}, ab: von {zone:1457} die Boote über {area:702} und {area:442} nach {area:150}, dann die Straße nach Norden durch {zone:1437} und {zone:1432} (oder das Boot nach {area:17203} und {area:2257}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:11406} in the {object:32386}, in {zone:1455}'s {object:32362}. Forever's quest text names Rohan, but the quest data has {npc:376} in {zone:1453}'s Cathedral of Light take it: try Rohan first, then Laurena (the {area:2257} links the cities)."] = "Geh mit Stufe 10 zu {npc:11406} in der {object:32386} im {object:32362} in {zone:1455}. Der Questtext von Forever nennt Rohan, laut Questdaten nimmt sie aber {npc:376} in der Kathedrale des Lichts in {zone:1453} an: Versuch es zuerst bei Rohan, dann bei Laurena ({area:2257} verbindet die Städte).",
	-- ["At 20, {npc:11406} teaches {quest:5641}. {npc:376} in {zone:1453} and {npc:11401} in {zone:1457} send you to him with a quest of the same name."] = "Mit Stufe 20 lehrt {npc:11406} {quest:5641}. {npc:376} in {zone:1453} und {npc:11401} in {zone:1457} schicken dich mit einer gleichnamigen Quest zu ihm.",
	-- ["If Rohan did not take it: {npc:376} is in the Cathedral of Light. Take the {area:2257} from {object:171524}."] = "Falls Rohan sie nicht angenommen hat: {npc:376} ist in der Kathedrale des Lichts. Nimm in {object:171524} die Bahn {area:2257}.",
	-- ["The Human and Dwarf priest spells: {quest:5634} at 10, {quest:5641} for Dwarves at 20."] = "Die Priesterzauber der Menschen und Zwerge: {quest:5634} mit Stufe 10, {quest:5641} für Zwerge mit Stufe 20.",
}
