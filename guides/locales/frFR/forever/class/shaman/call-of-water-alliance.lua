-- French (frFR): the guide forever/class/shaman/call-of-water-alliance (forever/class/shaman/call-of-water-alliance.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94494} Call of Water
	["{quest:94494} (Alliance)"] = "{quest:94494} (Alliance)",
	-- {item:5177} Water Totem · {spell:5394} Healing Stream Totem
	["The {item:5177} that lets you place water totems, and {spell:5394} with it."] = "Le {item:5177}, qui permet de poser les totems d'eau, et {spell:5394} avec.",

	-- Step 1: Eldrun Stormbreaker
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {object:32362} Mystic Ward · {npc:258043} Norric Lochthane · {zone:1432} Loch Modan
	["At 20 {npc:258098}, the shaman trainer in {zone:1455}'s {object:32362}, sends you to {npc:258043} in {zone:1432}."] = "Au niveau 20, {npc:258098}, maître des chamans dans {object:32362} de {zone:1455}, vous envoie voir {npc:258043} au {zone:1432}.",

	-- Step 2: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {area:146} Stonewrought Dam · {area:144} Thelsamar
	["{npc:258043}'s burrow hut stands on the north-western shore of the loch, below {area:146}, north of {area:144}."] = "La hutte-terrier de {npc:258043} se dresse sur la rive nord-ouest du loch, sous le {area:146}, au nord de {area:144}.",

	-- Step 3: Hervdana Saegrund
	-- {npc:258203} Hervdana Saegrund · {zone:1437} Wetlands · {area:836} Dun Algaz · {zone:1432} Loch Modan
	["{npc:258203}'s family lives in a cave beneath the southern falls of the {zone:1437}, east of {area:836}: not in a town. Through the Algaz tunnel north of {zone:1432}, then east off the road."] = "La famille de {npc:258203} vit dans une grotte sous les chutes du sud des {zone:1437}, à l'est de {area:836} : pas dans une ville. Passez le tunnel d'Algaz au nord du {zone:1432}, puis quittez la route vers l'est.",

	-- Step 4: The brown waterskin
	["The brown waterskin"] = "L'outre marron",
	-- {item:265732} Unfilled Brown Waterskin · {npc:258203} Hervdana Saegrund · {object:147516} Dark Iron
	["Fill the {item:265732} at the bottom of the waterfalls below {npc:258203}'s cave, where the fresh water meets the brackish. {object:147516} dwarves roam near the falls."] = "Remplissez l'{item:265732} au pied des chutes sous la grotte de {npc:258203}, là où l'eau douce rencontre l'eau saumâtre. Des nains {object:147516} rôdent près des chutes.",

	-- Step 6: The red waterskin
	["The red waterskin"] = "L'outre rouge",
	-- {area:71} Stonewatch Falls · {area:68} Lake Everstill · {zone:1455} Ironforge · {area:69} Lakeshire · {item:265747} Unfilled Red Waterskin · {npc:258203} Hervdana Saegrund
	-- plural, as words: Murloc Nightcrawlers = {npc:544} Murloc Nightcrawler
	["{area:71} pour out of {area:68} at the east end of Redridge (fly from {zone:1455} to {area:69}). Fill the {item:265747} at their foot, where the Murloc Nightcrawlers gather; pull the murlocs off the spot first. If the skin vanishes without counting, abandon the quest and take it again from {npc:258203} for a new one."] = "Les {area:71} s'écoulent du {area:68} à l'extrémité est des Carmines (volez de {zone:1455} à {area:69}). Remplissez l'{item:265747} à leur pied, là où se rassemblent les Marcheurs de l'ombre murlocs ; éloignez d'abord les murlocs de l'endroit. Si l'outre disparaît sans compter, abandonnez la quête et reprenez-la auprès de {npc:258203} pour en avoir une nouvelle.",

	-- Step 8: The blue waterskin
	["The blue waterskin"] = "L'outre bleue",
	-- {area:150} Menethil Harbor · {area:442} Auberdine · {area:271} Southshore · {zone:1439} Darkshore · {area:415} Astranaar · {zone:1440} Ashenvale · {item:265772} Unfilled Blue Waterskin
	["Take the boat from {area:150} to {area:442} (it stops in {area:271} on the way), then fly or walk south through {zone:1439} to {area:415} in {zone:1440}. Fill the {item:265772} in the lake around the town, then the boat back to Menethil."] = "Prenez le bateau de {area:150} à {area:442} (il fait escale à {area:271} en chemin), puis volez ou marchez vers le sud à travers {zone:1439} jusqu'à {area:415}, en {zone:1440}. Remplissez l'{item:265772} dans le lac autour de la ville, puis reprenez le bateau pour Menethil.",

	-- Step 9: Hervdana Saegrund
	-- {item:7810} Vial of Purest Water · {npc:258043} Norric Lochthane
	["the {item:7810}, for {npc:258043}"] = "la {item:7810}, pour {npc:258043}",

	-- Step 10: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {area:146} Stonewrought Dam · {item:7810} Vial of Purest Water · {item:6637} Water Sapta · {item:7811} Remaining Drops of Purest Water · {zone:1436} Westfall
	["Back to {npc:258043} by {area:146} with the {item:7810}. He hands you the {item:6637} and the {item:7811}: keep both for {zone:1436}."] = "Retournez voir {npc:258043} près du {area:146} avec la {item:7810}. Il vous remet le {item:6637} et les {item:7811} : gardez les deux pour la {zone:1436}.",
	-- {npc:258043} Norric Lochthane · {item:6637} Water Sapta
	["{npc:258043}: your {item:6637}"] = "{npc:258043} : votre {item:6637}",

	-- Step 11: Lost the Water Sapta?
	-- {quest:94616} Water Sapta
	["Lost the {quest:94616}?"] = "Vous avez perdu le {quest:94616} ?",
	-- {quest:94616} Water Sapta · {npc:258043} Norric Lochthane · {zone:1436} Westfall
	["Only if the {quest:94616} is gone from your bags: {npc:258043} gives you another before you leave for {zone:1436}."] = "Seulement si le {quest:94616} n'est plus dans vos sacs : {npc:258043} vous en donne un autre avant votre départ pour la {zone:1436}.",
	-- {npc:258043} Norric Lochthane · {quest:94616} Water Sapta
	["{npc:258043}: a new {quest:94616}"] = "{npc:258043} : un nouveau {quest:94616}",

	-- Step 12: Stendel's Pond
	-- {area:108} Sentinel Hill · {area:20} Moonbrook · {area:919} Stendel's Pond · {object:619896} Forgotten Shrine · {item:6637} Water Sapta · {npc:5894} Corrupt Minor Manifestation of Water · {spell:8056} Frost Shock · {spell:122} Frost Nova · {item:7811} Remaining Drops of Purest Water · {npc:258043} Norric Lochthane · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water
	["Fly to {area:108} and head south to {area:20}: {area:919} and the {object:619896} lie just north of it. Drink the {item:6637} by the shrine to see the {npc:5894} (level 22, {spell:8056} and {spell:122}; one spawn, back three minutes after a kill), defeat it for its bracers (always dropped), then place them and the {item:7811} on the {object:619896} (this, not {npc:258043}, ends the quest). Click the shrine again: the {npc:5895} rises beside it; speak to it before you walk off (if it is gone, abandon and take the quest again at the shrine). It gives you the {item:7813}."] = "Volez jusqu'à la {area:108} et allez au sud jusqu'à {area:20} : l'{area:919} et le {object:619896} se trouvent juste au nord. Buvez le {item:6637} près du sanctuaire pour voir la {npc:5894} (niveau 22, {spell:8056} et {spell:122} ; une seule apparition, de retour trois minutes après sa mort), vainquez-la pour ses brassards (toujours lâchés), puis posez-les avec les {item:7811} sur le {object:619896} (c'est cela, et non {npc:258043}, qui termine la quête). Cliquez de nouveau sur le sanctuaire : la {npc:5895} s'élève à côté ; parlez-lui avant de vous éloigner (si elle a disparu, abandonnez la quête et reprenez-la au sanctuaire). Elle vous donne l'{item:7813}.",
	-- {npc:5895} Minor Manifestation of Water
	["{npc:5895}, beside the shrine"] = "",

	-- Step 13: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {item:7813} Shard of Water · {item:5177} Water Totem
	["Back to {npc:258043} with the {item:7813}. Keep the {item:5177} in your bags for good: every water totem needs it."] = "Retournez voir {npc:258043} avec l'{item:7813}. Gardez le {item:5177} dans vos sacs pour de bon : chaque totem d'eau en a besoin.",
	-- {npc:258043} Norric Lochthane · {spell:5394} Healing Stream Totem · {item:5177} Water Totem
	["{npc:258043}: {spell:5394} and your {item:5177}"] = "{npc:258043} : {spell:5394} et votre {item:5177}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:258043} in {zone:1432}."] = "Au niveau 20, {npc:258098}, le maître des chamans de {zone:1455}, vous envoie voir {npc:258043} au {zone:1432}.",
	-- ["Fill the {item:265732} at the bottom of the waterfalls below {npc:258203}'s cave, where the fresh water meets the brackish."] = "Remplissez l'{item:265732} au pied des chutes sous la grotte d'{npc:258203}, là où l'eau douce rencontre l'eau saumâtre.",
	-- ["{area:71} pour out of {area:68} at the east end of Redridge. Fill the {item:265747} at their foot, where the Murloc Nightcrawlers gather."] = "{area:71} se déversent du {area:68} à l'extrémité est des Carmines. Remplissez {item:265747} à leur pied, là où se rassemblent les Marcheurs de l'ombre murlocs ({npc:544}).",
	-- ["{area:71} pour out of {area:68} at the east end of Redridge. Fill the {item:265747} at their foot, where the Murloc {item:6530} gather."] = "Les {area:71} s'écoulent du {area:68}, à l'est des Carmines. Remplissez l'{item:265747} à leur pied, où se rassemblent les Marcheurs de l'ombre murlocs ({item:6530}).",
	-- ["{area:919} lies outside {area:20}. Drink the {item:6637} there and defeat the {npc:5894} for its bracers, then place them and the {item:7811} on the {object:619896}. The {npc:5895} it calls forth gives you the {item:7813}."] = "L'{area:919} se trouve à l'extérieur de {area:20}. Buvez-y le {item:6637} et vainquez la {npc:5894} pour ses brassards, puis posez-les avec les {item:7811} sur le {object:619896}. La {npc:5895} ainsi appelée vous donne l'{item:7813}.",
	-- ["{npc:258043}'s burrow hut stands on the north-western edge of the loch, south of {area:146}."] = "La hutte de {npc:258043} se trouve au bord nord-ouest du loch, au sud du {area:146}.",
	-- ["{npc:258203}'s family lives in a cave beneath the southern falls of the {zone:1437}."] = "La famille d'{npc:258203} vit dans une grotte sous les chutes du sud des {zone:1437}.",
	-- ["{npc:258203}: take the boat from {area:150} to {area:442} (it stops in {area:271} on the way), then go south to {area:415}. Fill the {item:265772} in the lake around the town."] = "{npc:258203} : prenez le bateau de {area:150} à {area:442} (il fait escale à {area:271}), puis allez au sud jusqu'à {area:415}. Remplissez l'{item:265772} dans le lac autour de la ville.",
	-- ["{npc:5895}, at the shrine"] = "{npc:5895}, au sanctuaire",
}
