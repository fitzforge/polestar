-- French (frFR): the guide forever/class/rogue/ravenholdt (forever/class/rogue/ravenholdt.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:3486} Ravenholdt Manor · {npc:13085} Myrokos Silentform
	["Opens {area:3486}, the hidden rogue house in the Alterac hills, and {npc:13085}'s jobs against the Syndicate."] = "Ouvre le {area:3486}, la maison cachée des voleurs dans les collines d'Alterac, et les travaux de {npc:13085} contre le Syndicat.",
	-- {npc:13936} Ravenholdt
	["{npc:13936} reputation"] = "Réputation {npc:13936}",

	-- Step 1: The Elegant Letter
	-- {item:17126} Elegant Letter
	["The {item:17126}"] = "{item:17126}",
	-- {npc:332} Master Mathias Shaw · {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {zone:1454} Orgrimmar · {item:17126} Elegant Letter · {npc:13936} Ravenholdt · {item:17125} Seal of Ravenholdt · {npc:6707} Fahrad · {spell:1846} Detect Traps
	["At 24 any capital's rogue trainer ({npc:332} or {npc:918} in {zone:1453}, Gest or Ormok in {zone:1454}, and the others) has an {item:17126} from {npc:13936} for you: ask for it in their talk window. Open it: the quest gives you the {item:17125} for {npc:6707}. Learn {spell:1846} from your trainer first if you have not; the way in is a test of it."] = "Au niveau 24, le maître des voleurs de n'importe quelle capitale ({npc:332} ou {npc:918} à {zone:1453}, Gest ou Ormok à {zone:1454}, et les autres) a pour vous une {item:17126} de {npc:13936} : demandez-la dans sa fenêtre de dialogue. Ouvrez-la : la quête vous donne le {item:17125} pour {npc:6707}. Apprenez d'abord {spell:1846} auprès de votre maître si ce n'est pas fait ; l'accès en est une épreuve.",

	-- Step 2: Ravenholdt Manor
	-- {area:272} Tarren Mill · {area:271} Southshore · {area:275} Durnholde Keep · {spell:1846} Detect Traps · {area:3486} Ravenholdt Manor · {npc:6707} Fahrad · {npc:13936} Ravenholdt
	["Horde fly to {area:272}, Alliance to {area:271}. The trail to the manor is hard to see: it starts behind the plateau north of {area:275}, east of {area:272}, climbs into the hills and bends twice to a small tunnel. A chest sits in the tunnel: do not open it. Cast {spell:1846} near it and walk up close; that is the Rite of Cunning (it comes back after 5 minutes). Opening the chest calls Milton, an elite rogue of about level 32. Through the tunnel lies {area:3486}: {npc:6707} is upstairs inside. Do not attack anyone at the manor: it costs {npc:13936} reputation."] = "Horde : volez jusqu'à {area:272} ; Alliance : jusqu'à {area:271}. Le sentier vers le manoir est difficile à voir : il part derrière le plateau au nord du {area:275}, à l'est de {area:272}, grimpe dans les collines et tourne deux fois jusqu'à un petit tunnel. Un coffre se trouve dans le tunnel : ne l'ouvrez pas. Lancez {spell:1846} près de lui et approchez-vous ; c'est le Rite de la ruse (il revient au bout de 5 minutes). Ouvrir le coffre fait venir Milton, un voleur élite d'environ niveau 32. Au-delà du tunnel se trouve le {area:3486} : {npc:6707} est à l'étage, à l'intérieur. N'attaquez personne au manoir : cela coûte de la réputation auprès de {npc:13936}.",
	-- {spell:1846} Detect Traps
	["Rite of Cunning: {spell:1846} beside the tunnel chest"] = "Rite de la ruse : {spell:1846} près du coffre du tunnel",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	["{npc:6766}: {quest:6701}, repeatable; take it now, the emblems are quest items"] = "",

	-- Step 3: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {npc:13085} Myrokos Silentform · {quest:6701} Syndicate Emblems
	-- plural, as words: Syndicate Rogues = {npc:2260} Syndicate Rogue
	["{npc:266216} is inside {area:275}, the Syndicate fortress south of the manor; he can stand in any of fifteen spots in the keep, so search. Quick and quiet, says {npc:13085}. Pick the pockets of the level 20-21 Syndicate Rogues, Shadow Mages and Watchmen on your way: they carry {quest:6701} for the guards' repeatable reputation quest."] = "{npc:266216} est à l'intérieur du {area:275}, la forteresse du Syndicat au sud du manoir ; il peut se tenir à l'un de quinze endroits du donjon, alors cherchez bien. Vite et sans bruit, dit {npc:13085}. Faites les poches des Voleurs, Mages de l'ombre et Sentinelles du Syndicat de niveau 20-21 sur votre chemin : ils portent des {quest:6701} pour la quête de réputation répétable des gardes.",
	-- {quest:6701} Syndicate Emblems
	["Pick Pocket Syndicate members for {quest:6701}"] = "",

	-- Step 4: Myrokos Silentform
	-- {npc:6766} Ravenholdt Guard
	["{npc:6766}: one emblem each time, 100 reputation"] = "",

	-- Step 5: What's the Big Idea?
	-- {npc:13085} Myrokos Silentform · {area:280} Strahnbrad · {zone:1416} Alterac Mountains · {spell:921} Pick Pocket
	["In your mid 30s {npc:13085} has two more jobs; take both. Barton leads a Syndicate scouting party at {area:280}, in the east of the {zone:1416}, inside one of the houses with stealthed Syndicate around him. Pick his pocket for the report and do not kill him: he does not drop it. If you are lower than him he sees through stealth; Master of Deception helps, or Distract him, Vanish and come in from behind. {spell:921} can miss several times in a row."] = "Vers le milieu de la trentaine, {npc:13085} a deux autres travaux ; acceptez les deux. Barton mène une équipe d'éclaireurs du Syndicat à {area:280}, dans l'est des {zone:1416}, dans l'une des maisons, entouré de membres du Syndicat camouflés. Faites-lui les poches pour le rapport et ne le tuez pas : il ne le laisse pas tomber. Si vous êtes de plus bas niveau que lui, il voit à travers le camouflage ; le talent Maître de l'illusion aide, ou bien utilisez Distraction sur lui, puis Disparition, et revenez par-derrière. {spell:921} peut rater plusieurs fois de suite.",
	-- {item:275482} Barton's Scouting Report
	["Pick Pocket Barton for {item:275482}"] = "",

	-- Step 6: Covert Extraction
	-- {npc:13085} Myrokos Silentform · {area:281} Ruins of Alterac · {zone:1416} Alterac Mountains
	["Back to {npc:13085}; the report sends you after the Perenolde heirlooms. Two towers stand among the {area:281}, in the middle of the {zone:1416}, held by ogres: the shield lies in the northern tower, the sword in the southern one, which elite ogres ring and watch from far off. Stay stealthed; nothing guards the heirlooms inside."] = "Retournez voir {npc:13085} ; le rapport vous lance sur la piste des reliques des Perenolde. Deux tours se dressent parmi les {area:281}, au milieu des {zone:1416}, tenues par des ogres : le bouclier se trouve dans la tour nord, l'épée dans la tour sud, entourée d'ogres élites qui guettent de loin. Restez camouflé ; rien ne garde les reliques à l'intérieur.",
	-- {item:275636} Royal Aegis of Perenolde
	["{item:275636}, in the northern tower"] = "{item:275636}, dans la tour nord",
	-- {item:275635} Blade of House Perenolde
	["{item:275635}, in the southern tower"] = "{item:275635}, dans la tour sud",

	-- Step 7: A Way In
	-- {area:324} Stromgarde Keep · {area:313} Northfold Manor · {object:656157} Syndicate Footlocker (no name in this language: may be words) · {quest:96783} A Way In
	["{area:324} in western Arathi is a Syndicate stronghold; to get in you need a uniform. {area:313}, in north-western Arathi, is held by Syndicate Highwaymen, Pathstalkers and Mercenaries (level 30-32): find the {object:656157} there and take the uniform; that ends {quest:96783}."] = "Le {area:324}, dans l'ouest d'Arathi, est une place forte du Syndicat ; pour y entrer, il vous faut un uniforme. Le {area:313}, dans le nord-ouest d'Arathi, est tenu par des Malandrins, des Éclaireurs et des Mercenaires du Syndicat (niveau 30-32) : trouvez-y la cantine du Syndicat et prenez l'uniforme ; cela termine {quest:96783}.",
	-- {quest:96784} Master of Disguise · {item:275706} Syndicate Uniform
	["{quest:96784}: the {item:275706}"] = "{quest:96784} : l'{item:275706}",

	-- Step 8: Anastasia Miller
	-- {item:275706} Syndicate Uniform · {quest:96784} Master of Disguise · {quest:96785} Ain't No Telling · {npc:266847} Anastasia Miller
	-- plural, as words: Syndicate Prowlers = {npc:2588} Syndicate Prowler
	["Stromgarde's Syndicate Prowlers and Conjurors are elite (level 35-36): a rogue of 36 can slip past them, but fighting one alone is hard, so stay hidden or bring a friend. Put on the {item:275706} ({quest:96784} hands it to you at the footlocker) to pass as one of them; stealth or suspicious acts can break it. If the footlocker gave you no uniform, Anastasia hands you one with {quest:96785}. {npc:266847} is not inside the keep: she stands on a ledge on the outside of the castle wall. Jump across to it from the roof of the house beside the ledge."] = "Les Rôdeurs et Conjurateurs du Syndicat de Stromgarde sont élites (niveau 35-36) : un voleur de niveau 36 peut se glisser entre eux, mais en combattre un seul est difficile, alors restez caché ou venez avec un ami. Mettez l'{item:275706} ({quest:96784} vous le remet à la cantine) pour passer pour l'un des leurs ; le camouflage ou des actes suspects peuvent rompre le déguisement. Si la cantine ne vous a pas donné d'uniforme, Anastasia vous en remet un avec {quest:96785}. {npc:266847} n'est pas à l'intérieur du donjon : elle se tient sur une corniche à l'extérieur du mur du château. Sautez-y depuis le toit de la maison à côté de la corniche.",

	-- Step 9: Ain't No Telling
	-- {item:275709} Stolen Funds
	["She will not talk without something to bargain with. Her stash is upstairs in a house close to the keep: take the {item:275709}. If it is already open, wait for it to come back."] = "Elle ne parlera pas sans monnaie d'échange. Sa cachette est à l'étage d'une maison proche du donjon : prenez les {item:275709}. Si elle est déjà ouverte, attendez qu'elle revienne.",
	-- {item:275709} Stolen Funds
	["{item:275709}: Anastasia's Stash"] = "{item:275709} : la cachette d'Anastasia",

	-- Step 10: The Syndicate Sting
	-- {area:1057} Thoradin's Wall · {area:287} Hillsbrad · {item:275882} Intercepted Shipment · {item:275706} Syndicate Uniform · {npc:13085} Myrokos Silentform
	["Falconcrest's men make the handoff at the southern end of {area:1057}, the old wall between Arathi and {area:287}. Kill the two guarding the box and take the {item:275882}. Keep the {item:275706}: {npc:13085} wants it back with the shipment."] = "Les hommes de Falconcrest font l'échange à l'extrémité sud du {area:1057}, le vieux mur entre Arathi et {area:287}. Tuez les deux qui gardent la caisse et prenez la {item:275882}. Gardez l'{item:275706} : {npc:13085} le veut en retour avec la cargaison.",

	-- Step 11: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "Retour auprès de {npc:13085}",
	-- {npc:13085} Myrokos Silentform · {npc:13936} Ravenholdt
	["{npc:13085}: 70 silver, 300 {npc:13936} reputation"] = "{npc:13085} : 70 pa, 300 points de réputation auprès de {npc:13936}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 24 an {item:17126} from {npc:13936} starts this; the data gives it to you through {npc:332} or {npc:918} in {zone:1453}, or Gest or Ormok in {zone:1454}. The quest hands you the {item:17125} for {npc:6707}."] = "Au niveau 24, une {item:17126} de {npc:13936} lance cette quête ; les données vous la donnent par {npc:332} ou {npc:918} à {zone:1453}, ou par Gest ou Ormok à {zone:1454}. La quête vous remet le {item:17125} pour {npc:6707}.",
	-- ["At 36, {npc:13085} sends you after Barton's scouting report. Barton leads a Syndicate party at {area:280}, in the east of the {zone:1416}: pick his pocket, do not kill him."] = "Au niveau 36, {npc:13085} vous envoie chercher le rapport de reconnaissance de Barton. Barton mène un groupe du Syndicat à {area:280}, dans l'est de {zone:1416} : faites-lui les poches, ne le tuez pas.",
	-- ["Horde fly to {area:272}, Alliance to {area:271}. The manor hides in the hills east of {area:272}, up a path into the {zone:1416}; the Rite of Cunning is passing its way in."] = "La Horde prend un vol pour {area:272}, l'Alliance pour {area:271}. Le manoir se cache dans les collines à l'est de {area:272}, au bout d'un chemin qui monte dans {zone:1416} ; le Rite of Cunning sert à y entrer.",
	-- ["Opens {area:3486}, the hidden rogue house in the Alterac hills, and its first jobs."] = "Ouvre {area:3486}, le repaire caché des voleurs dans les collines d'Alterac, et ses premières missions.",
	-- ["Rite of Cunning"] = "Rite of Cunning",
	-- ["one emblem each time, 100 reputation"] = "un insigne à chaque fois, 100 points de réputation",
	-- ["{item:17124}, by {spell:921}"] = "{item:17124}, par {spell:921}",
	-- ["{item:275482}: pickpocket Barton"] = "{item:275482} : faites les poches de Barton",
	-- ["{item:275482}: {spell:921} on Barton"] = "{item:275482} : {spell:921} sur Barton",
	-- ["{npc:266216} is inside {area:275}, the Syndicate fortress in eastern {area:287}, south of the manor. Quick and quiet, says {npc:13085}."] = "{npc:266216} est à l'intérieur de {area:275}, la forteresse du Syndicat dans l'est de {area:287}, au sud du manoir. Vite et sans bruit, dit {npc:13085}.",
	-- ["{npc:6766}: {quest:6701}, repeatable"] = "{npc:6766} : {quest:6701}, répétable",
}
