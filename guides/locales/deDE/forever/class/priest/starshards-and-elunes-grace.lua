-- German (deDE): the guide forever/class/priest/starshards-and-elunes-grace (forever/class/priest/starshards-and-elunes-grace.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:10797} Starshards · {spell:2651} Elune's Grace
	["{spell:10797} and {spell:2651}"] = "{spell:10797} und {spell:2651}",
	-- {spell:10797} Starshards · {spell:2651} Elune's Grace
	["The Night Elf priest spells: {spell:10797} at 10, {spell:2651} at 20. Free, no objectives."] = "Die Priesterzauber der Nachtelfen: {spell:10797} mit 10, {spell:2651} mit 20. Kostenlos, keine Ziele.",

	-- Step 1: Starshards: Laurna Morninglight
	-- {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {quest:5628} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 10, {npc:3600}, the priest trainer in the building at the north edge of {area:186}, hands you {quest:5628}, a letter for {npc:11401} in {zone:1457}. {area:186} is on the road west to {zone:1457}."] = "Mit 10 gibt dir {npc:3600}, die Priesterlehrerin im Gebäude am Nordrand von {area:186}, {quest:5628}, einen Brief für {npc:11401} in {zone:1457}. {area:186} liegt an der Straße nach Westen zu {zone:1457}.",
	-- {npc:3600} Laurna Morninglight · {quest:5628} Returning Home
	["{npc:3600}: take {quest:5628}"] = "{npc:3600}: Nimm {quest:5628} an",

	-- Step 2: Starshards: Priestess Josetta
	-- {zone:1429} Elwynn Forest · {npc:377} Priestess Josetta · {area:87} Goldshire · {quest:5628} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 10 in {zone:1429}, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you {quest:5628}, a letter for {npc:11401} in {zone:1457}."] = "Mit 10 gibt dir in {zone:1429} {npc:377}, oben im Lion's Pride Inn in {area:87}, {quest:5628}, einen Brief für {npc:11401} in {zone:1457}.",
	-- {npc:377} Priestess Josetta · {quest:5628} Returning Home
	["{npc:377}: take {quest:5628}"] = "{npc:377}: Nimm {quest:5628} an",

	-- Step 3: Starshards: Maxan Anvol
	-- {zone:1426} Dun Morogh · {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {quest:5628} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 10 in {zone:1426}, {npc:1226}, the priest trainer inside the {area:2102} in {area:131}, hands you {quest:5628}, a letter for {npc:11401} in {zone:1457}."] = "Mit 10 gibt dir in {zone:1426} {npc:1226}, der Priesterlehrer in der {area:2102} in {area:131}, {quest:5628}, einen Brief für {npc:11401} in {zone:1457}.",
	-- {npc:1226} Maxan Anvol · {quest:5628} Returning Home
	["{npc:1226}: take {quest:5628}"] = "{npc:1226}: Nimm {quest:5628} an",

	-- Step 4: Starshards: Brother Joshua
	-- {zone:1453} Stormwind · {npc:5489} Brother Joshua · {quest:5628} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:11397} Nara Meideros
	["At 10 in {zone:1453}, {npc:5489} at the altar of the Cathedral of Light hands you {quest:5628}, a letter for {npc:11401} in {zone:1457}. {npc:11397} in the Park has the same letter."] = "Mit 10 gibt dir in {zone:1453} {npc:5489} am Altar der Kathedrale des Lichts {quest:5628}, einen Brief für {npc:11401} in {zone:1457}. {npc:11397} im Park hat denselben Brief.",
	-- {npc:5489} Brother Joshua · {quest:5628} Returning Home
	["{npc:5489}: take {quest:5628}"] = "{npc:5489}: Nimm {quest:5628} an",

	-- Step 5: Starshards: Braenna Flintcrag
	-- {zone:1455} Ironforge · {npc:5142} Braenna Flintcrag · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:5628} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 10 in {zone:1455}, {npc:5142} in the {object:32386} ({object:32362}) hands you {quest:5628}, a letter for {npc:11401} in {zone:1457}."] = "Mit 10 gibt dir in {zone:1455} {npc:5142} im {object:32386} ({object:32362}) {quest:5628}, einen Brief für {npc:11401} in {zone:1457}.",
	-- {npc:5142} Braenna Flintcrag · {quest:5628} Returning Home
	["{npc:5142}: take {quest:5628}"] = "{npc:5142}: Nimm {quest:5628} an",

	-- Step 6: Starshards: Priestess Alathea
	-- {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {quest:5627} Stars of Elune · {spell:10797} Starshards
	["At 10, go to {npc:11401} on the upper balcony of the Temple of the Moon, at the south end of {zone:1457}: take the ramp up from the temple floor; she stands beside {npc:7999}. {quest:5627} is given and taken back at once and teaches {spell:10797}. No letter needed. Forever made {spell:10797} hit much harder, on a 30-second cooldown."] = "Geh mit 10 zu {npc:11401} auf dem oberen Balkon des Tempels des Mondes am Südende von {zone:1457}: Nimm die Rampe von der Tempelhalle nach oben; sie steht neben {npc:7999}. {quest:5627} wird gegeben und sofort zurückgenommen und bringt dir {spell:10797} bei. Kein Brief nötig. Forever hat {spell:10797} deutlich stärker gemacht, bei 30 Sekunden Abklingzeit.",

	-- Step 7: Starshards: Laurna Morninglight's letter
	-- {spell:10797} Starshards · {npc:3600} Laurna Morninglight
	["{spell:10797}: {npc:3600}'s letter"] = "{spell:10797}: der Brief von {npc:3600}",
	-- {area:186} Dolanaar · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {npc:11401} Priestess Alathea · {quest:5629} Returning Home · {spell:10797} Starshards
	["Take the road west from {area:186} into {zone:1457} and go up to the upper balcony of the Temple of the Moon, beside {npc:7999}: {npc:11401} takes {quest:5629} and teaches {spell:10797}."] = "Nimm die Straße nach Westen von {area:186} nach {zone:1457} und geh hinauf auf den oberen Balkon des Tempels des Mondes, neben {npc:7999}: {npc:11401} nimmt {quest:5629} entgegen und bringt dir {spell:10797} bei.",

	-- Step 8: Starshards: Josetta's letter
	-- {spell:10797} Starshards
	["{spell:10797}: Josetta's letter"] = "{spell:10797}: Josettas Brief",
	-- {quest:5628} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["{quest:5628} goes to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: take the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "{quest:5628} geht an {npc:11401}, auf dem oberen Balkon des Tempels des Mondes in {zone:1457}, neben {npc:7999}: Nimm das Boot von {area:17203} (oder {area:150}) nach {area:442}, das Boot weiter nach {area:702}, dann das Portal hinauf nach {zone:1457}.",

	-- Step 9: Starshards: Maxan Anvol's letter
	-- {spell:10797} Starshards · {npc:1226} Maxan Anvol
	["{spell:10797}: {npc:1226}'s letter"] = "{spell:10797}: der Brief von {npc:1226}",
	-- {quest:5630} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["{quest:5630} goes to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: take the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "{quest:5630} geht an {npc:11401}, auf dem oberen Balkon des Tempels des Mondes in {zone:1457}, neben {npc:7999}: Nimm das Boot von {area:17203} (oder {area:150}) nach {area:442}, das Boot weiter nach {area:702}, dann das Portal hinauf nach {zone:1457}.",

	-- Step 10: Starshards: Joshua's letter
	-- {spell:10797} Starshards
	["{spell:10797}: Joshua's letter"] = "{spell:10797}: Joshuas Brief",
	-- {quest:5631} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["{quest:5631} goes to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: take the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "{quest:5631} geht an {npc:11401}, auf dem oberen Balkon des Tempels des Mondes in {zone:1457}, neben {npc:7999}: Nimm das Boot von {area:17203} (oder {area:150}) nach {area:442}, das Boot weiter nach {area:702}, dann das Portal hinauf nach {zone:1457}.",

	-- Step 11: Starshards: Nara's letter
	-- {spell:10797} Starshards
	["{spell:10797}: Nara's letter"] = "{spell:10797}: Naras Brief",
	-- {quest:5632} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["{quest:5632} goes to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: take the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "{quest:5632} geht an {npc:11401}, auf dem oberen Balkon des Tempels des Mondes in {zone:1457}, neben {npc:7999}: Nimm das Boot von {area:17203} (oder {area:150}) nach {area:442}, das Boot weiter nach {area:702}, dann das Portal hinauf nach {zone:1457}.",

	-- Step 12: Starshards: Braenna Flintcrag's letter
	-- {spell:10797} Starshards · {npc:5142} Braenna Flintcrag
	["{spell:10797}: {npc:5142}'s letter"] = "{spell:10797}: der Brief von {npc:5142}",
	-- {quest:5633} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["{quest:5633} goes to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: take the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "{quest:5633} geht an {npc:11401}, auf dem oberen Balkon des Tempels des Mondes in {zone:1457}, neben {npc:7999}: Nimm das Boot von {area:17203} (oder {area:150}) nach {area:442}, das Boot weiter nach {area:702}, dann das Portal hinauf nach {zone:1457}.",

	-- Step 13: Elune's Grace: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena · {spell:2651} Elune's Grace · {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:11397} Nara Meideros
	["At 20 in {zone:1453}, {npc:376} at the altar of the Cathedral of Light hands you an {spell:2651} letter for {npc:11401} in {zone:1457}. {npc:11397} in the Park has the same letter."] = "Mit 20 gibt dir in {zone:1453} {npc:376} am Altar der Kathedrale des Lichts einen Brief {spell:2651} für {npc:11401} in {zone:1457}. {npc:11397} im Park hat denselben Brief.",
	-- {npc:376} High Priestess Laurena · {spell:2651} Elune's Grace
	["{npc:376}: take her {spell:2651} letter"] = "{npc:376}: Nimm ihren Brief {spell:2651} an",

	-- Step 14: Elune's Grace: High Priest Rohan
	-- {zone:1455} Ironforge · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words) · {spell:2651} Elune's Grace · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 20 in {zone:1455}, {npc:11406} in the {object:32386} ({object:32362}) hands you an {spell:2651} letter for {npc:11401} in {zone:1457}."] = "Mit 20 gibt dir in {zone:1455} {npc:11406} im {object:32386} ({object:32362}) einen Brief {spell:2651} für {npc:11401} in {zone:1457}.",
	-- {npc:11406} High Priest Rohan · {spell:2651} Elune's Grace
	["{npc:11406}: take his {spell:2651} letter"] = "{npc:11406}: Nimm seinen Brief {spell:2651} an",

	-- Step 15: Elune's Grace: Priestess Alathea
	-- {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {quest:5672} Elune's Grace
	["At 20, {npc:11401} on the upper balcony of the Temple of the Moon, beside {npc:7999}, teaches {quest:5672} with a quest she gives and takes back at once. In Forever, {quest:5672} halves the chance for melee and ranged attacks to hit you for 15 seconds or until three attacks miss."] = "Mit 20 bringt dir {npc:11401} auf dem oberen Balkon des Tempels des Mondes, neben {npc:7999}, {quest:5672} mit einer Quest bei, die sie dir gibt und sofort zurücknimmt. In Forever halbiert {quest:5672} 15 Sekunden lang die Chance, dass Nah- und Fernkampfangriffe dich treffen, oder bis drei Angriffe danebengehen.",

	-- Step 16: Elune's Grace: Laurena's letter
	-- {quest:5673} Elune's Grace
	["{quest:5673}: Laurena's letter"] = "{quest:5673}: Laurenas Brief",
	-- {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Hand Laurena's letter to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "Gib Laurenas Brief bei {npc:11401} ab, auf dem oberen Balkon des Tempels des Mondes in {zone:1457}, neben {npc:7999}: das Boot von {area:17203} (oder {area:150}) nach {area:442}, das Boot weiter nach {area:702}, dann das Portal hinauf nach {zone:1457}.",

	-- Step 17: Elune's Grace: Nara's letter
	-- {quest:5674} Elune's Grace
	["{quest:5674}: Nara's letter"] = "{quest:5674}: Naras Brief",
	-- {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Hand Nara's letter to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "Gib Naras Brief bei {npc:11401} ab, auf dem oberen Balkon des Tempels des Mondes in {zone:1457}, neben {npc:7999}: das Boot von {area:17203} (oder {area:150}) nach {area:442}, das Boot weiter nach {area:702}, dann das Portal hinauf nach {zone:1457}.",

	-- Step 18: Elune's Grace: Rohan's letter
	-- {quest:5675} Elune's Grace
	["{quest:5675}: Rohan's letter"] = "{quest:5675}: Rohans Brief",
	-- {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Hand Rohan's letter to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "Gib Rohans Brief bei {npc:11401} ab, auf dem oberen Balkon des Tempels des Mondes in {zone:1457}, neben {npc:7999}: das Boot von {area:17203} (oder {area:150}) nach {area:442}, das Boot weiter nach {area:702}, dann das Portal hinauf nach {zone:1457}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:11401} in the Temple of the Moon. Priest trainers elsewhere ({npc:3600} in {area:186}, {npc:377} in {area:87}, {npc:1226} in {area:131}) send you to her with {quest:5628}."] = "Geh auf Stufe 10 zu {npc:11401} im Tempel des Mondes. Priesterlehrer anderswo ({npc:3600} in {area:186}, {npc:377} in {area:87}, {npc:1226} in {area:131}) schicken dich mit {quest:5628} zu ihr.",
	-- ["At 20, {npc:11401} teaches {quest:5672}. {npc:376} in {zone:1453} and {npc:11406} in {zone:1455} send you to her with a quest of the same name."] = "Auf Stufe 20 lehrt {npc:11401} {quest:5672}. {npc:376} in {zone:1453} und {npc:11406} in {zone:1455} schicken dich mit einer gleichnamigen Quest zu ihr.",
	-- ["The Night Elf priest spells: {spell:10797} at 10, {spell:2651} at 20."] = "Die Nachtelfen-Priesterzauber: {spell:10797} auf Stufe 10, {spell:2651} auf Stufe 20.",
}
