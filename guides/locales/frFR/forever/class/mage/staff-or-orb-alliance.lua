-- French (frFR): the guide forever/class/mage/staff-or-orb-alliance (forever/class/mage/staff-or-orb-alliance.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:9514} Arcane Staff
	["Ley or {item:9514} or Orb (Alliance)"] = "Ley ou {item:9514} ou orbe (Alliance)",
	["A staff or an off-hand orb at 10 from your home town's mage trainer; Skyborne add a wand."] = "Un bâton ou un orbe de main gauche au niveau 10, auprès du maître des mages de votre ville d'origine ; les Éolides y ajoutent une baguette.",

	-- Step 1: Anathamaas Aetherwind (Valanaar)
	-- {npc:252373} Anathamaas Aetherwind · {area:16638} Valanaar · {npc:256507} Belann Windwood
	["At 10 {npc:252373}, the {area:16638} mage trainer, sends you to {npc:256507}, the staff merchant a few steps away in the same town."] = "Au niveau 10, {npc:252373}, le maître des mages de {area:16638}, vous envoie voir {npc:256507}, la marchande de bâtons à quelques pas dans la même ville.",

	-- Step 2: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "Les Formations de pierre des vents",
	-- {area:16636} Falaath Village
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The bough lies on the ground among the Windstone Formations, the wind shrine on the rise west of Fillion's camp, south of {area:16636}. It does not sparkle, so look at the ground by the stones; there are two spots for it."] = "La branche est posée au sol parmi les Formations de pierre des vents, le sanctuaire du vent sur l'éminence à l'ouest du camp de Fillion, au sud du {area:16636}. Elle ne scintille pas : regardez donc le sol près des pierres ; elle peut se trouver à deux endroits.",

	-- Step 3: Back to Belann Windwood
	-- {npc:256507} Belann Windwood
	["Back to {npc:256507}"] = "Retour auprès de {npc:256507}",
	-- {quest:1861} Mirror Lake · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{quest:1861} (the next steps) waits for you with {npc:5497} in {zone:1453}, at about 15."] = "{quest:1861} (les étapes suivantes) vous attend auprès de {npc:5497} à {zone:1453}, vers le niveau 15.",

	-- Step 4: Zaldimar Wefhellt (Goldshire)
	-- {npc:328} Zaldimar Wefhellt · {area:87} Goldshire · {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {quest:1879} Speak with Bink · {area:131} Kharanos · {quest:1861} Mirror Lake · {npc:5144} Bink
	["At 10 {npc:328}, the {area:87} mage trainer, upstairs in the Lion's Pride Inn, sends you to {npc:5497} in {zone:1453}. Taking it shuts out {quest:1879}, the {area:131} trainer's errand; {quest:1861} and {npc:5144}'s Gizmonitor shut out each other, so you get one staff or orb."] = "",

	-- Step 5: Magis Sparkmantle (Kharanos)
	-- {npc:1228} Magis Sparkmantle · {area:131} Kharanos · {area:2102} Thunderbrew Distillery · {npc:5144} Bink · {zone:1455} Ironforge · {quest:1860} Speak with Jennea · {area:87} Goldshire · {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake · {npc:328} Zaldimar Wefhellt
	["At 10 {npc:1228}, the {area:131} mage trainer in the {area:2102}, sends you to {npc:5144} in {zone:1455}. Taking it shuts out {quest:1860}, the {area:87} trainer's errand; {npc:5144}'s Gizmonitor and {npc:5497}'s {quest:1861} shut out each other, so you get one staff or orb. (A Gnome who took {npc:328}'s quest in {area:87} instead follows the {quest:1861} steps; a Human who took this one, the Gizmonitor steps.)"] = "",

	-- Step 6: Jennea Cannon
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:5497} Jennea Cannon · {item:7207} Jennea's Flask · {quest:1861} Mirror Lake
	["Follow the road north into {zone:1453} and west to the {object:2101}. {npc:5497} stands at the top of the Wizard's Sanctum, the tall violet tower: climb the spiral ramp and step into the portal near the top, which puts you beside her. She hands you {item:7207}. Skyborne mages take {quest:1861} from her when they first reach {zone:1453}, at about 15."] = "Suivez la route vers le nord jusqu'à {zone:1453}, puis vers l'ouest jusqu'au {object:2101}. {npc:5497} se tient au sommet du Sanctuaire des sorciers, la haute tour violette : montez la rampe en spirale et entrez dans le portail près du sommet, qui vous dépose à côté d'elle. Elle vous remet la {item:7207}. Les mages éolides acceptent {quest:1861} auprès d'elle en arrivant pour la première fois à {zone:1453}, vers le niveau 15.",

	-- Step 7: The Mirror Lake waterfall
	-- {quest:1861} Mirror Lake
	["The {quest:1861} waterfall"] = "La cascade de {quest:1861}",
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate and head south-west to the waterfall that feeds {quest:1861}. Wade in under the falling water to the rock behind it and use {item:7207} there (a 5 second cast); it fails anywhere else. Level 10 Defias casters stand on the rocks either side of the falls and shoot from range: pull them one at a time or fill the flask from the water."] = "Quittez {zone:1453} par la porte principale et dirigez-vous vers le sud-ouest jusqu'à la cascade qui alimente {quest:1861}. Avancez sous la chute d'eau jusqu'au rocher derrière et utilisez la {item:7207} à cet endroit (5 secondes d'incantation) ; ailleurs, cela échoue. Des lanceurs de sorts Défias de niveau 10 se tiennent sur les rochers de part et d'autre des chutes et tirent à distance : attirez-les un par un ou remplissez la fiole depuis l'eau.",
	-- {item:7207} Jennea's Flask
	["{item:7207}, under the falls"] = "{item:7207}, sous les chutes",

	-- Step 8: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "Retour auprès de {npc:5497}",
	["Back up the Wizard's Sanctum and through the portal. The orb is an off-hand for a one-hand weapon; the staff is a two-hander."] = "Remontez le Sanctuaire des sorciers et passez le portail. L'orbe se tient en main gauche avec une arme à une main ; le bâton est une arme à deux mains.",
	-- {npc:5497} Jennea Cannon · {item:7508} Ley Orb · {item:9513} Ley Staff
	["{npc:5497}: {item:7508} or {item:9513}"] = "{npc:5497} : {item:7508} ou {item:9513}",

	-- Step 9: Bink
	-- {npc:5144} Bink · {object:32362} Mystic Ward · {zone:1455} Ironforge · {object:32386} Hall of Mysteries (no name in this language: may be words)
	["{npc:5144} teaches mages in the {object:32362}, at the back of {zone:1455} past the {object:32386}."] = "{npc:5144} enseigne aux mages dans {object:32362}, au fond de {zone:1455}, après la salle des Mystères.",

	-- Step 10: Bink's Toolbox
	-- {area:133} Gnomeregan
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["Head west along the road to {area:133}. Just north of its entrance stand two huts; the toolbox is in the taller, eastern one, the hut with the lift: a small grey box on the ground floor, half under the table beside the lift. Leper Gnomes (level 8) guard the huts: pull them singly. There is only one toolbox and it takes 15 minutes to come back after someone opens it, so wait nearby if it is gone."] = "Suivez la route vers l'ouest jusqu'à {area:133}. Juste au nord de son entrée se dressent deux cabanes ; la boîte à outils est dans la plus haute, à l'est, celle qui a l'ascenseur : une petite boîte grise au rez-de-chaussée, à moitié sous la table à côté de l'ascenseur. Des Gnomes lépreux (niveau 8) gardent les cabanes : attirez-les un par un. Il n'y a qu'une boîte à outils et elle met 15 minutes à revenir après que quelqu'un l'a ouverte : si elle a disparu, attendez à proximité.",

	-- Step 11: Back to Bink
	-- {npc:5144} Bink
	["Back to {npc:5144}"] = "Retour auprès de {npc:5144}",
	-- {npc:5144} Bink · {item:7507} Arcane Orb · {item:9514} Arcane Staff
	["{npc:5144}: {item:7507} or {item:9514}"] = "{npc:5144} : {item:7507} ou {item:9514}",

	-- Step 12: Belann Windwood's wand (optional)
	-- {npc:256507} Belann Windwood
	["{npc:256507}'s wand (optional)"] = "La baguette de {npc:256507} (facultatif)",
	-- {npc:256507} Belann Windwood · {area:16638} Valanaar · {zone:2521} Zephras Isle · {npc:252373} Anathamaas Aetherwind · {item:262668} Wind-Infused Bough · {area:16636} Falaath Village · {item:263430} Windbough Wand
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["{npc:256507}'s quest is open to Human and Gnome mages too, if you ever visit {area:16638} on {zone:2521}, the Skyborne home: {npc:252373}, the town's mage trainer, sends you to {npc:256507} next door, who wants a {item:262668} from the ground by the Windstone Formations south of {area:16636}, for the {item:263430}. It does not shut out the staff or the orb."] = "La quête de {npc:256507} est aussi ouverte aux mages humains et gnomes, si vous passez un jour à {area:16638} sur {zone:2521}, le foyer des Éolides : {npc:252373}, le maître des mages de la ville, vous envoie voir {npc:256507} juste à côté, qui veut une {item:262668} ramassée au sol près des Formations de pierre des vents au sud du {area:16636}, pour la {item:263430}. Elle ne vous ferme ni le bâton ni l'orbe.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10 {npc:1228}, the {area:131} mage trainer in the {area:2102}, sends you to {npc:5144} in {zone:1455}. Taking it shuts out {npc:5497}'s {quest:1861}; you get one staff-or-orb quest. (A Gnome who took {npc:328}'s quest in {area:87} instead follows the {quest:1861} steps; a Human who took this one, the Gizmonitor steps.)"] = "Au niveau 10, {npc:1228}, le maître des mages de {area:131} à la {area:2102}, vous envoie voir {npc:5144} à {zone:1455}. L'accepter vous ferme {quest:1861} de {npc:5497} ; vous n'avez droit qu'à une quête de bâton ou d'orbe. (Un gnome qui a plutôt pris la quête de {npc:328} à {area:87} suit les étapes de {quest:1861} ; un humain qui a pris celle-ci, les étapes du Gizmonitor.)",
	-- ["At 10 {npc:328}, the {area:87} mage trainer, upstairs in the Lion's Pride Inn, sends you to {npc:5497} in {zone:1453}. Taking it shuts out {npc:5144}'s quest in {zone:1455}; you get one staff-or-orb quest."] = "Au niveau 10, {npc:328}, le maître des mages de {area:87}, à l'étage de l'auberge de la Fierté du lion, vous envoie voir {npc:5497} à {zone:1453}. L'accepter vous ferme la quête de {npc:5144} à {zone:1455} ; vous n'avez droit qu'à une quête de bâton ou d'orbe.",
}
