-- Portuguese (Brazil) (ptBR): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "Reputação: Senhores das Águas Hidraxianos",
	-- {item:17333} Aqual Quintessence · {area:2717} Molten Core · {item:22754} Eternal Quintessence
	["{item:17333} to douse the {area:2717}'s runes, the reusable {item:22754} at Revered and a fire resistance ring."] = "{item:17333} para apagar as runas de {area:2717}, a {item:22754} reutilizável em Reverenciado e um anel de resistência ao fogo.",

	-- Step 1: Duke Hydraxis
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara · {area:2717} Molten Core
	["{npc:13278} stands on a small island off the east coast of {zone:1447}; swim out to him. Everyone starts Neutral with the Waterlords, and nearly all of their reputation comes from killing the servants of fire, air and earth: the quests themselves pay nothing until the last one. Take both quests: the chain goes on only when both are done. Everything past Honored happens in the {area:2717}, a raid of 40 that is not among the first raids Blizzard has announced for Forever; until it opens, Honored is as far as the Waterlords go. The numbers in this guide leave out the Legacy perk Diplomat, which adds up to 10%."] = "{npc:13278} fica numa ilhota na costa leste de {zone:1447}; vá a nado até ele. Todo mundo começa Neutro com os Senhores das Águas, e quase toda a reputação deles vem de matar os servos do fogo, do ar e da terra: as missões em si não pagam nada até a última. Pegue as duas missões: a cadeia só segue quando as duas estiverem feitas. Tudo depois de Honrado acontece em {area:2717}, uma raide de 40 que não está entre as primeiras raides anunciadas pela Blizzard para o Forever; até ela abrir, Honrado é o limite com os Senhores das Águas. Os números deste guia não incluem a vantagem de Legado Diplomata, que soma até 10%.",

	-- Step 2: Stormers and Rumblers
	-- {area:2740} Crystal Vale · {zone:1451} Silithus
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["Dust Stormers and Desert Rumblers drift around the {area:2740} in the north-west of {zone:1451}. Each kill also pays 5 reputation while you are Neutral or Friendly, so stay if you mean to farm (next steps)."] = "Tempestades de Poeira e Estrondores do Deserto vagam por {area:2740}, no noroeste de {zone:1451}. Cada morte também rende 5 de reputação enquanto você está Neutro ou Amigável, então fique se for farmar (próximos passos).",

	-- Step 3: Poisoned Water
	-- {item:17310} Aspect of Neptulon · {npc:8521} Blighted Horror · {npc:8522} Plague Monstrosity · {npc:13279} Discordant Surge · {item:17309} Discordant Bracers
	["Use the {item:17310} on a {npc:8521} or a {npc:8522}: it turns into a {npc:13279}. Kill the surge and loot its {item:17309}. Twelve are needed, and the vial must still be in your bags at the turn-in."] = "Use o {item:17310} em um {npc:8521} ou um {npc:8522}: ele vira um {npc:13279}. Mate o surto e saqueie as {item:17309}. São necessários doze, e o frasco ainda precisa estar nas suas bolsas na hora da entrega.",
	-- {item:17310} Aspect of Neptulon
	["{item:17310}, on the poisoned elementals"] = "{item:17310}, nos elementais envenenados",

	-- Step 4: Back to Duke Hydraxis
	-- {npc:13278} Duke Hydraxis
	["Back to {npc:13278}"] = "Volte a {npc:13278}",

	-- Step 5: Eye of the Emberseer
	-- {npc:9816} Pyroguard Emberseer · {area:254} Blackrock Mountain · {item:12344} Seal of Ascension · {npc:9017} Lord Incendius · {area:1584} Blackrock Depths
	["{npc:9816} is a boss in Upper Blackrock Spire, inside {area:254}: a group of up to ten, and someone needs the {item:12344} to open the door. He drops the Eye and pays 50 reputation per kill up to 11,999 of 12,000 Honored. {npc:9017} in {area:1584} pays 15 the same way."] = "{npc:9816} é um chefe do Pico da Rocha Negra Superior, dentro de {area:254}: um grupo de até dez, e alguém precisa do {item:12344} para abrir a porta. Ele solta o Olho e rende 50 de reputação por morte até 11.999 de 12.000 de Honrado. {npc:9017} em {area:1584} rende 15 do mesmo jeito.",
	-- {quest:6821} Eye of the Emberseer
	["{quest:6821}: raid of ten"] = "{quest:6821}: raide de dez",

	-- Step 6: Attunement to the Core
	-- {npc:14387} Lothos Riftwaker · {area:254} Blackrock Mountain · {area:2717} Molten Core · {item:18412} Core Fragment · {area:1584} Blackrock Depths
	["{npc:14387} in {area:254} attunes you to the {area:2717}: bring him a {item:18412} from beside the {area:2717}'s portal at the bottom of {area:1584}. Once attuned, he can send you straight into the {area:2717}."] = "{npc:14387} em {area:254} sintoniza você com {area:2717}: leve a ele um {item:18412} do lado do portal de {area:2717}, no fundo de {area:1584}. Depois de sintonizado, ele pode enviar você direto para {area:2717}.",
	-- {item:18412} Core Fragment · {area:1584} Blackrock Depths
	["{item:18412}, at the portal in {area:1584}"] = "{item:18412}, no portal de {area:1584}",

	-- Step 7: The Molten Core
	-- {quest:6822} The Molten Core · {npc:11658} Molten Giant · {npc:11668} Firelord · {npc:11673} Ancient Core Hound · {npc:12101} Lava Surger · {npc:13278} Duke Hydraxis · {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	-- plural, as words: Firewalkers = {npc:11666} Firewalker · Flameguards = {npc:11667} Flameguard · Lava Elementals = {npc:12076} Lava Elemental · Lava Reavers = {npc:12100} Lava Reaver · Molten Destroyers = {npc:11659} Molten Destroyer · Firelords = {npc:11668} Firelord · Lava Surgers = {npc:12101} Lava Surger · Molten Giants = {npc:11658} Molten Giant · Ancient Core Hounds = {npc:11673} Ancient Core Hound
	["{quest:6822} is a raid of 40. Kill one {npc:11658}, {npc:11668}, {npc:11673} and {npc:12101} for {npc:13278}. Every elemental there pays: Firewalkers, Flameguards, Lava Elementals, Lava Reavers and Molten Destroyers 40, Firelords, Lava Surgers, Molten Giants and Ancient Core Hounds 20, up to 11,999 of 12,000 Honored; about 3,360 for a full clear of the trash. The bosses pay 100 each ({npc:11988} 150, {npc:11502} 200)."] = "{quest:6822} é uma raide de 40. Mate um {npc:11658}, um {npc:11668}, um {npc:11673} e um {npc:12101} para {npc:13278}. Todo elemental de lá rende: Andarilhos Ígneos, Guardiões das Chamas, Elementais da Lava, Aniquiladores de Lava, Destruidores Derretidos 40; Senhores do Fogo, Irrompedores de Lava, Gigantes Derretidos e Cães-magma Anciões 20, até 11.999 de 12.000 de Honrado; cerca de 3.360 por uma limpeza completa dos lacaios. Os chefes rendem 100 cada ({npc:11988} 150, {npc:11502} 200).",
	-- {npc:11658} Molten Giant
	["{npc:11658}: raid of 40"] = "{npc:11658}: raide de 40",

	-- Step 8: Elementals to Honored
	["Elementals to Honored"] = "Elementais até Honrado",
	-- {quest:6823} Agent of Hydraxis · {area:2717} Molten Core · {npc:11744} Dust Stormer · {npc:11746} Desert Rumbler · {npc:7032} Greater Obsidian Elemental · {zone:1428} Burning Steppes · {npc:14478} Huricanian · {area:2740} Crystal Vale · {npc:9017} Lord Incendius · {object:174825} Black Anvil (no name in this language: may be words) · {area:1584} Blackrock Depths · {npc:9816} Pyroguard Emberseer
	["Neutral to Honored is 9,000 reputation, and {quest:6823} asks for Honored. One {area:2717} clear pays about 4,000 of it. Without a raid it comes from the elementals: 5 per {npc:11744}, {npc:11746} or {npc:7032} (the {zone:1428}), about 1,800 kills from Neutral. They stop at 5,999 of 6,000 Friendly, one point short, so the last point needs a kill that still counts there: {npc:14478}, a rare air elemental in the {area:2740} (25), or {npc:9017} at the {object:174825} in {area:1584} (15, a five-player dungeon). Those two and {npc:9816} keep paying through Honored as well."] = "De Neutro a Honrado são 9.000 de reputação, e {quest:6823} pede Honrado. Uma limpeza de {area:2717} rende cerca de 4.000 disso. Sem raide, vem dos elementais: 5 por {npc:11744}, {npc:11746} ou {npc:7032} (de {zone:1428}), cerca de 1.800 mortes a partir de Neutro. Eles param em 5.999 de 6.000 de Amigável, um ponto antes, então o último ponto exige uma morte que ainda conte ali: {npc:14478}, um elemental do ar raro em {area:2740} (25), ou {npc:9017} em {object:174825}, em {area:1584} (15, uma masmorra de cinco jogadores). Esses dois e {npc:9816} continuam rendendo também durante Honrado.",
	-- {npc:14478} Huricanian
	["{npc:14478}, rare, 25"] = "{npc:14478}, raro, 25",
	-- {npc:9017} Lord Incendius · {area:1584} Blackrock Depths
	["{npc:9017}, {area:1584}: 15, group up"] = "{npc:9017}, {area:1584}: 15, forme grupo",

	-- Step 9: Agent of Hydraxis
	-- {npc:13278} Duke Hydraxis · {quest:6823} Agent of Hydraxis
	["Back to {npc:13278}. {quest:6823} is done the moment you are Honored."] = "Volte a {npc:13278}. {quest:6823} fica pronta no instante em que você chega a Honrado.",

	-- Step 10: Hands of the Enemy
	-- {npc:12118} Lucifron · {npc:12259} Gehennas · {npc:12264} Shazzrah · {npc:12098} Sulfuron Harbinger · {area:2717} Molten Core
	["{npc:12118}, {npc:12259}, {npc:12264} and {npc:12098} are {area:2717} bosses: each drops his hand for the quest."] = "{npc:12118}, {npc:12259}, {npc:12264} e {npc:12098} são chefes de {area:2717}: cada um solta a mão dele para a missão.",
	-- {item:17332} Hand of Shazzrah
	["{item:17332}: raid of 40"] = "{item:17332}: raide de 40",

	-- Step 11: A Hero's Reward
	-- {object:179551} Hydraxis' Coffer · {item:17333} Aqual Quintessence · {area:2717} Molten Core · {npc:12018} Majordomo Executus · {npc:11502} Ragnaros
	["Hand in the hands, then dive under the surf at the southern foot of the island: {object:179551} holds your ring and pays the only quest reputation the Waterlords give, 200. From now on, while you are Honored or better, the Duke hands you {item:17333}: pour it on a rune in the {area:2717} to douse it. With every rune doused, {npc:12018} comes out, and after him {npc:11502}."] = "Entregue as mãos e depois mergulhe sob a arrebentação, no pé sul da ilha: {object:179551} guarda seu anel e paga a única reputação de missão que os Senhores das Águas dão, 200. A partir daí, enquanto você for Honrado ou melhor, o Duque entrega a você {item:17333}: derrame-a numa runa em {area:2717} para apagá-la. A cada runa apagada, {npc:12018} aparece, e depois dele {npc:11502}.",
	-- {item:17333} Aqual Quintessence
	["{item:17333}, ask the Duke"] = "{item:17333}, peça ao Duque",

	-- Step 12: Molten Core to Revered
	-- {area:2717} Molten Core
	["{area:2717} to Revered"] = "{area:2717} até Reverenciado",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros · {npc:9017} Lord Incendius · {npc:9816} Pyroguard Emberseer
	["Honored to Revered is 12,000 reputation. The trash still counts, so a full clear pays about 3,360 plus 700 from the seven bosses, 150 from {npc:11988} and 200 from {npc:11502}: about three clears. {npc:9017} (15) and {npc:9816} (50) count too while you are Honored. The trash stops at 11,999 of 12,000 Honored; the bosses carry you over."] = "De Honrado a Reverenciado são 12.000 de reputação. Os lacaios ainda contam, então uma limpeza completa rende cerca de 3.360, mais 700 dos sete chefes, 150 de {npc:11988} e 200 de {npc:11502}: cerca de três limpezas. {npc:9017} (15) e {npc:9816} (50) também contam enquanto você é Honrado. Os lacaios param em 11.999 de 12.000 de Honrado; os chefes levam você além.",
	-- {npc:12118} Lucifron
	["{npc:12118} and the other bosses, 100: they carry you past 11,999"] = "{npc:12118} e os outros chefes, 100: eles levam você além de 11.999",

	-- Step 13: The Eternal Quintessence
	-- {item:22754} Eternal Quintessence
	["The {item:22754}"] = "A {item:22754}",
	-- {item:22754} Eternal Quintessence · {item:17333} Aqual Quintessence
	["At Revered the Duke gives you the {item:22754}: it does the {item:17333}'s work and is not used up, so you never come back for another vial."] = "Em Reverenciado, o Duque entrega a você a {item:22754}: ele faz o trabalho de {item:17333} e não se gasta, então você nunca precisa voltar por outro frasco.",
	-- {item:22754} Eternal Quintessence
	["{item:22754}, ask the Duke"] = "{item:22754}, peça ao Duque",

	-- Step 14: Molten Core to Exalted
	-- {area:2717} Molten Core
	["{area:2717} to Exalted"] = "{area:2717} até Exaltado",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	["Revered to Exalted is 21,000 reputation. The trash has stopped, but all nine bosses still pay while you are Revered: 100 each from the seven, 150 from {npc:11988} and 200 from {npc:11502}, 1,050 a clear: about 20 clears. The seven stop at 20,999 of 21,000 Revered, so the last point comes from {npc:11988} or {npc:11502}, and from Exalted on only those two pay."] = "De Reverenciado a Exaltado são 21.000 de reputação. Os lacaios já pararam, mas todos os nove chefes ainda rendem enquanto você é Reverenciado: 100 cada dos sete, 150 de {npc:11988} e 200 de {npc:11502}, 1.050 por limpeza: cerca de 20 limpezas. Os sete param em 20.999 de 21.000 de Reverenciado, então o último ponto vem de {npc:11988} ou {npc:11502}, e de Exaltado em diante só esses dois rendem.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "Os dois elementais vagam pelo noroeste de {zone:1451}; os Estrondores ficam um pouco mais ao norte.",
	-- ["Bring the Hands of Lucifron, Gehennas, Shazzrah and Sulfuron from the {area:2717}."] = "Traga as Mãos de Lúcifron, Geena, Shazzrah e Sulfuron de {area:2717}.",
	-- ["Dust Stormers and Desert Rumblers"] = "Tempestades de Poeira e Estrondores do Deserto",
	-- ["Keep clearing the {area:2717} until Exalted."] = "Continue limpando {area:2717} até Exaltado.",
	-- ["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "Mate um {npc:11668}, um {npc:11658}, um {npc:11673} e um {npc:12101} em {area:2717}. Todo elemental e chefe de {area:2717} também conta para os Senhores das Águas.",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12)."] = "Use o {item:17310} nos elementais da água envenenados de {zone:1423} e depois saqueie as {item:17309} (12).",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "Use o {item:17310} nos elementais da água envenenados de {zone:1423} e depois saqueie as {item:17309} (12). Nossos dados não têm pontos de surgimento desses elementais.",
	-- ["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "Limpezas de {area:2717} fazem o resto. Chefes sempre contam; no Classic, mortes de monstros comuns deixam de dar reputação com os Senhores das Águas a certa altura, então mais adiante são os chefes que fazem o trabalho.",
	-- ["{faction:749} to Exalted"] = "{faction:749} até Exaltado",
	-- ["{faction:749} to Revered"] = "{faction:749} até Reverenciado",
	-- ["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278} fica numa ilhota ao largo da costa leste de {zone:1447}; nade ou caminhe pela parte rasa até ele. Os {faction:749} começam em Neutro. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- ["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "{npc:9816}, no Pico da Rocha Negra Superior, deixa cair {quest:6821}. Isso exige um grupo de raide.",
	-- ["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823} exige Honrado. Em Honrado, {npc:13278} entrega {item:17333}, usada para apagar as runas em {area:2717} que invocam {npc:12018}; em Reverenciado, a reutilizável {item:22754}.",
}
