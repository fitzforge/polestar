-- French (frFR): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "Réputation : Les Hydraxiens",
	-- {item:17333} Aqual Quintessence · {item:22754} Eternal Quintessence
	["{item:17333} to douse the Molten Core's runes, the reusable {item:22754} at Revered and a fire resistance ring."] = "",

	-- Step 1: Duke Hydraxis
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara
	["{npc:13278} stands on a small island off the east coast of {zone:1447}; swim out to him. Everyone starts Neutral with the Waterlords, and nearly all of their reputation comes from killing the servants of fire, air and earth: the quests themselves pay nothing until the last one. Take both quests: the chain goes on only when both are done. Everything past Honored happens in the Molten Core, a raid of 40 that is not among the first raids Blizzard has announced for Forever; until it opens, Honored is as far as the Waterlords go. The numbers in this guide leave out the Legacy perk Diplomat, which adds up to 10%."] = "",

	-- Step 2: Stormers and Rumblers
	-- {zone:1451} Silithus
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["Dust Stormers and Desert Rumblers drift around the Crystal Vale in the north-west of {zone:1451}. Each kill also pays 5 reputation while you are Neutral or Friendly, so stay if you mean to farm (next steps)."] = "",

	-- Step 3: Poisoned Water
	-- {item:17310} Aspect of Neptulon · {npc:8521} Blighted Horror · {npc:8522} Plague Monstrosity · {npc:13279} Discordant Surge · {item:17309} Discordant Bracers
	["Use the {item:17310} on a {npc:8521} or a {npc:8522}: it turns into a {npc:13279}. Kill the surge and loot its {item:17309}. Twelve are needed, and the vial must still be in your bags at the turn-in."] = "Utilisez l'{item:17310} sur une {npc:8521} ou une {npc:8522} : elle se transforme en {npc:13279}. Tuez la déferlante et ramassez ses {item:17309}. Il en faut douze, et la fiole doit toujours être dans vos sacs au moment de rendre la quête.",
	-- {item:17310} Aspect of Neptulon
	["{item:17310}, on the poisoned elementals"] = "{item:17310}, sur les élémentaires empoisonnés",

	-- Step 4: Back to Duke Hydraxis
	-- {npc:13278} Duke Hydraxis
	["Back to {npc:13278}"] = "Retour auprès de {npc:13278}",

	-- Step 5: Eye of the Emberseer
	-- {npc:9816} Pyroguard Emberseer · {item:12344} Seal of Ascension · {npc:9017} Lord Incendius
	["{npc:9816} is a boss in Upper Blackrock Spire, inside Blackrock Mountain: a group of up to ten, and someone needs the {item:12344} to open the door. He drops the Eye and pays 50 reputation per kill up to 11,999 of 12,000 Honored. {npc:9017} in Blackrock Depths pays 15 the same way."] = "",
	-- {quest:6821} Eye of the Emberseer
	["{quest:6821}: raid of ten"] = "{quest:6821} : raid de dix",

	-- Step 6: Attunement to the Core
	-- {npc:14387} Lothos Riftwaker · {item:18412} Core Fragment
	["{npc:14387} in Blackrock Mountain attunes you to the Molten Core: bring him a {item:18412} from beside the Molten Core's portal at the bottom of Blackrock Depths. Once attuned, he can send you straight into the Molten Core."] = "",
	-- {item:18412} Core Fragment
	["{item:18412}, at the portal in Blackrock Depths"] = "",

	-- Step 7: The Molten Core
	-- {quest:6822} The Molten Core · {npc:11658} Molten Giant · {npc:11668} Firelord · {npc:11673} Ancient Core Hound · {npc:12101} Lava Surger · {npc:13278} Duke Hydraxis · {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	-- plural, as words: Firewalkers = {npc:11666} Firewalker · Flameguards = {npc:11667} Flameguard · Lava Elementals = {npc:12076} Lava Elemental · Lava Reavers = {npc:12100} Lava Reaver · Molten Destroyers = {npc:11659} Molten Destroyer · Firelords = {npc:11668} Firelord · Lava Surgers = {npc:12101} Lava Surger · Molten Giants = {npc:11658} Molten Giant · Ancient Core Hounds = {npc:11673} Ancient Core Hound
	["{quest:6822} is a raid of 40. Kill one {npc:11658}, {npc:11668}, {npc:11673} and {npc:12101} for {npc:13278}. Every elemental there pays: Firewalkers, Flameguards, Lava Elementals, Lava Reavers and Molten Destroyers 40, Firelords, Lava Surgers, Molten Giants and Ancient Core Hounds 20, up to 11,999 of 12,000 Honored; about 3,360 for a full clear of the trash. The bosses pay 100 each ({npc:11988} 150, {npc:11502} 200)."] = "{quest:6822} est un raid de 40. Tuez un {npc:11658}, un {npc:11668}, un {npc:11673} et un {npc:12101} pour le {npc:13278}. Chaque élémentaire du lieu rapporte : Marchefeux, Gardes des flammes, Élémentaires de lave, Ravageurs de lave et Destructeurs de lave 40, Seigneurs du feu, Surgisseurs de lave, Géants de lave et Anciens chiens du Magma 20, jusqu'à 11 999 sur 12 000 d'Honoré ; environ 3 360 pour un nettoyage complet des monstres ordinaires. Les boss rapportent 100 chacun ({npc:11988} 150, {npc:11502} 200).",
	-- {npc:11658} Molten Giant
	["{npc:11658}: raid of 40"] = "{npc:11658} : raid de 40",

	-- Step 8: Elementals to Honored
	["Elementals to Honored"] = "Élémentaires jusqu'à Honoré",
	-- {quest:6823} Agent of Hydraxis · {npc:11744} Dust Stormer · {npc:11746} Desert Rumbler · {npc:7032} Greater Obsidian Elemental · {zone:1428} Burning Steppes · {npc:14478} Huricanian · {npc:9017} Lord Incendius · {object:174825} Black Anvil (no name in this language: may be words) · {npc:9816} Pyroguard Emberseer
	["Neutral to Honored is 9,000 reputation, and {quest:6823} asks for Honored. One Molten Core clear pays about 4,000 of it. Without a raid it comes from the elementals: 5 per {npc:11744}, {npc:11746} or {npc:7032} (the {zone:1428}), about 1,800 kills from Neutral. They stop at 5,999 of 6,000 Friendly, one point short, so the last point needs a kill that still counts there: {npc:14478}, a rare air elemental in the Crystal Vale (25), or {npc:9017} at the {object:174825} in Blackrock Depths (15, a five-player dungeon). Those two and {npc:9816} keep paying through Honored as well."] = "",
	-- {npc:14478} Huricanian
	["{npc:14478}, rare, 25"] = "{npc:14478}, rare, 25",
	-- {npc:9017} Lord Incendius
	["{npc:9017}, Blackrock Depths: 15, group up"] = "",

	-- Step 9: Agent of Hydraxis
	-- {npc:13278} Duke Hydraxis · {quest:6823} Agent of Hydraxis
	["Back to {npc:13278}. {quest:6823} is done the moment you are Honored."] = "Retournez voir le {npc:13278}. {quest:6823} est accomplie dès que vous êtes Honoré.",

	-- Step 10: Hands of the Enemy
	-- {npc:12118} Lucifron · {npc:12259} Gehennas · {npc:12264} Shazzrah · {npc:12098} Sulfuron Harbinger
	["{npc:12118}, {npc:12259}, {npc:12264} and {npc:12098} are Molten Core bosses: each drops his hand for the quest."] = "",
	-- {item:17332} Hand of Shazzrah
	["{item:17332}: raid of 40"] = "{item:17332} : raid de 40",

	-- Step 11: A Hero's Reward
	-- {object:179551} Hydraxis' Coffer · {item:17333} Aqual Quintessence · {npc:12018} Majordomo Executus · {npc:11502} Ragnaros
	["Hand in the hands, then dive under the surf at the southern foot of the island: {object:179551} holds your ring and pays the only quest reputation the Waterlords give, 200. From now on, while you are Honored or better, the Duke hands you {item:17333}: pour it on a rune in the Molten Core to douse it. With every rune doused, {npc:12018} comes out, and after him {npc:11502}."] = "",
	-- {item:17333} Aqual Quintessence
	["{item:17333}, ask the Duke"] = "{item:17333} : demandez au Duc",

	-- Step 12: Molten Core to Revered
	["Molten Core to Revered"] = "",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros · {npc:9017} Lord Incendius · {npc:9816} Pyroguard Emberseer
	["Honored to Revered is 12,000 reputation. The trash still counts, so a full clear pays about 3,360 plus 700 from the seven bosses, 150 from {npc:11988} and 200 from {npc:11502}: about three clears. {npc:9017} (15) and {npc:9816} (50) count too while you are Honored. The trash stops at 11,999 of 12,000 Honored; the bosses carry you over."] = "D'Honoré à Révéré, il faut 12 000 de réputation. Les monstres ordinaires comptent toujours, donc un nettoyage complet rapporte environ 3 360, plus 700 pour les sept boss, 150 pour {npc:11988} et 200 pour {npc:11502} : environ trois nettoyages. Le {npc:9017} (15) et le {npc:9816} (50) comptent aussi tant que vous êtes Honoré. Les monstres ordinaires s'arrêtent à 11 999 sur 12 000 d'Honoré ; les boss vous font passer le cap.",
	-- {npc:12118} Lucifron
	["{npc:12118} and the other bosses, 100: they carry you past 11,999"] = "{npc:12118} et les autres boss, 100 : ils vous font passer 11 999",

	-- Step 13: The Eternal Quintessence
	-- {item:22754} Eternal Quintessence
	["The {item:22754}"] = "La {item:22754}",
	-- {item:22754} Eternal Quintessence · {item:17333} Aqual Quintessence
	["At Revered the Duke gives you the {item:22754}: it does the {item:17333}'s work and is not used up, so you never come back for another vial."] = "À Révéré, le Duc vous donne la {item:22754} : elle fait le travail de la {item:17333} sans être consommée, vous n'aurez donc jamais à revenir chercher une autre fiole.",
	-- {item:22754} Eternal Quintessence
	["{item:22754}, ask the Duke"] = "{item:22754} : demandez au Duc",

	-- Step 14: Molten Core to Exalted
	["Molten Core to Exalted"] = "",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	["Revered to Exalted is 21,000 reputation. The trash has stopped, but all nine bosses still pay while you are Revered: 100 each from the seven, 150 from {npc:11988} and 200 from {npc:11502}, 1,050 a clear: about 20 clears. The seven stop at 20,999 of 21,000 Revered, so the last point comes from {npc:11988} or {npc:11502}, and from Exalted on only those two pay."] = "De Révéré à Exalté, il faut 21 000 de réputation. Les monstres ordinaires ne comptent plus, mais les neuf boss rapportent toujours tant que vous êtes Révéré : 100 chacun pour les sept, 150 pour {npc:11988} et 200 pour {npc:11502}, 1 050 par nettoyage : environ 20 nettoyages. Les sept s'arrêtent à 20 999 sur 21 000 de Révéré, donc le dernier point vient de {npc:11988} ou de {npc:11502}, et à partir d'Exalté seuls ces deux-là rapportent.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "Les deux élémentaires errent au nord-ouest de {zone:1451} ; les Grondeurs du désert se regroupent un peu plus au nord.",
	-- ["Bring the Hands of Lucifron, Gehennas, Shazzrah and Sulfuron from the {area:2717}."] = "Rapportez la Main de Lucifron, la Main de Gehennas, la Main de Shazzrah et la Main de Sulfuron depuis {area:2717}.",
	-- ["Dust Stormers and Desert Rumblers"] = "Tempétueux de poussière et Grondeurs du désert",
	-- ["Dust Stormers and Desert Rumblers drift around the {area:2740} in the north-west of {zone:1451}. Each kill also pays 5 reputation while you are Neutral or Friendly, so stay if you mean to farm (next steps)."] = "Les Tempétueux de poussière et les Grondeurs du désert dérivent autour du {area:2740}, au nord-ouest de {zone:1451}. Chaque victime rapporte aussi 5 de réputation tant que vous êtes Neutre ou Amical : restez si vous comptez farmer (étapes suivantes).",
	-- ["Hand in the hands, then dive under the surf at the southern foot of the island: {object:179551} holds your ring and pays the only quest reputation the Waterlords give, 200. From now on, while you are Honored or better, the Duke hands you {item:17333}: pour it on a rune in the {area:2717} to douse it. With every rune doused, {npc:12018} comes out, and after him {npc:11502}."] = "Rendez les mains, puis plongez sous les vagues au pied sud de l'îlot : le {object:179551} contient votre anneau et rapporte la seule réputation de quête que donnent les Hydraxiens, 200. Désormais, tant que vous êtes Honoré ou mieux, le Duc vous donne la {item:17333} : versez-la sur une rune du {area:2717} pour l'éteindre. Une fois toutes les runes éteintes, {npc:12018} apparaît, et après lui {npc:11502}.",
	-- ["Keep clearing the {area:2717} until Exalted."] = "Continuez à nettoyer {area:2717} jusqu'à Exalté.",
	-- ["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "Tuez un {npc:11668}, un {npc:11658}, un {npc:11673} et un {npc:12101} dans {area:2717}. Chaque élémentaire et boss de {area:2717} compte aussi pour les Hydraxiens.",
	-- ["Neutral to Honored is 9,000 reputation, and {quest:6823} asks for Honored. One {area:2717} clear pays about 4,000 of it. Without a raid it comes from the elementals: 5 per {npc:11744}, {npc:11746} or {npc:7032} (the {zone:1428}), about 1,800 kills from Neutral. They stop at 5,999 of 6,000 Friendly, one point short, so the last point needs a kill that still counts there: {npc:14478}, a rare air elemental in the {area:2740} (25), or {npc:9017} at the {object:174825} in {area:1584} (15, a five-player dungeon). Those two and {npc:9816} keep paying through Honored as well."] = "De Neutre à Honoré, il faut 9 000 de réputation, et {quest:6823} demande Honoré. Un nettoyage du {area:2717} en rapporte environ 4 000. Sans raid, elle vient des élémentaires : 5 par {npc:11744}, {npc:11746} ou {npc:7032} (les {zone:1428}), environ 1 800 victimes depuis Neutre. Ils s'arrêtent à 5 999 sur 6 000 d'Amical, à un point du but, donc le dernier point demande une victime qui compte encore : {npc:14478}, un élémentaire d'air rare du {area:2740} (25), ou le {npc:9017} à l'Enclume noire des {area:1584} (15, un donjon à cinq joueurs). Ces deux-là et le {npc:9816} continuent de rapporter pendant Honoré aussi.",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12)."] = "Utilisez {item:17310} sur les élémentaires d'eau empoisonnés de {zone:1423}, puis prenez leurs {item:17309} (12).",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "Utilisez {item:17310} sur les élémentaires d'eau empoisonnés de {zone:1423}, puis prenez leurs {item:17309} (12). Nos données n'ont aucun point d'apparition pour ces élémentaires.",
	-- ["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "Les nettoyages de {area:2717} font le reste. Les boss comptent toujours ; dans Classic, les monstres ordinaires cessent en cours de route de donner de la réputation auprès des Hydraxiens, donc vers la fin ce sont les boss qui font le travail.",
	-- ["{area:2717} to Exalted"] = "{area:2717} jusqu'à Exalté",
	-- ["{area:2717} to Revered"] = "{area:2717} jusqu'à Révéré",
	-- ["{faction:749} to Exalted"] = "{faction:749} jusqu'à Exalté",
	-- ["{faction:749} to Revered"] = "{faction:749} jusqu'à Révéré",
	-- ["{item:17333} to douse the {area:2717}'s runes, the reusable {item:22754} at Revered and a fire resistance ring."] = "La {item:17333} pour éteindre les runes du {area:2717}, la {item:22754} réutilisable à Révéré et un anneau de résistance au feu.",
	-- ["{item:18412}, at the portal in {area:1584}"] = "{item:18412}, au portail des {area:1584}",
	-- ["{npc:12118}, {npc:12259}, {npc:12264} and {npc:12098} are {area:2717} bosses: each drops his hand for the quest."] = "{npc:12118}, {npc:12259}, {npc:12264} et {npc:12098} sont des boss du {area:2717} : chacun laisse sa main pour la quête.",
	-- ["{npc:13278} stands on a small island off the east coast of {zone:1447}; swim out to him. Everyone starts Neutral with the Waterlords, and nearly all of their reputation comes from killing the servants of fire, air and earth: the quests themselves pay nothing until the last one. Take both quests: the chain goes on only when both are done. Everything past Honored happens in the {area:2717}, a raid of 40 that is not among the first raids Blizzard has announced for Forever; until it opens, Honored is as far as the Waterlords go. The numbers in this guide leave out the Legacy perk Diplomat, which adds up to 10%."] = "Le {npc:13278} se tient sur un petit îlot au large de la côte est d'{zone:1447} ; rejoignez-le à la nage. Tout le monde commence à Neutre avec les Hydraxiens, et presque toute leur réputation vient des serviteurs du feu, de l'air et de la terre que vous tuez : les quêtes elles-mêmes ne rapportent rien jusqu'à la dernière. Acceptez les deux quêtes : la suite ne continue qu'une fois les deux terminées. Tout ce qui suit Honoré se passe dans le {area:2717}, un raid de 40 qui ne fait pas partie des premiers raids annoncés par Blizzard pour Forever ; tant qu'il n'est pas ouvert, Honoré est le plus loin où mènent les Hydraxiens. Les chiffres de ce guide ne comptent pas l'atout Diplomate de l'Héritage, qui ajoute jusqu'à 10 %.",
	-- ["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278} se tient sur un petit îlot au large de la côte est de {zone:1447} ; rejoignez-le à la nage ou par les hauts-fonds. {faction:749} : vous partez de Neutre. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{npc:14387} in {area:254} attunes you to the {area:2717}: bring him a {item:18412} from beside the {area:2717}'s portal at the bottom of {area:1584}. Once attuned, he can send you straight into the {area:2717}."] = "{npc:14387}, dans le {area:254}, vous donne l'accès au {area:2717} : apportez-lui un {item:18412} pris à côté du portail du {area:2717}, au fond des {area:1584}. Une fois l'accès obtenu, il peut vous envoyer directement dans le {area:2717}.",
	-- ["{npc:9017}, {area:1584}: 15, group up"] = "{npc:9017}, {area:1584} : 15, en groupe",
	-- ["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "{npc:9816}, dans le haut du Pic Rochenoire, lâche {quest:6821}. Il faut un groupe de raid.",
	-- ["{npc:9816} in Upper {area:1583} drops the {quest:6821}. This needs a raid group."] = "{npc:9816}, dans la partie supérieure de {area:1583}, laisse {quest:6821}. Il faut un groupe de raid.",
	-- ["{npc:9816} is a boss in Upper Blackrock Spire, inside {area:254}: a group of up to ten, and someone needs the {item:12344} to open the door. He drops the Eye and pays 50 reputation per kill up to 11,999 of 12,000 Honored. {npc:9017} in {area:1584} pays 15 the same way."] = "Le {npc:9816} est un boss du haut du Pic Rochenoire, dans le {area:254} : un groupe de dix au plus, et quelqu'un doit avoir le {item:12344} pour ouvrir la porte. Il laisse l'Œil et rapporte 50 de réputation par victoire jusqu'à 11 999 sur 12 000 d'Honoré. Le {npc:9017}, dans les {area:1584}, rapporte 15 de la même façon.",
	-- ["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823} exige Honoré. À Honoré, {npc:13278} donne {item:17333}, qui sert à éteindre les runes de {area:2717} invoquant {npc:12018} ; à Révéré, {item:22754}, réutilisable.",
}
