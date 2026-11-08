-- Spanish (Spain) (esES): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "Reputación: Señores del Agua de Hydraxis",
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
	["Use the {item:17310} on a {npc:8521} or a {npc:8522}: it turns into a {npc:13279}. Kill the surge and loot its {item:17309}. Twelve are needed, and the vial must still be in your bags at the turn-in."] = "",
	-- {item:17310} Aspect of Neptulon
	["{item:17310}, on the poisoned elementals"] = "",

	-- Step 4: Back to Duke Hydraxis
	-- {npc:13278} Duke Hydraxis
	["Back to {npc:13278}"] = "Vuelve con {npc:13278}",

	-- Step 5: Eye of the Emberseer
	-- {npc:9816} Pyroguard Emberseer · {item:12344} Seal of Ascension · {npc:9017} Lord Incendius
	["{npc:9816} is a boss in Upper Blackrock Spire, inside Blackrock Mountain: a group of up to ten, and someone needs the {item:12344} to open the door. He drops the Eye and pays 50 reputation per kill up to 11,999 of 12,000 Honored. {npc:9017} in Blackrock Depths pays 15 the same way."] = "",
	-- {quest:6821} Eye of the Emberseer
	["{quest:6821}: raid of ten"] = "",

	-- Step 6: Attunement to the Core
	-- {npc:14387} Lothos Riftwaker · {item:18412} Core Fragment
	["{npc:14387} in Blackrock Mountain attunes you to the Molten Core: bring him a {item:18412} from beside the Molten Core's portal at the bottom of Blackrock Depths. Once attuned, he can send you straight into the Molten Core."] = "",
	-- {item:18412} Core Fragment
	["{item:18412}, at the portal in Blackrock Depths"] = "",

	-- Step 7: The Molten Core
	-- {quest:6822} The Molten Core · {npc:11658} Molten Giant · {npc:11668} Firelord · {npc:11673} Ancient Core Hound · {npc:12101} Lava Surger · {npc:13278} Duke Hydraxis · {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	-- plural, as words: Firewalkers = {npc:11666} Firewalker · Flameguards = {npc:11667} Flameguard · Lava Elementals = {npc:12076} Lava Elemental · Lava Reavers = {npc:12100} Lava Reaver · Molten Destroyers = {npc:11659} Molten Destroyer · Firelords = {npc:11668} Firelord · Lava Surgers = {npc:12101} Lava Surger · Molten Giants = {npc:11658} Molten Giant · Ancient Core Hounds = {npc:11673} Ancient Core Hound
	["{quest:6822} is a raid of 40. Kill one {npc:11658}, {npc:11668}, {npc:11673} and {npc:12101} for {npc:13278}. Every elemental there pays: Firewalkers, Flameguards, Lava Elementals, Lava Reavers and Molten Destroyers 40, Firelords, Lava Surgers, Molten Giants and Ancient Core Hounds 20, up to 11,999 of 12,000 Honored; about 3,360 for a full clear of the trash. The bosses pay 100 each ({npc:11988} 150, {npc:11502} 200)."] = "",
	-- {npc:11658} Molten Giant
	["{npc:11658}: raid of 40"] = "",

	-- Step 8: Elementals to Honored
	["Elementals to Honored"] = "",
	-- {quest:6823} Agent of Hydraxis · {npc:11744} Dust Stormer · {npc:11746} Desert Rumbler · {npc:7032} Greater Obsidian Elemental · {zone:1428} Burning Steppes · {npc:14478} Huricanian · {npc:9017} Lord Incendius · {object:174825} Black Anvil (no name in this language: may be words) · {npc:9816} Pyroguard Emberseer
	["Neutral to Honored is 9,000 reputation, and {quest:6823} asks for Honored. One Molten Core clear pays about 4,000 of it. Without a raid it comes from the elementals: 5 per {npc:11744}, {npc:11746} or {npc:7032} (the {zone:1428}), about 1,800 kills from Neutral. They stop at 5,999 of 6,000 Friendly, one point short, so the last point needs a kill that still counts there: {npc:14478}, a rare air elemental in the Crystal Vale (25), or {npc:9017} at the {object:174825} in Blackrock Depths (15, a five-player dungeon). Those two and {npc:9816} keep paying through Honored as well."] = "",
	-- {npc:14478} Huricanian
	["{npc:14478}, rare, 25"] = "",
	-- {npc:9017} Lord Incendius
	["{npc:9017}, Blackrock Depths: 15, group up"] = "",

	-- Step 9: Agent of Hydraxis
	-- {npc:13278} Duke Hydraxis · {quest:6823} Agent of Hydraxis
	["Back to {npc:13278}. {quest:6823} is done the moment you are Honored."] = "",

	-- Step 10: Hands of the Enemy
	-- {npc:12118} Lucifron · {npc:12259} Gehennas · {npc:12264} Shazzrah · {npc:12098} Sulfuron Harbinger
	["{npc:12118}, {npc:12259}, {npc:12264} and {npc:12098} are Molten Core bosses: each drops his hand for the quest."] = "",
	-- {item:17332} Hand of Shazzrah
	["{item:17332}: raid of 40"] = "",

	-- Step 11: A Hero's Reward
	-- {object:179551} Hydraxis' Coffer · {item:17333} Aqual Quintessence · {npc:12018} Majordomo Executus · {npc:11502} Ragnaros
	["Hand in the hands, then dive under the surf at the southern foot of the island: {object:179551} holds your ring and pays the only quest reputation the Waterlords give, 200. From now on, while you are Honored or better, the Duke hands you {item:17333}: pour it on a rune in the Molten Core to douse it. With every rune doused, {npc:12018} comes out, and after him {npc:11502}."] = "",
	-- {item:17333} Aqual Quintessence
	["{item:17333}, ask the Duke"] = "",

	-- Step 12: Molten Core to Revered
	["Molten Core to Revered"] = "",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros · {npc:9017} Lord Incendius · {npc:9816} Pyroguard Emberseer
	["Honored to Revered is 12,000 reputation. The trash still counts, so a full clear pays about 3,360 plus 700 from the seven bosses, 150 from {npc:11988} and 200 from {npc:11502}: about three clears. {npc:9017} (15) and {npc:9816} (50) count too while you are Honored. The trash stops at 11,999 of 12,000 Honored; the bosses carry you over."] = "",
	-- {npc:12118} Lucifron
	["{npc:12118} and the other bosses, 100: they carry you past 11,999"] = "",

	-- Step 13: The Eternal Quintessence
	-- {item:22754} Eternal Quintessence
	["The {item:22754}"] = "",
	-- {item:22754} Eternal Quintessence · {item:17333} Aqual Quintessence
	["At Revered the Duke gives you the {item:22754}: it does the {item:17333}'s work and is not used up, so you never come back for another vial."] = "",
	-- {item:22754} Eternal Quintessence
	["{item:22754}, ask the Duke"] = "",

	-- Step 14: Molten Core to Exalted
	["Molten Core to Exalted"] = "",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	["Revered to Exalted is 21,000 reputation. The trash has stopped, but all nine bosses still pay while you are Revered: 100 each from the seven, 150 from {npc:11988} and 200 from {npc:11502}, 1,050 a clear: about 20 clears. The seven stop at 20,999 of 21,000 Revered, so the last point comes from {npc:11988} or {npc:11502}, and from Exalted on only those two pay."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "Ambos elementales recorren el noroeste de {zone:1451}; los estruendores se agrupan un poco más al norte.",
	-- ["Bring the Hands of Lucifron, Gehennas, Shazzrah and Sulfuron from the {area:2717}."] = "Trae las manos de Lucifron, Gehennas, Shazzrah y Sulfuron de {area:2717}.",
	-- ["Dust Stormers and Desert Rumblers"] = "Sirocosos y Estruendores del desierto",
	-- ["Keep clearing the {area:2717} until Exalted."] = "Sigue limpiando {area:2717} hasta Exaltado.",
	-- ["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "Mata a un {npc:11668}, un {npc:11658}, un {npc:11673} y un {npc:12101} en {area:2717}. Todos los elementales y jefes de {area:2717} también cuentan para los Señores del Agua.",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12)."] = "Usa {item:17310} en los elementales de agua envenenados de {zone:1423} y luego despoja sus {item:17309} (12).",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "Usa {item:17310} en los elementales de agua envenenados de {zone:1423} y luego despoja sus {item:17309} (12). Nuestros datos no tienen puntos de aparición para esos elementales.",
	-- ["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "Limpiar {area:2717} da el resto. Los jefes siempre cuentan; en Classic, matar enemigos menores deja de dar reputación con los Señores del Agua a mitad de camino, así que al final el trabajo lo hacen los jefes.",
	-- ["{faction:749} to Exalted"] = "{faction:749} hasta Exaltado",
	-- ["{faction:749} to Revered"] = "{faction:749} hasta Reverenciado",
	-- ["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278} está en un islote frente a la costa este de {zone:1447}; ve nadando o caminando por los bajíos hasta él. Los {faction:749} empiezan en Neutral. La ventaja de Legado Diplomático de Forever aumenta la reputación obtenida.",
	-- ["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "{npc:9816}, en la Cumbre de Roca Negra superior, suelta {quest:6821}. Requiere un grupo de banda.",
	-- ["{npc:9816} in Upper {area:1583} drops the {quest:6821}. This needs a raid group."] = "{npc:9816}, en la parte superior de {area:1583}, suelta {quest:6821}. Requiere un grupo de banda.",
	-- ["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823} requiere Honorable. En Honorable, {npc:13278} entrega {item:17333}, que sirve para apagar las runas de {area:2717} que invocan a {npc:12018}; en Reverenciado, la reutilizable {item:22754}.",
}
