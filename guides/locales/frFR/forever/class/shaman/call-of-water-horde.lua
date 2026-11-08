-- French (frFR): the guide forever/class/shaman/call-of-water-horde (forever/class/shaman/call-of-water-horde.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:63} Call of Water
	["{quest:63} (Horde)"] = "{quest:63} (Horde)",
	-- {item:5177} Water Totem · {spell:5394} Healing Stream Totem
	["The {item:5177} that lets you place water totems, and {spell:5394} with it."] = "Le {item:5177}, qui vous permet de poser des totems d'eau, et {spell:5394} avec.",

	-- Step 1: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom · {npc:5901} Islen Waterseer · {zone:1413} Barrens · {area:362} Razor Hill
	["At 20 {npc:5892} in the {object:172957} sends you to {npc:5901} in the {zone:1413}. (Swart in {area:362} gives the same letter: carry either.)"] = "Au niveau 20, {npc:5892}, dans la {object:172957}, vous envoie voir {npc:5901} dans les {zone:1413}. (Swart, à {area:362}, donne la même lettre : prenez l'une ou l'autre.)",

	-- Step 2: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {npc:5901} Islen Waterseer · {zone:1413} Barrens · {npc:3066} Narm Skychaser · {area:222} Bloodhoof Village
	["At 20 {npc:5906}, a shaman trainer on {area:1640} in {zone:1456}, sends you to {npc:5901} in the {zone:1413}. ({npc:3066} in {area:222} gives the same letter: carry either.)"] = "Au niveau 20, {npc:5906}, maître des chamans sur la {area:1640} aux {zone:1456}, vous envoie voir {npc:5901} dans les {zone:1413}. ({npc:3066}, au {area:222}, donne la même lettre : prenez l'une ou l'autre.)",

	-- Step 3: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} is not in {area:392}: take the small coast road south from {area:392} past the pirate camp and over a low hill; her fishing hut, with a shark strung up outside, stands by the water before the pirate ship. If you reach the ship you went too far."] = "{npc:5901} n'est pas à {area:392} : prenez la petite route côtière au sud de {area:392}, passez le camp des pirates et franchissez une colline basse ; sa cabane de pêcheur, avec un requin pendu devant, se dresse au bord de l'eau avant le navire pirate. Si vous arrivez au navire, vous êtes allé trop loin.",

	-- Step 4
	-- {npc:5901} Islen Waterseer · {npc:5892} Searn Firewarder
	["{npc:5901}: {npc:5892}'s letter"] = "{npc:5901} : la lettre de {npc:5892}",

	-- Step 5
	-- {npc:5901} Islen Waterseer · {npc:5906} Xanis Flameweaver
	["{npc:5901}: {npc:5906}' letter"] = "{npc:5901} : la lettre de {npc:5906}",

	-- Step 6
	-- {npc:5901} Islen Waterseer
	["{npc:5901}: Swart's letter"] = "{npc:5901} : la lettre de Swart",

	-- Step 7
	-- {npc:5901} Islen Waterseer
	["{npc:5901}: Narm's letter"] = "{npc:5901} : la lettre de Narm",

	-- Step 9: Brine
	-- {npc:5899} Brine · {zone:1413} Barrens · {area:378} Camp Taurajo · {area:1701} Blackthorn Ridge
	["{npc:5899} lives in the southern {zone:1413}, south of {area:378}: her hut sits on a hilltop of {area:1701} with a spinning windmill beside it, and the way up is the ridge by the lone tree. Quilboar camp all around the hill; Stormhides, thunderhawks and hyenas roam the plains on the way."] = "{npc:5899} vit dans le sud des {zone:1413}, au sud du {area:378} : sa hutte se dresse au sommet d'une colline de la {area:1701}, avec un moulin à vent qui tourne à côté, et l'on y monte par la crête près de l'arbre isolé. Des hurans campent tout autour de la colline ; des Peaux-de-tonnerre, des faucons-tonnerre et des hyènes errent dans les plaines en chemin.",

	-- Step 10: The Quilboar Watering Hole
	-- {object:107046} Quilboar Watering Hole
	["The {object:107046}"] = "Le {object:107046}",
	-- {npc:5899} Brine · {item:7766} Empty Brown Waterskin · {npc:3456} Razormane Pathfinder
	["The muddy pond below {npc:5899}'s hut. Step right into the puddle before you use the {item:7766} (too far away and it refuses). Filling it calls a hostile {npc:3456} (level 20): kill it, and watch for the quilboar hunter by the pond, who may start shooting afterwards."] = "La mare boueuse sous la hutte de {npc:5899}. Entrez bien dans la flaque avant d'utiliser l'{item:7766} (trop loin, il refuse). Le remplir appelle un {npc:3456} hostile (niveau 20) : tuez-le, et méfiez-vous du chasseur huran près de la mare, qui peut se mettre à tirer ensuite.",
	-- {item:7766} Empty Brown Waterskin
	["{item:7766}, standing in the puddle"] = "{item:7766}, debout dans la flaque",

	-- Step 12: The Spring Well
	-- {object:107045} Spring Well
	["The {object:107045}"] = "Le {object:107045}",
	-- {object:107045} Spring Well · {area:272} Tarren Mill · {zone:1413} Barrens · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:287} Hillsbrad · {item:7768} Empty Red Waterskin
	["The {object:107045} stands in the middle of {area:272}, just outside the church. From the {zone:1413}: the zeppelin from {zone:1454} to {zone:1420}, then south past the {zone:1458} and through {zone:1421} (or fly once you have the {area:272} flight path). {area:287} is contested: Alliance players may attack. Stand beside the well and use the {item:7768}."] = "Le {object:107045} se dresse au milieu de {area:272}, juste devant l'église. Depuis les {zone:1413} : le zeppelin d'{zone:1454} vers {zone:1420}, puis au sud après {zone:1458} et à travers la {zone:1421} (ou volez une fois que vous avez le trajet aérien de {area:272}). {area:287} est une zone contestée : les joueurs de l'Alliance peuvent attaquer. Placez-vous à côté du puits et utilisez l'{item:7768}.",
	-- {item:7768} Empty Red Waterskin
	["{item:7768}, beside the well"] = "{item:7768}, à côté du puits",

	-- Step 14: The Ruins of Stardust
	-- {area:415} Astranaar · {zone:1413} Barrens · {area:1703} Mor'shan Rampart · {npc:12836} Wandering Protector · {zone:1440} Ashenvale · {item:7767} Empty Blue Waterskin
	["The right fountain stands in a ring of standing stones on the island of the small green lake south of {area:415}, west of Lake Mystral (not the island in Lake Mystral itself). From the {zone:1413} take the road north through the {area:1703} and on west. Water elementals and walking treants guard the lake and root you in place; an elite {npc:12836} roams {zone:1440} and can pass close by. Use the {item:7767} beside the fountain."] = "La bonne fontaine se dresse dans un cercle de pierres levées, sur l'île du petit lac vert au sud d'{area:415}, à l'ouest du lac Mystral (pas l'île du lac Mystral lui-même). Depuis les {zone:1413}, prenez la route vers le nord par le {area:1703}, puis continuez vers l'ouest. Des élémentaires d'eau et des tréants errants gardent le lac et vous immobilisent ; un {npc:12836} élite parcourt {zone:1440} et peut passer tout près. Utilisez l'{item:7767} à côté de la fontaine.",
	-- {item:7767} Empty Blue Waterskin
	["{item:7767}, beside the fountain"] = "{item:7767}, à côté de la fontaine",

	-- Step 15: Brine
	-- {npc:5899} Brine · {item:7810} Vial of Purest Water · {npc:5901} Islen Waterseer
	["Back to {npc:5899}. She gives you the {item:7810} for {npc:5901}."] = "Retournez voir {npc:5899}. Elle vous donne la {item:7810} pour {npc:5901}.",
	-- {item:7810} Vial of Purest Water · {npc:5901} Islen Waterseer
	["the {item:7810}, for {npc:5901}"] = "la {item:7810}, pour {npc:5901}",

	-- Step 16: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta · {item:7811} Remaining Drops of Purest Water
	["{npc:5901} hands you the {item:6637} and the {item:7811}: take everything she offers before you leave for Silverpine, or you will be back for more."] = "{npc:5901} vous remet le {item:6637} et les {item:7811} : prenez tout ce qu'elle propose avant de partir pour la forêt des Pins-Argentés, sinon vous devrez revenir en chercher.",
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}"] = "{npc:5901} : votre {item:6637}",

	-- Step 17: Lost the Water Sapta?
	-- {quest:972} Water Sapta
	["Lost the {quest:972}?"] = "Vous avez perdu le {quest:972} ?",
	-- {quest:972} Water Sapta · {npc:5901} Islen Waterseer
	["Only if the {quest:972} is gone from your bags: {npc:5901} gives you another."] = "Seulement si le {quest:972} n'est plus dans vos sacs : {npc:5901} vous en donne un autre.",
	-- {npc:5901} Islen Waterseer · {quest:972} Water Sapta
	["{npc:5901}: a new {quest:972}"] = "{npc:5901} : un nouveau {quest:972}",

	-- Step 18: The Brazier of Everfount
	-- {object:113791} Brazier of Everfount
	["The {object:113791}"] = "Le {object:113791}",
	-- {area:228} Sepulcher · {item:6637} Water Sapta · {npc:5894} Corrupt Minor Manifestation of Water · {spell:8056} Frost Shock · {spell:122} Frost Nova
	["Fly to the {area:228}. The shrine lies in a hollow just south-west of it: go round the back of the crypt to the thick tree between the two hills, hop past it onto the rocks and drop west down the slope to the pool (each drop costs a little health). Drink the {item:6637} beside the tall standing stone by the pool: several water elementals appear, and only the corrupt one near the middle can be attacked (Tab picks it). The {npc:5894} is level 22 and casts {spell:8056} and {spell:122}; if someone just killed it, it is back in about three minutes. Its bracers always drop."] = "Volez jusqu'au {area:228}. Le sanctuaire se trouve dans un creux juste au sud-ouest : faites le tour de la crypte par l'arrière jusqu'au gros arbre entre les deux collines, sautez sur les rochers derrière lui et descendez la pente vers l'ouest jusqu'au bassin (chaque saut coûte un peu de vie). Buvez le {item:6637} à côté de la haute pierre levée près du bassin : plusieurs élémentaires d'eau apparaissent, et seul le corrompu, près du milieu, peut être attaqué (Tab le cible). La {npc:5894} est de niveau 22 et lance {spell:8056} et {spell:122} ; si quelqu'un vient de la tuer, elle revient en trois minutes environ. Ses brassards tombent toujours.",
	-- {item:6637} Water Sapta
	["{item:6637}, beside the standing stone"] = "{item:6637}, à côté de la pierre levée",

	-- Step 19: The Minor Manifestation of Water
	-- {npc:5895} Minor Manifestation of Water
	["The {npc:5895}"] = "La {npc:5895}",
	-- {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {spell:8202} Sapta Sight · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {quest:63} Call of Water · {quest:972} Water Sapta · {npc:7007} Tiev Mordune
	["Click the {object:113791} to place the bracers and the drops. A few seconds later the pure {npc:5895} rises on the stone in the middle of the pool: speak to it while the {spell:8202} lasts (drink again by the stone if it has worn off). It gives you the {item:7813} for {npc:5901}. Gone before you could speak to it? Back at {npc:5901} ask for {quest:63} (a fresh {quest:972} for {npc:7007}, who stands just west of the shrine): hand it to Tiev, stay close while he calls the spirit back, then speak to it."] = "Cliquez sur le {object:113791} pour y poser les brassards et les gouttes. Quelques secondes plus tard, la {npc:5895} pure s'élève sur la pierre au milieu du bassin : parlez-lui tant que dure la {spell:8202} (buvez de nouveau près de la pierre si elle s'est dissipée). Elle vous donne l'{item:7813} pour {npc:5901}. Elle a disparu avant que vous lui parliez ? Retournez voir {npc:5901} et demandez {quest:63} (un nouveau {quest:972} pour {npc:7007}, qui se tient juste à l'ouest du sanctuaire) : remettez-le à Tiev, restez près de lui pendant qu'il rappelle l'esprit, puis parlez à celui-ci.",

	-- Step 20: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet · {item:5177} Water Totem
	["Back to {npc:5901} south of {area:392}. Keep the {item:5177} in your bags for good: every water totem needs it."] = "Retournez voir {npc:5901}, au sud de {area:392}. Gardez le {item:5177} dans vos sacs pour de bon : chaque totem d'eau en a besoin.",
	-- {npc:5901} Islen Waterseer · {spell:5394} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {spell:5394} and your {item:5177}"] = "{npc:5901} : {spell:5394} et votre {item:5177}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:5892} in the {object:172957} sends you to {npc:5901} in the {zone:1413}."] = "Au niveau 20, {npc:5892}, dans la {object:172957}, vous envoie voir {npc:5901} dans les {zone:1413}.",
	-- ["At 20 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5901} in the {zone:1413}."] = "Au niveau 20, {npc:5906}, maître des chamans à {zone:1456}, vous envoie voir {npc:5901} dans les {zone:1413}.",
	-- ["Fill the {item:7766} at the quilboar watering hole"] = "Remplissez l'{item:7766} au point d'eau des huttiers",
	-- ["Fill the {item:7767} at the fountain"] = "Remplissez l'{item:7767} à la fontaine",
	-- ["Fill the {item:7768} at the {object:107045}"] = "Remplissez l'{item:7768} au {object:107045}",
	-- ["Fly to the {area:228}: the {object:113791} stands on the hill just south-west of it. Drink the {item:6637} there, beat the {npc:5894} for its bracers and place them in the brazier, then speak to the {npc:5895} and keep the {item:7813} for {npc:5901}."] = "Volez jusqu'au {area:228} : le {object:113791} se dresse sur la colline juste au sud-ouest. Buvez-y le {item:6637}, battez la {npc:5894} pour obtenir ses brassards et placez-les dans le brasero, puis parlez à la {npc:5895} et gardez l'{item:7813} pour {npc:5901}.",
	-- ["Take the zeppelin from {zone:1454} to {zone:1420} and travel south to {area:272}. The {object:107045} stands beside the inn."] = "Prenez le zeppelin d'{zone:1454} jusqu'à {zone:1420} et voyagez vers le sud jusqu'à {area:272}. Le {object:107045} se trouve à côté de l'auberge.",
	-- ["The fountain stands in the middle of the {area:418}, in south-western {zone:1440}."] = "La fontaine se dresse au milieu des {area:418}, dans le sud-ouest d'{zone:1440}.",
	-- ["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}."] = "La hutte de {npc:5899} se dresse sur la crête au-dessus du point d'eau des huttiers, au sud du {area:378}.",
	-- ["{npc:5901} waits on the hill south of {area:392}."] = "{npc:5901} attend sur la colline au sud de {area:392}.",
}
