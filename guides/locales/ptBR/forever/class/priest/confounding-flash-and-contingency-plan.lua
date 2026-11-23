-- Portuguese (Brazil) (ptBR): the guide forever/class/priest/confounding-flash-and-contingency-plan (forever/class/priest/confounding-flash-and-contingency-plan.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94817} Confounding Flash · {quest:94818} Contingency Plan
	["{quest:94817} and {quest:94818}"] = "{quest:94817} e {quest:94818}",
	-- {quest:94817} Confounding Flash · {quest:94818} Contingency Plan
	["The Gnome priest spells, new in Forever: {quest:94817} at 10, {quest:94818} at 20. Free, no objectives."] = "As magias do sacerdote gnomo, novas no Forever: {quest:94817} no nível 10, {quest:94818} no 20. De graça, sem objetivos.",

	-- Step 1: Confounding Flash: Maxan Anvol
	-- {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {quest:94817} Confounding Flash · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["At 10, {npc:1226}, the priest trainer inside the {area:2102} in {area:131}, hands you a {quest:94817} letter for {npc:258785} in {zone:1455}. {area:131} is on the road up to the city."] = "No nível 10, {npc:1226}, o instrutor de sacerdote dentro da {area:2102}, em {area:131}, entrega uma carta de {quest:94817} para {npc:258785}, em {zone:1455}. {area:131} fica na estrada que sobe até a cidade.",
	-- {npc:1226} Maxan Anvol · {quest:94817} Confounding Flash
	["{npc:1226}: take his {quest:94817} letter"] = "{npc:1226}: pegue a carta de {quest:94817} dele",

	-- Step 2: Confounding Flash: Priestess Josetta
	-- {zone:1429} Elwynn Forest · {npc:377} Priestess Josetta · {area:87} Goldshire · {quest:94817} Confounding Flash · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["At 10 in {zone:1429}, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you a {quest:94817} letter for {npc:258785} in {zone:1455}."] = "No nível 10, em {zone:1429}, {npc:377}, no andar de cima da Estalagem Orgulho do Leão, em {area:87}, entrega uma carta de {quest:94817} para {npc:258785}, em {zone:1455}.",
	-- {npc:377} Priestess Josetta · {quest:94817} Confounding Flash
	["{npc:377}: take her {quest:94817} letter"] = "{npc:377}: pegue a carta de {quest:94817} dela",

	-- Step 3: Confounding Flash: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena · {quest:94817} Confounding Flash · {npc:258785} High Priestess Mims · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:28027} Dwarven District
	["At 10 in {zone:1453}, {npc:376} at the altar of the Cathedral of Light hands you a {quest:94817} letter for {npc:258785} in {zone:1455} (the {area:2257} from the {object:28027})."] = "No nível 10, em {zone:1453}, {npc:376}, no altar da Catedral da Luz, entrega uma carta de {quest:94817} para {npc:258785}, em {zone:1455} (o {area:2257} a partir do {object:28027}).",
	-- {npc:376} High Priestess Laurena · {quest:94817} Confounding Flash
	["{npc:376}: take her {quest:94817} letter"] = "{npc:376}: pegue a carta de {quest:94817} dela",

	-- Step 4: Confounding Flash: High Priestess Mims
	-- {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:11406} High Priest Rohan · {quest:94817} Confounding Flash
	["At 10, go to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362} (north-west of the city), right beside {npc:11406}: she gives {quest:94817} and takes it back at once. No letter needed. {quest:94817} confuses up to five enemies around you for 3 seconds (any damage wakes them) on a 2-minute cooldown: time to step back and heal, or to run."] = "No nível 10, vá até {npc:258785} no {object:32386}, na {object:32362} de {zone:1455} (noroeste da cidade), bem ao lado de {npc:11406}: ela dá {quest:94817} e pega de volta na hora. Não precisa de carta. {quest:94817} confunde até cinco inimigos ao seu redor por 3 segundos (qualquer dano os acorda), com recarga de 2 minutos: tempo para recuar e curar, ou para fugir.",

	-- Step 5: Confounding Flash: Maxan Anvol's letter
	-- {quest:94824} Confounding Flash · {npc:1226} Maxan Anvol
	["{quest:94824}: {npc:1226}'s letter"] = "{quest:94824}: a carta de {npc:1226}",
	-- {area:131} Kharanos · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {quest:94824} Confounding Flash
	["Follow the road up from {area:131} into {zone:1455} and to the {object:32362}: {npc:258785} in the {object:32386} takes the letter and teaches {quest:94824}."] = "Siga a estrada de {area:131} até {zone:1455} e até a {object:32362}: {npc:258785}, no {object:32386}, pega a carta e ensina {quest:94824}.",

	-- Step 6: Confounding Flash: Josetta's letter
	-- {quest:94822} Confounding Flash
	["{quest:94822}: Josetta's letter"] = "{quest:94822}: a carta de Joselita",
	-- {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["Hand the letter to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}: the {area:2257} from {zone:1453}'s {object:28027}."] = "Entregue a carta a {npc:258785} no {object:32386}, na {object:32362} de {zone:1455}: pegue o {area:2257} no {object:28027} de {zone:1453}.",

	-- Step 7: Confounding Flash: Laurena's letter
	-- {quest:94821} Confounding Flash
	["{quest:94821}: Laurena's letter"] = "{quest:94821}: a carta de Laurena",

	-- Step 8: Confounding Flash: a letter from another trainer
	-- {quest:94823} Confounding Flash
	["{quest:94823}: a letter from another trainer"] = "{quest:94823}: uma carta de outro instrutor",
	-- {quest:94823} Confounding Flash · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["Any {quest:94823} letter goes to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}."] = "Qualquer carta de {quest:94823} vai para {npc:258785} no {object:32386}, na {object:32362} de {zone:1455}.",

	-- Step 9: Confounding Flash: a letter from another trainer
	-- {quest:94825} Confounding Flash
	["{quest:94825}: a letter from another trainer"] = "{quest:94825}: uma carta de outro instrutor",
	-- {quest:94825} Confounding Flash · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["Any {quest:94825} letter goes to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}."] = "Qualquer carta de {quest:94825} vai para {npc:258785} no {object:32386}, na {object:32362} de {zone:1455}.",

	-- Step 10: Confounding Flash: a letter from another trainer
	-- {quest:94826} Confounding Flash
	["{quest:94826}: a letter from another trainer"] = "{quest:94826}: uma carta de outro instrutor",
	-- {quest:94826} Confounding Flash · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["Any {quest:94826} letter goes to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}."] = "Qualquer carta de {quest:94826} vai para {npc:258785} no {object:32386}, na {object:32362} de {zone:1455}.",

	-- Step 11: Contingency Plan: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena · {quest:94818} Contingency Plan · {npc:258785} High Priestess Mims · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:28027} Dwarven District
	["At 20 in {zone:1453}, {npc:376} at the altar of the Cathedral of Light hands you a {quest:94818} letter for {npc:258785} in {zone:1455} (the {area:2257} from the {object:28027})."] = "No nível 20, em {zone:1453}, {npc:376}, no altar da Catedral da Luz, entrega uma carta de {quest:94818} para {npc:258785}, em {zone:1455} (o {area:2257} a partir do {object:28027}).",
	-- {npc:376} High Priestess Laurena · {quest:94818} Contingency Plan
	["{npc:376}: take her {quest:94818} letter"] = "{npc:376}: pegue a carta de {quest:94818} dela",

	-- Step 12: Contingency Plan: High Priestess Mims
	-- {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {quest:94818} Contingency Plan · {spell:139} Renew · {spell:17} Power Word: Shield
	["At 20, {npc:258785} in the {object:32386} teaches {quest:94818} with a quest she gives and takes back at once. {quest:94818} wards a friend for 30 seconds: if they drop below 35% health, they get a shield and a heal over time at once (it stacks with {spell:139} and {spell:17}). 5-minute cooldown."] = "No nível 20, {npc:258785}, no {object:32386}, ensina {quest:94818} com uma missão que ela dá e pega de volta na hora. {quest:94818} protege um amigo por 30 segundos: se a vida dele cair abaixo de 35%, ele ganha na hora um escudo e uma cura contínua (acumula com {spell:139} e {spell:17}). Recarga de 5 minutos.",

	-- Step 13: Contingency Plan: Laurena's letter
	-- {quest:94819} Contingency Plan
	["{quest:94819}: Laurena's letter"] = "{quest:94819}: a carta de Laurena",
	-- {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["Hand Laurena's letter to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}: the {area:2257} from {zone:1453}'s {object:28027}."] = "Entregue a carta de Laurena a {npc:258785} no {object:32386}, na {object:32362} de {zone:1455}: pegue o {area:2257} no {object:28027} de {zone:1453}.",

	-- Step 14: Contingency Plan: a letter from another trainer
	-- {quest:94820} Contingency Plan
	["{quest:94820}: a letter from another trainer"] = "{quest:94820}: uma carta de outro instrutor",
	-- {quest:94820} Contingency Plan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["Any {quest:94820} letter goes to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}."] = "Qualquer carta de {quest:94820} vai para {npc:258785} no {object:32386}, na {object:32362} de {zone:1455}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:258785} in the {object:32386}, in {zone:1455}'s {object:32362}. {npc:1226} in {area:131}, {npc:377} in {area:87} and {npc:376} in {zone:1453} send you to her with a quest of the same name (its text may say {zone:1453}: Mims is in {zone:1455})."] = "No nível 10, vá até {npc:258785} no {object:32386}, na {object:32362} de {zone:1455}. {npc:1226} em {area:131}, {npc:377} em {area:87} e {npc:376} em {zone:1453} mandam você até ela com uma missão de mesmo nome (o texto pode dizer {zone:1453}: Mims está em {zone:1455}).",
	-- ["At 20, {npc:258785} teaches {quest:94818}. {npc:376} in {zone:1453} sends you to her with a quest of the same name."] = "No nível 20, {npc:258785} ensina {quest:94818}. {npc:376} em {zone:1453} manda você até ela com uma missão de mesmo nome.",
	-- ["The Gnome priest spells, new in Forever: one at 10, one at 20."] = "Os feitiços de sacerdote gnomo, novos no Forever: um no nível 10, outro no 20.",
}
