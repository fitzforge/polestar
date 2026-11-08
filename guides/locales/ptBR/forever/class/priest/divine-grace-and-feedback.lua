-- Portuguese (Brazil) (ptBR): the guide forever/class/priest/divine-grace-and-feedback (forever/class/priest/divine-grace-and-feedback.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["{quest:94773} and {spell:13896}"] = "{quest:94773} e {spell:13896}",
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["The Human priest spells: {quest:94773} at 10 (new in Forever), {spell:13896} at 20. Free, no objectives."] = "As magias do sacerdote humano: {quest:94773} no nível 10 (nova no Forever), {spell:13896} no 20. De graça, sem objetivos.",

	-- Step 1: Divine Grace: Priestess Josetta
	-- {npc:377} Priestess Josetta · {area:87} Goldshire · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["At 10, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you a letter for {npc:376}. {area:87} is on the road north to {zone:1453}, so it costs no detour."] = "No nível 10, {npc:377}, no andar de cima da Estalagem Orgulho do Leão, em {area:87}, entrega uma carta para {npc:376}. {area:87} fica na estrada para o norte, rumo a {zone:1453}, então não é desvio.",
	-- {npc:377} Priestess Josetta · {quest:94773} Divine Grace
	["{npc:377}: take her {quest:94773} letter"] = "{npc:377}: pegue a carta de {quest:94773} dela",

	-- Step 2: Divine Grace: Laurna Morninglight
	-- {zone:1438} Teldrassil · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["A Human priest in {zone:1438} at 10: {npc:3600}, in the building at the north edge of {area:186}, hands you a letter for {npc:376} in {zone:1453}."] = "Um sacerdote humano em {zone:1438} no nível 10: {npc:3600}, no prédio da borda norte de {area:186}, entrega uma carta para {npc:376}, em {zone:1453}.",
	-- {npc:3600} Laurna Morninglight · {quest:94773} Divine Grace
	["{npc:3600}: take her {quest:94773} letter"] = "{npc:3600}: pegue a carta de {quest:94773} dela",

	-- Step 3: Divine Grace: High Priestess Laurena
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {object:2098} Cathedral Square · {quest:94773} Divine Grace · {spell:6788} Weakened Soul
	["At 10, go to {npc:376} at the altar of the Cathedral of Light, in {zone:1453}'s {object:2098}, and take her quest: she teaches {quest:94773} on the spot. No letter needed; one from another trainer works too (next steps). {quest:94773} instantly heals a friend below half health and clears {spell:6788}, so you can shield them again (5-minute cooldown); it does not work on yourself. Human priests do not get Desperate Prayer in Forever: this is their spell instead."] = "No nível 10, vá até {npc:376}, no altar da Catedral da Luz, na {object:2098} de {zone:1453}, e pegue a missão dela: ela ensina {quest:94773} na hora. Não precisa de carta; uma de outro instrutor também serve (próximos passos). {quest:94773} cura na hora um amigo com menos de metade da vida e remove {spell:6788}, para você poder protegê-lo com o escudo de novo (recarga de 5 minutos); não funciona em você mesmo. Os sacerdotes humanos não recebem Prece desesperada no Forever: esta é a magia deles no lugar.",

	-- Step 4: Divine Grace: Josetta's letter
	-- {quest:94774} Divine Grace
	["{quest:94774}: Josetta's letter"] = "{quest:94774}: a carta de Joselita",
	-- {npc:376} High Priestess Laurena · {quest:94774} Divine Grace
	["Hand Josetta's letter to {npc:376} at the altar of the Cathedral of Light: she teaches {quest:94774}."] = "Entregue a carta de Joselita a {npc:376} no altar da Catedral da Luz: ela ensina {quest:94774}.",

	-- Step 5: Divine Grace: Laurna Morninglight's letter
	-- {quest:94775} Divine Grace · {npc:3600} Laurna Morninglight
	["{quest:94775}: {npc:3600}'s letter"] = "{quest:94775}: a carta de {npc:3600}",
	-- {npc:3600} Laurna Morninglight · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {zone:1438} Teldrassil · {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor · {quest:94775} Divine Grace
	["Hand {npc:3600}'s letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (from {zone:1438}: the boat from {area:702} to {area:442}, then the boat to {area:17203}): she teaches {quest:94775}."] = "Entregue a carta de {npc:3600} a {npc:376} no altar da Catedral da Luz de {zone:1453} (saindo de {zone:1438}: o barco de {area:702} até {area:442}, depois o barco até {area:17203}): ela ensina {quest:94775}.",

	-- Step 6: Divine Grace: a letter from another trainer
	-- {quest:94776} Divine Grace
	["{quest:94776}: a letter from another trainer"] = "{quest:94776}: uma carta de outro instrutor",
	-- {quest:94776} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94776} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Qualquer carta de {quest:94776} vai para {npc:376} no altar da Catedral da Luz.",

	-- Step 7: Divine Grace: a letter from another trainer
	-- {quest:94777} Divine Grace
	["{quest:94777}: a letter from another trainer"] = "{quest:94777}: uma carta de outro instrutor",
	-- {quest:94777} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94777} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Qualquer carta de {quest:94777} vai para {npc:376} no altar da Catedral da Luz.",

	-- Step 8: Divine Grace: a letter from another trainer
	-- {quest:94778} Divine Grace
	["{quest:94778}: a letter from another trainer"] = "{quest:94778}: uma carta de outro instrutor",
	-- {quest:94778} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94778} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Qualquer carta de {quest:94778} vai para {npc:376} no altar da Catedral da Luz.",

	-- Step 9: Divine Grace: a letter from another trainer
	-- {quest:94779} Divine Grace
	["{quest:94779}: a letter from another trainer"] = "{quest:94779}: uma carta de outro instrutor",
	-- {quest:94779} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94779} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Qualquer carta de {quest:94779} vai para {npc:376} no altar da Catedral da Luz.",

	-- Step 10: Feedback: High Priest Rohan
	-- {zone:1455} Ironforge · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town
	["At 20 in {zone:1455}, {npc:11406} in the {object:32386} ({object:32362}) hands you a letter for {npc:376} in {zone:1453}. The {area:2257} from {object:171524} takes you there."] = "No nível 20, em {zone:1455}, {npc:11406}, no {object:32386} ({object:32362}), entrega uma carta para {npc:376} em {zone:1453}. O {area:2257} a partir de {object:171524} leva você até lá.",
	-- {npc:11406} High Priest Rohan · {quest:5676} Arcane Feedback
	["{npc:11406}: take his {quest:5676} letter"] = "{npc:11406}: pegue a carta de {quest:5676} dele",

	-- Step 11: Feedback: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["At 20 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a letter for {npc:376} in {zone:1453}."] = "No nível 20, em {zone:1457}, {npc:11401}, na sacada de cima do Templo da Lua, ao lado de {npc:7999}, entrega uma carta para {npc:376}, em {zone:1453}.",
	-- {npc:11401} Priestess Alathea · {quest:5676} Arcane Feedback
	["{npc:11401}: take her {quest:5676} letter"] = "{npc:11401}: pegue a carta de {quest:5676} dela",

	-- Step 12: Feedback: High Priestess Laurena
	-- {npc:376} High Priestess Laurena · {spell:13896} Feedback
	["At 20, {npc:376} at the altar of the Cathedral of Light teaches {spell:13896} with a quest she gives and takes back at once."] = "No nível 20, {npc:376}, no altar da Catedral da Luz, ensina {spell:13896} com uma missão que ela dá e recolhe de volta na hora.",

	-- Step 13: Feedback: Rohan's letter
	-- {spell:13896} Feedback
	["{spell:13896}: Rohan's letter"] = "{spell:13896}: a carta de Rohan",
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1455} Ironforge · {spell:13896} Feedback
	["Hand Rohan's letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (the {area:2257} from {object:171524} in {zone:1455}): she teaches {spell:13896}."] = "Entregue a carta de Rohan a {npc:376} no altar da Catedral da Luz de {zone:1453} (o {area:2257} a partir de {object:171524}, em {zone:1455}): ela ensina {spell:13896}.",

	-- Step 14: Feedback: Alathea's letter
	-- {spell:13896} Feedback
	["{spell:13896}: Alathea's letter"] = "{spell:13896}: a carta de Alathea",
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor · {spell:13896} Feedback
	["Hand Alathea's letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (from {zone:1457}: the portal down to {area:702}, the boat to {area:442}, then the boat to {area:17203}): she teaches {spell:13896}."] = "Entregue a carta de Alathea a {npc:376} no altar da Catedral da Luz de {zone:1453} (saindo de {zone:1457}: o portal até {area:702}, o barco até {area:442} e depois o barco até {area:17203}): ela ensina {spell:13896}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:376} in the Cathedral of Light. {npc:377} in {area:87} sends you to her with a quest of the same name."] = "No nível 10, vá até {npc:376} na Catedral da Luz. {npc:377}, em {area:87}, envia você a ela com uma missão de mesmo nome.",
	-- ["At 20, {npc:376} teaches {spell:13896}. {npc:11406} in {zone:1455} and {npc:11401} in {zone:1457} send you to her with a quest of the same name."] = "No nível 20, {npc:376} ensina {spell:13896}. {npc:11406}, em {zone:1455}, e {npc:11401}, em {zone:1457}, enviam você a ela com uma missão de mesmo nome.",
	-- ["The Human priest spells: {quest:94773} at 10, {spell:13896} at 20."] = "Os feitiços de sacerdote humano: {quest:94773} no nível 10, {spell:13896} no 20.",
}
