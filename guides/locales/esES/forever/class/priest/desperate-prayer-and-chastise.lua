-- Spanish (Spain) (esES): the guide forever/class/priest/desperate-prayer-and-chastise (forever/class/priest/desperate-prayer-and-chastise.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["{quest:5634} and {quest:5641}"] = "{quest:5634} y {quest:5641}",
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["The Dwarf priest spells: {quest:5634} at 10, {quest:5641} (new in Forever) at 20. Free, no objectives."] = "",

	-- Step 1: Desperate Prayer: Maxan Anvol
	-- {npc:1226} Maxan Anvol · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10, {npc:1226}, the priest trainer inside the Thunderbrew Distillery in Kharanos, hands you a {quest:5634} letter for {npc:11406}. Kharanos is on the road up to {zone:1455}."] = "",
	-- {npc:1226} Maxan Anvol · {quest:5634} Desperate Prayer
	["{npc:1226}: take his {quest:5634} letter"] = "",

	-- Step 2: Desperate Prayer: Priestess Josetta
	-- {zone:1429} Elwynn Forest · {npc:377} Priestess Josetta · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {zone:1453} Stormwind · {object:28027} Dwarven District
	["At 10 in {zone:1429}, {npc:377}, upstairs in the Lion's Pride Inn in Goldshire, hands you a {quest:5634} letter for {npc:11406} in {zone:1455} (the Deeprun Tram from {zone:1453}'s {object:28027})."] = "",
	-- {npc:377} Priestess Josetta · {quest:5634} Desperate Prayer
	["{npc:377}: take her {quest:5634} letter"] = "",

	-- Step 3: Desperate Prayer: Nara Meideros
	-- {zone:1453} Stormwind · {npc:11397} Nara Meideros · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {npc:376} High Priestess Laurena
	["At 10 in {zone:1453}, {npc:11397}, the priest trainer in the Park (the night elf quarter on the city's west side), hands you a {quest:5634} letter for {npc:11406} in {zone:1455}. {npc:376} in the Cathedral has none for Dwarves."] = "",
	-- {npc:11397} Nara Meideros · {quest:5634} Desperate Prayer
	["{npc:11397}: take her {quest:5634} letter"] = "",

	-- Step 4: Desperate Prayer: Laurna Morninglight
	-- {zone:1438} Teldrassil · {npc:3600} Laurna Morninglight · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10 in {zone:1438}, {npc:3600}, in the building at the north edge of Dolanaar, hands you a {quest:5634} letter for {npc:11406} in {zone:1455}."] = "",
	-- {npc:3600} Laurna Morninglight · {quest:5634} Desperate Prayer
	["{npc:3600}: take her {quest:5634} letter"] = "",

	-- Step 5: Desperate Prayer: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455}."] = "",
	-- {npc:11401} Priestess Alathea · {quest:5634} Desperate Prayer
	["{npc:11401}: take her {quest:5634} letter"] = "",

	-- Step 6: Desperate Prayer: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:5634} Desperate Prayer
	["At 10, go to {npc:11406} in the {object:32386}, in {zone:1455}'s {object:32362} (north-west of the city): he gives {quest:5634} and takes it back at once. No letter needed. {quest:5634} heals you instantly, costs no mana and has a long cooldown: keep it for emergencies."] = "",

	-- Step 7: Desperate Prayer: Maxan Anvol's letter
	-- {quest:5637} Desperate Prayer · {npc:1226} Maxan Anvol
	["{quest:5637}: {npc:1226}'s letter"] = "",
	-- {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {quest:5637} Desperate Prayer · {zone:1453} Stormwind
	["Follow the road up from Kharanos into {zone:1455} and west to the {object:32362}: {npc:11406} in the {object:32386} takes the letter and teaches {quest:5637}. The letter tells you to head to {zone:1453}, but the one who wants you is Rohan in {zone:1455}."] = "",

	-- Step 8: Desperate Prayer: Josetta's letter
	-- {quest:5635} Desperate Prayer
	["{quest:5635}: Josetta's letter"] = "",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1453} Stormwind · {object:28027} Dwarven District
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: the Deeprun Tram from {zone:1453}'s {object:28027}."] = "",

	-- Step 9: Desperate Prayer: Nara's letter
	-- {quest:5638} Desperate Prayer
	["{quest:5638}: Nara's letter"] = "",

	-- Step 10: Desperate Prayer: Laurna Morninglight's letter
	-- {quest:5636} Desperate Prayer · {npc:3600} Laurna Morninglight
	["{quest:5636}: {npc:3600}'s letter"] = "",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1438} Teldrassil · {object:1162} Menethil Harbor (no name in this language: may be words) · {zone:1437} Wetlands · {zone:1432} Loch Modan
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: from {zone:1438}, the boat from Rut'theran Village to Auberdine, the boat to {object:1162} and the road north through the {zone:1437} and {zone:1432} (or the boat to Stormwind Harbor and the Deeprun Tram)."] = "",

	-- Step 11: Desperate Prayer: Alathea's letter
	-- {quest:5640} Desperate Prayer
	["{quest:5640}: Alathea's letter"] = "",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1453} Stormwind · {zone:1457} Darnassus · {object:1162} Menethil Harbor (no name in this language: may be words)
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: its text says {zone:1453}, but Rohan is in {zone:1455}. From {zone:1457}, the portal down to Rut'theran Village, the boat to Auberdine, then {object:1162} and the road north (or Stormwind Harbor and the Deeprun Tram)."] = "",

	-- Step 12: Desperate Prayer: an old letter
	-- {quest:5634} Desperate Prayer
	["{quest:5634}: an old letter"] = "",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["This letter also goes to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}."] = "",

	-- Step 13: Chastise: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena · {quest:5641} Chastise · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {object:28027} Dwarven District
	["At 20 in {zone:1453}, {npc:376} at the altar of the Cathedral of Light hands you a {quest:5641} letter for {npc:11406} in {zone:1455} (the Deeprun Tram from the {object:28027})."] = "",
	-- {npc:376} High Priestess Laurena · {quest:5641} Chastise
	["{npc:376}: take her {quest:5641} letter"] = "",

	-- Step 14: Chastise: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {quest:5641} Chastise · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 20 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a {quest:5641} letter for {npc:11406} in {zone:1455}."] = "",
	-- {npc:11401} Priestess Alathea · {quest:5641} Chastise
	["{npc:11401}: take her {quest:5641} letter"] = "",

	-- Step 15: Chastise: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {quest:5641} Chastise
	["At 20, {npc:11406} in the {object:32386} teaches {quest:5641} with a quest he gives and takes back at once. Forever renamed it from A Lack of Fear: {quest:5641} damages a humanoid and roots it for 2 seconds (instant, 2-minute cooldown), and every priest now trains Fear Ward."] = "",

	-- Step 16: Chastise: Laurena's letter
	-- {quest:5645} Chastise
	["{quest:5645}: Laurena's letter"] = "",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:5645} Chastise
	["Hand Laurena's letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: he teaches {quest:5645}."] = "",

	-- Step 17: Chastise: Alathea's letter
	-- {quest:5647} Chastise
	["{quest:5647}: Alathea's letter"] = "",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1457} Darnassus · {object:1162} Menethil Harbor (no name in this language: may be words) · {zone:1437} Wetlands · {zone:1432} Loch Modan
	["Hand Alathea's letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: from {zone:1457}, the boats via Rut'theran Village and Auberdine to {object:1162}, then the road north through the {zone:1437} and {zone:1432} (or the boat to Stormwind Harbor and the Deeprun Tram)."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:11406} in the {object:32386}, in {zone:1455}'s {object:32362}. Forever's quest text names Rohan, but the quest data has {npc:376} in {zone:1453}'s Cathedral of Light take it: try Rohan first, then Laurena (the {area:2257} links the cities)."] = "A nivel 10, ve con {npc:11406} en {object:32386}, en {object:32362} de {zone:1455}. El texto de la misión de Forever nombra a Rohan, pero según los datos la entrega {npc:376} en la Catedral de la Luz de {zone:1453}: prueba primero con Rohan y luego con Laurena ({area:2257} une ambas ciudades).",
	-- ["At 20, {npc:11406} teaches {quest:5641}. {npc:376} in {zone:1453} and {npc:11401} in {zone:1457} send you to him with a quest of the same name."] = "A nivel 20, {npc:11406} enseña {quest:5641}. {npc:376} en {zone:1453} y {npc:11401} en {zone:1457} te envían con él con una misión del mismo nombre.",
	-- ["If Rohan did not take it: {npc:376} is in the Cathedral of Light. Take the {area:2257} from {object:171524}."] = "Si Rohan no la aceptó: {npc:376} está en la Catedral de la Luz. Toma {area:2257} desde {object:171524}.",
	-- ["The Human and Dwarf priest spells: {quest:5634} at 10, {quest:5641} for Dwarves at 20."] = "Los hechizos de sacerdote humano y enano: {quest:5634} a nivel 10, {quest:5641} para enanos a nivel 20.",
}
