-- Portuguese (Brazil) (ptBR): the guide forever/class/rogue/poisons-horde (forever/class/rogue/poisons-horde.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Poisons (Horde)"] = "",
	-- {item:7676} Thistle Tea
	["Forever teaches Poisons through this chain, not the trainer; the {item:7676} recipe comes with it."] = "",

	-- Step 1: Lockpicking practice
	["Lockpicking practice"] = "",
	-- {object:129127} Gallywix's Lockbox · {npc:3401} Shenthul · {object:172960} Cleft of Shadow (no name in this language: may be words) · {item:5060} Thieves' Tools
	["{object:129127} at the end of the tower job needs Lockpicking of about 70-75. Train Pick Lock from Gest or {npc:3401} in the {object:172960} if you lack it, carry {item:5060}, and pick the Buccaneer's Strongboxes on the middle deck of the Tide Razor, the beached pirate ship south of Ratchet: they come back fast. Your cap rises 5 per level."] = "",
	["Tide Razor"] = "",
	["Lockpicking about 75: pick the Buccaneer's Strongboxes on the Tide Razor"] = "",

	-- Step 2: The Shattered Salute
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172982} Valley of Strength (no name in this language: may be words)
	["{npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Take the quest and wait: he speaks three lines and salutes you. After his third line, target him and type /salute. If it does not count, abandon the quest and take it again. The tower job ahead is built around Ambush, which needs a dagger: if you have none, Kareth, the blade merchant in the {object:172960}, sells a Jambiya."] = "",
	-- {npc:3401} Shenthul
	["/salute {npc:3401}"] = "/saudar {npc:3401}",
	-- {quest:2458} Deep Cover · {item:8051} Flare Gun
	["{quest:2458}: keep the {item:8051}"] = "{quest:2458}: guarde a {item:8051}",

	-- Step 3: Taskmaster Fizzule
	-- {item:8051} Flare Gun · {npc:3401} Shenthul
	["Fly to the Crossroads and head north to the Venture Co. tower above the Sludge Fen. Fizzule stands under a tree east of the tower, outside it, and is hostile until signalled. Target him from about 50 yards and fire the {item:8051} twice, then walk up in front of him and /salute. In any other order he attacks. Lost the {item:8051}? Abandon and retake from {npc:3401}."] = "",
	-- {item:8051} Flare Gun
	["{item:8051}, twice, at Fizzule"] = "",

	-- Step 4: Silixiz's Tower Key
	-- {item:8066} Fizzule's Whistle · {npc:7287} Foreman Silixiz
	["Keep {item:8066} in your bags and use it on him every time you come near, or he turns hostile. {npc:7287} (level 22) walks by the tower: hug the wall, stealth up behind him and Pick Pocket the key. Killing him does not give it; if his pockets are empty, kill him and wait 4 1/2 minutes for him to come back."] = "",
	-- {item:8072} Silixiz's Tower Key
	["Pick Pocket Foreman Silixiz for {item:8072}"] = "",

	-- Step 5: The Venture Co. tower
	["The Venture Co. tower"] = "",
	-- {npc:7288} Grand Foreman Puzik Gallywix · {item:7676} Thistle Tea · {object:129127} Gallywix's Lockbox · {npc:2391} Serge Hinott
	-- plural, as words: Mutated Venture Co. Drones = {npc:7310} Mutated Venture Co. Drone
	["Inside, floor by floor (everything comes back after 4 1/2 minutes): the Mutated Venture Co. Drones (level 25) on the ground floor die to one Ambush with a dagger; the Patrollers on the second floor take half their health from a one-point Rupture; the Lookouts on the open third floor from a one-point Eviscerate. {npc:7288} waits on the top floor: a level 23 elite, back 10 minutes after a kill. Open with Ambush (about half his health), then Gouge, Evasion, a healing potion and {item:7676}; a friend makes it easy. One head per kill. Then pick {object:129127} beside him for the cache: it poisons you with the Touch of Zanzil, which weakens your stealth and agility until {npc:2391} cures it."] = "",
	-- {item:8074} Gallywix's Head · {npc:7288} Grand Foreman Puzik Gallywix
	["{item:8074}: {npc:7288} (elite)"] = "{item:8074}: {npc:7288} (elite)",

	-- Step 6: Back to Shenthul
	-- {npc:3401} Shenthul
	["Back to {npc:3401}"] = "De volta a {npc:3401}",
	-- {zone:1454} Orgrimmar · {item:8072} Silixiz's Tower Key · {item:2928} Dust of Decay · {item:6947} Instant Poison
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Fly back to {zone:1454} (Ratchet or the Crossroads; dying at the tower and taking the spirit healer's way back to the Crossroads is quicker). Keep {item:8072} afterwards. Before you leave the Cleft, buy {item:2928} and Empty Vials from Rekkul: once Hinott teaches Poisons, each batch of {item:6947} takes one of each."] = "",

	-- Step 7: Serge Hinott
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {object:1772} Tarren Mill (no name in this language: may be words) · {npc:2391} Serge Hinott · {npc:2216} Apothecary Lydon · {npc:3401} Shenthul · {item:6947} Instant Poison
	["Take the zeppelin from {zone:1454} to the {zone:1458} and follow the road south through {zone:1421} into Hillsbrad, to {object:1772}. {npc:2391} works in the building next to the flight path, beside {npc:2216}, a wagon outside. If you lost the Sample of Zanzil's Mixture, abandon and retake from {npc:3401}. Stay beside him for about a minute while he brews the cure; if it never finishes, abandon and retake from him. Then open Poisons from your spellbook to make {item:6947} from Rekkul's dust and vials, and use it on your weapon."] = "",
	["Wait for the cure"] = "Espere pela cura",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}: Venenos",
	-- {item:8095} Hinott's Oil
	["{item:8095}: clears the Touch of Zanzil"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Target him and type /salute."] = "No nível 20, {npc:3401} fica na {object:172960}, o cânion abaixo do {object:172982}. Selecione-o e digite /saudar.",
	-- ["Fly back to {zone:1454}."] = "Voe de volta a {zone:1454}.",
	-- ["Fly to the {area:380} and ride north to the Venture Co. tower north of the {area:382}. In sight of the tower, fire the {item:8051} twice, then /salute {npc:7233} before he attacks you."] = "Voe até a {area:380} e cavalgue para o norte até a torre da Empreendimentos S.A. ao norte do {area:382}. À vista da torre, dispare a {item:8051} duas vezes e depois faça /saudar para {npc:7233} antes que ele ataque você.",
	-- ["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "O Forever ensina {spell:2842} por esta série, não pelo instrutor; a receita de {item:7676} vem junto.",
	-- ["Stay stealthed. {npc:7287} carries the tower key; Gallywix (elite) and his lockbox are at the top of the tower. Kill two each of the drones, patrollers and lookouts around it."] = "Fique furtivo. {npc:7287} leva a chave da torre; Gallywix (elite) e o cofre dele ficam no alto da torre. Mate dois de cada: peões, patrulheiros e vigias em volta dela.",
	-- ["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south through {zone:1421} to {area:272} in {area:287}. {npc:2391} stands in {area:272}; wait beside him while he brews the cure."] = "Pegue o zepelim de {zone:1454} até {zone:1458} e cavalgue para o sul por {zone:1421} até {area:272}, em {area:287}. {npc:2391} fica em {area:272}; espere ao lado dele enquanto ele prepara a cura.",
	-- ["{item:8051}, twice, in sight of the tower"] = "{item:8051}, duas vezes, à vista da torre",
	-- ["{spell:2842} (Horde)"] = "{spell:2842} (Horda)",
}
