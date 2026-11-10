-- Portuguese (Brazil) (ptBR): the guide forever/class/priest/desperate-prayer-and-chastise (forever/class/priest/desperate-prayer-and-chastise.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["{quest:5634} and {quest:5641}"] = "{quest:5634} e {quest:5641}",
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["The Dwarf priest spells: {quest:5634} at 10, {quest:5641} (new in Forever) at 20. Free, no objectives."] = "As magias do sacerdote anão: {quest:5634} no nível 10, {quest:5641} (nova no Forever) no 20. De graça, sem objetivos.",

	-- Step 1: Desperate Prayer: Maxan Anvol
	-- {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10, {npc:1226}, the priest trainer inside the {area:2102} in {area:131}, hands you a {quest:5634} letter for {npc:11406}. {area:131} is on the road up to {zone:1455}."] = "No nível 10, {npc:1226}, o instrutor de sacerdote dentro da {area:2102}, em {area:131}, entrega uma carta de {quest:5634} para {npc:11406}. {area:131} fica na estrada que sobe até {zone:1455}.",
	-- {npc:1226} Maxan Anvol · {quest:5634} Desperate Prayer
	["{npc:1226}: take his {quest:5634} letter"] = "{npc:1226}: pegue a carta de {quest:5634} dele",

	-- Step 2: Desperate Prayer: Priestess Josetta
	-- {zone:1429} Elwynn Forest · {npc:377} Priestess Josetta · {area:87} Goldshire · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["At 10 in {zone:1429}, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455} (the {area:2257} from {zone:1453}'s {object:28027})."] = "No nível 10, na {zone:1429}, {npc:377}, no andar de cima da Estalagem Orgulho do Leão, em {area:87}, entrega uma carta de {quest:5634} para {npc:11406}, em {zone:1455} (o {area:2257} a partir do {object:28027} de {zone:1453}).",
	-- {npc:377} Priestess Josetta · {quest:5634} Desperate Prayer
	["{npc:377}: take her {quest:5634} letter"] = "{npc:377}: pegue a carta de {quest:5634} dela",

	-- Step 3: Desperate Prayer: Nara Meideros
	-- {zone:1453} Stormwind · {npc:11397} Nara Meideros · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {npc:376} High Priestess Laurena
	["At 10 in {zone:1453}, {npc:11397}, the priest trainer in the Park (the night elf quarter on the city's west side), hands you a {quest:5634} letter for {npc:11406} in {zone:1455}. {npc:376} in the Cathedral has none for Dwarves."] = "No nível 10, em {zone:1453}, {npc:11397}, a instrutora de sacerdote no Parque (o bairro dos elfos noturnos, no lado oeste da cidade), entrega uma carta de {quest:5634} para {npc:11406}, em {zone:1455}. {npc:376}, na Catedral, não tem carta para anões.",
	-- {npc:11397} Nara Meideros · {quest:5634} Desperate Prayer
	["{npc:11397}: take her {quest:5634} letter"] = "{npc:11397}: pegue a carta de {quest:5634} dela",

	-- Step 4: Desperate Prayer: Laurna Morninglight
	-- {zone:1438} Teldrassil · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10 in {zone:1438}, {npc:3600}, in the building at the north edge of {area:186}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455}."] = "No nível 10, em {zone:1438}, {npc:3600}, no prédio da borda norte de {area:186}, entrega uma carta de {quest:5634} para {npc:11406}, em {zone:1455}.",
	-- {npc:3600} Laurna Morninglight · {quest:5634} Desperate Prayer
	["{npc:3600}: take her {quest:5634} letter"] = "{npc:3600}: pegue a carta de {quest:5634} dela",

	-- Step 5: Desperate Prayer: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455}."] = "No nível 10, em {zone:1457}, {npc:11401}, na sacada de cima do Templo da Lua, ao lado de {npc:7999}, entrega uma carta de {quest:5634} para {npc:11406}, em {zone:1455}.",
	-- {npc:11401} Priestess Alathea · {quest:5634} Desperate Prayer
	["{npc:11401}: take her {quest:5634} letter"] = "{npc:11401}: pegue a carta de {quest:5634} dela",

	-- Step 6: Desperate Prayer: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:5634} Desperate Prayer
	["At 10, go to {npc:11406} in the {object:32386}, in {zone:1455}'s {object:32362} (north-west of the city): he gives {quest:5634} and takes it back at once. No letter needed. {quest:5634} heals you instantly, costs no mana and has a long cooldown: keep it for emergencies."] = "No nível 10, vá até {npc:11406} no {object:32386}, na {object:32362} de {zone:1455} (noroeste da cidade): ele dá {quest:5634} e pega de volta na hora. Não precisa de carta. {quest:5634} cura você na hora, não gasta mana e tem recarga longa: guarde para emergências.",

	-- Step 7: Desperate Prayer: Maxan Anvol's letter
	-- {quest:5637} Desperate Prayer · {npc:1226} Maxan Anvol
	["{quest:5637}: {npc:1226}'s letter"] = "{quest:5637}: a carta de {npc:1226}",
	-- {area:131} Kharanos · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {quest:5637} Desperate Prayer · {zone:1453} Stormwind
	["Follow the road up from {area:131} into {zone:1455} and west to the {object:32362}: {npc:11406} in the {object:32386} takes the letter and teaches {quest:5637}. The letter tells you to head to {zone:1453}, but the one who wants you is Rohan in {zone:1455}."] = "Siga a estrada de {area:131} até {zone:1455} e para o oeste até a {object:32362}: {npc:11406}, no {object:32386}, pega a carta e ensina {quest:5637}. A carta manda você para {zone:1453}, mas quem quer você é Rohan, em {zone:1455}.",

	-- Step 8: Desperate Prayer: Josetta's letter
	-- {quest:5635} Desperate Prayer
	["{quest:5635}: Josetta's letter"] = "{quest:5635}: a carta de Joselita",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: the {area:2257} from {zone:1453}'s {object:28027}."] = "Entregue a carta a {npc:11406} no {object:32386}, na {object:32362} de {zone:1455}: pegue o {area:2257} no {object:28027} de {zone:1453}.",

	-- Step 9: Desperate Prayer: Nara's letter
	-- {quest:5638} Desperate Prayer
	["{quest:5638}: Nara's letter"] = "{quest:5638}: a carta de Nara",

	-- Step 10: Desperate Prayer: Laurna Morninglight's letter
	-- {quest:5636} Desperate Prayer · {npc:3600} Laurna Morninglight
	["{quest:5636}: {npc:3600}'s letter"] = "{quest:5636}: a carta de {npc:3600}",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1438} Teldrassil · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: from {zone:1438}, the boat from {area:702} to {area:442}, the boat to {area:150} and the road north through the {zone:1437} and {zone:1432} (or the boat to {area:17203} and the {area:2257})."] = "Entregue a carta a {npc:11406} no {object:32386}, na {object:32362} de {zone:1455}: de {zone:1438}, pegue o barco de {area:702} até {area:442}, o barco até {area:150} e a estrada para o norte por {zone:1437} e {zone:1432} (ou o barco até {area:17203} e o {area:2257}).",

	-- Step 11: Desperate Prayer: Alathea's letter
	-- {quest:5640} Desperate Prayer
	["{quest:5640}: Alathea's letter"] = "{quest:5640}: a carta de Alathea",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1453} Stormwind · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: its text says {zone:1453}, but Rohan is in {zone:1455}. From {zone:1457}, the portal down to {area:702}, the boat to {area:442}, then {area:150} and the road north (or {area:17203} and the {area:2257})."] = "Entregue a carta a {npc:11406} no {object:32386}, na {object:32362} de {zone:1455}: o texto da carta diz {zone:1453}, mas Rohan está em {zone:1455}. De {zone:1457}, pegue o portal para baixo até {area:702}, o barco até {area:442}, depois {area:150} e a estrada para o norte (ou {area:17203} e o {area:2257}).",

	-- Step 12: Desperate Prayer: an old letter
	-- {quest:5634} Desperate Prayer
	["{quest:5634}: an old letter"] = "{quest:5634}: uma carta antiga",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["This letter also goes to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}."] = "Esta carta também vai para {npc:11406} no {object:32386}, na {object:32362} de {zone:1455}.",

	-- Step 13: Chastise: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena · {quest:5641} Chastise · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:28027} Dwarven District
	["At 20 in {zone:1453}, {npc:376} at the altar of the Cathedral of Light hands you a {quest:5641} letter for {npc:11406} in {zone:1455} (the {area:2257} from the {object:28027})."] = "No nível 20, em {zone:1453}, {npc:376}, no altar da Catedral da Luz, entrega uma carta de {quest:5641} para {npc:11406}, em {zone:1455} (o {area:2257} a partir do {object:28027}).",
	-- {npc:376} High Priestess Laurena · {quest:5641} Chastise
	["{npc:376}: take her {quest:5641} letter"] = "{npc:376}: pegue a carta de {quest:5641} dela",

	-- Step 14: Chastise: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {quest:5641} Chastise · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 20 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a {quest:5641} letter for {npc:11406} in {zone:1455}."] = "No nível 20, em {zone:1457}, {npc:11401}, na sacada de cima do Templo da Lua, ao lado de {npc:7999}, entrega uma carta de {quest:5641} para {npc:11406}, em {zone:1455}.",
	-- {npc:11401} Priestess Alathea · {quest:5641} Chastise
	["{npc:11401}: take her {quest:5641} letter"] = "{npc:11401}: pegue a carta de {quest:5641} dela",

	-- Step 15: Chastise: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {quest:5641} Chastise · {spell:6346} Fear Ward
	["At 20, {npc:11406} in the {object:32386} teaches {quest:5641} with a quest he gives and takes back at once. Forever renamed it from A Lack of Fear: {quest:5641} damages a humanoid and roots it for 2 seconds (instant, 2-minute cooldown), and every priest now trains {spell:6346}."] = "No nível 20, {npc:11406}, no {object:32386}, ensina {quest:5641} com uma missão que ele dá e pega de volta na hora. O Forever a renomeou de O medo é para os fracos: {quest:5641} causa dano a um humanoide e o prende por 2 segundos (instantâneo, recarga de 2 minutos), e agora todo sacerdote treina {spell:6346}.",

	-- Step 16: Chastise: Laurena's letter
	-- {quest:5645} Chastise
	["{quest:5645}: Laurena's letter"] = "{quest:5645}: a carta de Laurena",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:5645} Chastise
	["Hand Laurena's letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: he teaches {quest:5645}."] = "Entregue a carta de Laurena a {npc:11406} no {object:32386}, na {object:32362} de {zone:1455}: ele ensina {quest:5645}.",

	-- Step 17: Chastise: Alathea's letter
	-- {quest:5647} Chastise
	["{quest:5647}: Alathea's letter"] = "{quest:5647}: a carta de Alathea",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand Alathea's letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: from {zone:1457}, the boats via {area:702} and {area:442} to {area:150}, then the road north through the {zone:1437} and {zone:1432} (or the boat to {area:17203} and the {area:2257})."] = "Entregue a carta de Alathea a {npc:11406} no {object:32386}, na {object:32362} de {zone:1455}: de {zone:1457}, os barcos por {area:702} e {area:442} até {area:150}, depois a estrada para o norte por {zone:1437} e {zone:1432} (ou o barco até {area:17203} e o {area:2257}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:11406} in the {object:32386}, in {zone:1455}'s {object:32362}. Forever's quest text names Rohan, but the quest data has {npc:376} in {zone:1453}'s Cathedral of Light take it: try Rohan first, then Laurena (the {area:2257} links the cities)."] = "No nível 10, vá até {npc:11406} no {object:32386}, na {object:32362} de {zone:1455}. O texto da missão no Forever cita Rohan, mas pelos dados quem a recebe é {npc:376}, na Catedral da Luz de {zone:1453}: tente Rohan primeiro, depois Laurena (o {area:2257} liga as cidades).",
	-- ["At 20, {npc:11406} teaches {quest:5641}. {npc:376} in {zone:1453} and {npc:11401} in {zone:1457} send you to him with a quest of the same name."] = "No nível 20, {npc:11406} ensina {quest:5641}. {npc:376}, em {zone:1453}, e {npc:11401}, em {zone:1457}, enviam você a ele com uma missão de mesmo nome.",
	-- ["If Rohan did not take it: {npc:376} is in the Cathedral of Light. Take the {area:2257} from {object:171524}."] = "Se Rohan não aceitar: {npc:376} está na Catedral da Luz. Pegue o {area:2257} em {object:171524}.",
	-- ["The Human and Dwarf priest spells: {quest:5634} at 10, {quest:5641} for Dwarves at 20."] = "Os feitiços de sacerdote de Humanos e Anões: {quest:5634} no nível 10, {quest:5641} para Anões no nível 20.",
}
