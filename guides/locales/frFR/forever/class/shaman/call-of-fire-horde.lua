-- French (frFR): the guide forever/class/shaman/call-of-fire-horde (forever/class/shaman/call-of-fire-horde.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1522} Call of Fire
	["{quest:1522} (Horde)"] = "{quest:1522} (Horde)",
	-- {item:5176} Fire Totem · {spell:3599} Searing Totem · {item:263412} Totem of Charged Flames
	["Your {item:5176} for every fire totem, {spell:3599} with it, and Forever's {item:263412}."] = "Votre {item:5176} pour chaque totem de feu, {spell:3599} avec, et le {item:263412} propre à Forever.",

	-- Step 1: Swart
	-- {npc:3173} Swart · {area:362} Razor Hill · {npc:5907} Kranal Fiss · {zone:1413} Barrens · {npc:5892} Searn Firewarder · {zone:1454} Orgrimmar
	["At 10 {npc:3173}, the shaman trainer on the east side of {area:362}, sends you to {npc:5907} in the {zone:1413}. Already carry {npc:5892}'s letter from {zone:1454}? It goes to {npc:5907} too: skip {npc:3173}."] = "Au niveau 10, {npc:3173}, maître des chamans du côté est de {area:362}, vous envoie voir {npc:5907} dans les {zone:1413}. Vous avez déjà la lettre de {npc:5892}, venue d'{zone:1454} ? Elle mène aussi à {npc:5907} : passez {npc:3173}.",

	-- Step 2: Narm Skychaser
	-- {npc:3066} Narm Skychaser · {area:222} Bloodhoof Village · {npc:5907} Kranal Fiss · {zone:1413} Barrens · {npc:5906} Xanis Flameweaver · {zone:1456} Thunder Bluff
	["At 10 {npc:3066}, the shaman trainer in {area:222}, sends you to {npc:5907} in the {zone:1413}. Already carry {npc:5906}'s letter from {zone:1456}? It goes to {npc:5907} too: skip Narm."] = "Au niveau 10, {npc:3066}, maître des chamans au {area:222}, vous envoie voir {npc:5907} dans les {zone:1413}. Vous avez déjà la lettre de {npc:5906}, venue des {zone:1456} ? Elle mène aussi à {npc:5907} : passez Narm.",

	-- Step 3: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {zone:1411} Durotar · {area:1704} Grol'dom Farm · {area:379} Far Watch Post · {zone:1440} Ashenvale
	["{npc:5907} is not in the Crossroads: take the road north from the Crossroads and fork east towards {zone:1411}; past {area:1704} he paces by a tall tower east of the road (from {zone:1411}: over the Southfury bridge, past {area:379}). If you reach {zone:1440} you went too far."] = "",

	-- Step 4
	-- {npc:5907} Kranal Fiss · {npc:3173} Swart
	["{npc:5907}: {npc:3173}'s letter"] = "{npc:5907} : la lettre de {npc:3173}",

	-- Step 5
	-- {npc:5907} Kranal Fiss · {npc:5892} Searn Firewarder
	["{npc:5907}: {npc:5892}'s letter"] = "{npc:5907} : la lettre de {npc:5892}",

	-- Step 6
	-- {npc:5907} Kranal Fiss · {npc:3066} Narm Skychaser
	["{npc:5907}: {npc:3066}'s letter"] = "{npc:5907} : la lettre de {npc:3066}",

	-- Step 7
	-- {npc:5907} Kranal Fiss · {npc:5906} Xanis Flameweaver
	["{npc:5907}: {npc:5906}'s letter"] = "{npc:5907} : la lettre de {npc:5906}",

	-- Step 8: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {item:6653} Torch of the Dormant Flame
	["{npc:5907} hands you the {item:6653}: keep it until the end of the chain."] = "{npc:5907} vous remet la {item:6653} : gardez-la jusqu'à la fin de la chaîne.",

	-- Step 9: Telf Joolam
	-- {zone:1411} Durotar · {npc:5900} Telf Joolam
	["Back east over the bridge, then south along the {zone:1411} bank of the river to where the mountains meet the water. The trail up starts at the foot of the mountain beside a small dark stone carved with symbols, near the quilboar camp; it is narrow, and a slip costs fall damage. {npc:5900} keeps the shrine at the top."] = "Repassez le pont vers l'est, puis longez vers le sud la rive de {zone:1411} jusqu'à l'endroit où les montagnes rejoignent l'eau. Le sentier qui monte part du pied de la montagne, à côté d'une petite pierre sombre gravée de symboles, près du camp des hurans ; il est étroit, et une glissade coûte des dégâts de chute. {npc:5900} garde le sanctuaire au sommet.",

	-- Step 10: Fire Tar
	-- {item:5026} Fire Tar
	-- plural, as words: Fireballs = {spell:133} Fireball
	["The Razormane casters north-east of the Crossroads drop the {item:5026} three times in four: Water Seekers and Thornweavers (level 10-11), Geomancers (level 12-13, they throw Fireballs and run for help when hurt) and Mystics (level 13-14, they heal themselves at low health). Pull them one at a time."] = "",

	-- Step 11: Reagent Pouch
	-- {spell:348} Immolate · {area:371} Dustwind Cave · {area:362} Razor Hill · {area:817} Skull Rock · {zone:1454} Orgrimmar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["The Burning Blade Cultists (level 10-11, they call imps and cast {spell:348}) live deep in {area:371} north of {area:362}: climb the ramp just north-east of town and stay on the high ground above the ravines. The orcs at the cave mouth are not cultists; the cultists are further in, off to the left. Three kills in four drop a pouch. {area:817} by {zone:1454} is the wrong cave."] = "Les Sectateurs de la Lame ardente (niveau 10-11, ils appellent des diablotins et lancent {spell:348}) vivent au fond de la {area:371}, au nord de {area:362} : montez la rampe juste au nord-est du village et restez en hauteur au-dessus des ravins. Les orcs à l'entrée de la grotte ne sont pas des sectateurs ; les sectateurs sont plus loin, sur la gauche. Trois fois sur quatre, ils lâchent une bourse. Le {area:817}, près d'{zone:1454}, n'est pas la bonne grotte.",

	-- Step 12: Telf Joolam
	-- {npc:5900} Telf Joolam · {quest:1464} Fire Sapta
	["Back up the trail to {npc:5900}. He makes the {quest:1464} from the tar and the pouch and hands it to you with the torch: keep both."] = "Remontez le sentier jusqu'à {npc:5900}. Il prépare le {quest:1464} avec le goudron et la bourse et vous le remet avec la torche : gardez les deux.",

	-- Step 13: Lost the Fire Sapta?
	-- {quest:1464} Fire Sapta
	["Lost the {quest:1464}?"] = "Vous avez perdu le {quest:1464} ?",
	-- {quest:1464} Fire Sapta · {npc:5900} Telf Joolam
	["Only if the {quest:1464} is gone from your bags: {npc:5900} gives you another."] = "Seulement si le {quest:1464} n'est plus dans vos sacs : {npc:5900} vous en donne un autre.",
	-- {npc:5900} Telf Joolam · {quest:1464} Fire Sapta
	["{npc:5900}: a new {quest:1464}"] = "{npc:5900} : un nouveau {quest:1464}",

	-- Step 14: The Minor Manifestation of Fire
	-- {npc:5893} Minor Manifestation of Fire
	["The {npc:5893}"] = "La {npc:5893}",
	-- {item:6636} Fire Sapta · {object:63674} Shaman Shrine (no name in this language: may be words) · {spell:8017} Rockbiter Weapon · {spell:8042} Earth Shock · {item:6655} Glowing Ember
	["Drink the {item:6636} beside the {object:63674}, the big grey stone just below the summit, then climb to the plateau. Of the fire elementals there only the one in the middle can be attacked: it is level 12, immune to fire and grows stronger the longer the fight lasts, so open at once with {spell:8017} and {spell:8042} and leave the others alone. Its {item:6655} drops every time."] = "Buvez le {item:6636} à côté du sanctuaire chaman, la grande pierre grise juste sous le sommet, puis montez sur le plateau. Parmi les élémentaires de feu qui s'y trouvent, seul celui du milieu peut être attaqué : il est de niveau 12, insensible au feu et devient plus fort à mesure que le combat dure ; ouvrez donc aussitôt avec {spell:8017} et {spell:8042} et laissez les autres tranquilles. Sa {item:6655} tombe à chaque fois.",
	-- {item:6636} Fire Sapta · {object:63674} Shaman Shrine (no name in this language: may be words)
	["{item:6636}, beside the {object:63674}"] = "{item:6636}, à côté du sanctuaire chaman",

	-- Step 15: The Brazier of the Dormant Flame
	-- {object:61934} Brazier of the Dormant Flame
	["The {object:61934}"] = "Le {object:61934}",
	-- {object:61934} Brazier of the Dormant Flame · {item:277329} Torch of Eternal Flame
	["Click the {object:61934} on the plateau with the torch in your bags to place the ember, then click it a second time: the next quest does not open by itself. It gives you the lit {item:277329}."] = "Cliquez sur le {object:61934} du plateau avec la torche dans vos sacs pour y déposer la braise, puis cliquez une deuxième fois : la quête suivante ne s'ouvre pas d'elle-même. Elle vous donne la {item:277329} allumée.",

	-- Step 16: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {item:5176} Fire Totem
	["Down the trail, back over the bridge to {npc:5907} by his tower. Keep the {item:5176} in your bags for good: every fire totem needs it."] = "Redescendez le sentier et repassez le pont jusqu'à {npc:5907}, près de sa tour. Gardez le {item:5176} dans vos sacs pour de bon : chaque totem de feu en a besoin.",
	-- {npc:5907} Kranal Fiss · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:5907} : {spell:3599}, votre {item:5176} et le {item:263412}",

	-- Step 17: Sessaria Skystride
	-- {npc:252382} Sessaria Skystride · {npc:251968} Ayessa Dawnsinger · {area:16638} Valanaar · {item:6653} Torch of the Dormant Flame · {npc:254082} Aarnor Galestrike · {quest:97243} Call of Fire · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {spell:8050} Flame Shock · {npc:268605} Kuramaa
	["At 10 {npc:252382}, the shaman trainer beside {npc:251968} in {area:16638}, hands you the {item:6653} ({npc:254082} offers the same quest). Already left the isle? A {quest:97243} sends you back to them: take the skycutter from the cliffs south of {area:17045}, north of {zone:1456}. Learn {spell:8050} from her now: {npc:268605}, later in the chain, only takes fire damage."] = "Au niveau 10, {npc:252382}, maîtresse des chamans à côté de {npc:251968} à {area:16638}, vous remet la {item:6653} ({npc:254082} propose la même quête). Vous avez déjà quitté l'île ? Une quête {quest:97243} vous renvoie vers eux : prenez le brise-ciel depuis les falaises au sud du {area:17045}, au nord des {zone:1456}. Apprenez {spell:8050} auprès d'elle maintenant : {npc:268605}, plus loin dans la chaîne, ne subit que les dégâts de feu.",

	-- Step 18: Olariaan Swiftburn
	-- {area:16638} Valanaar · {area:16663} Windfield Orchard · {npc:268592} Olariaan Swiftburn
	["The Shrine of Flames hides on the island's outer rim south-west of {area:16638}, just south-east of {area:16663}: {npc:268592} keeps it."] = "Le sanctuaire des Flammes se cache sur le bord extérieur de l'île, au sud-ouest de {area:16638}, juste au sud-est du {area:16663} : {npc:268592} le garde.",

	-- Step 19: Skypriest Faladiel
	-- {npc:268602} Skypriest Faladiel · {area:16638} Valanaar · {area:16629} Shrine of Akir · {area:17675} East Pylon Watchtower
	["{npc:268602} (level 10, a turncoat Windshaper with a single spawn) holds the farm north-east past {area:16638}, just south of the {area:16629}, on the hill west of the falls north of the {area:17675}. Kill him and take his heart."] = "{npc:268602} (niveau 10, un Façonneur-de-vent renégat qui n'apparaît qu'en un seul exemplaire) tient la ferme au nord-est après {area:16638}, juste au sud du {area:16629}, sur la colline à l'ouest des chutes au nord de la {area:17675}. Tuez-le et prenez son cœur.",

	-- Step 20: Olariaan Swiftburn
	-- {npc:268592} Olariaan Swiftburn
	["Back to {npc:268592} at the Shrine of Flames."] = "Retournez voir {npc:268592} au sanctuaire des Flammes.",

	-- Step 21: Kuramaa
	-- {object:660848} Kuramaa's Stump (no name in this language: may be words) · {area:16638} Valanaar · {npc:268605} Kuramaa · {spell:8050} Flame Shock
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["{object:660848} is the twisted stump on the hilltop by the Shen'dar Highlands Anchor Pylon, west of {area:16638}, in the hills south of the Windsong Crawlers' lakes. Knock on it to call {npc:268605} (level 10). The spirit shrugs off most magic: only fire hurts it, so keep {spell:8050} on it. Take its wooden mask."] = "La souche de Kuramaa est la souche tordue au sommet de la colline près du pylône d'ancrage des Hautes-terres de Shen'dar, à l'ouest de {area:16638}, dans les collines au sud des lacs des Clampants chantevent. Frappez dessus pour appeler {npc:268605} (niveau 10). L'esprit ignore presque toute la magie : seul le feu le blesse, maintenez donc {spell:8050} sur lui. Prenez son masque de bois.",
	-- {object:660848} Kuramaa's Stump (no name in this language: may be words)
	["{object:660848}: knock on the bark"] = "La souche de Kuramaa : frappez sur l'écorce",

	-- Step 22: The Eternal Flame
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "La {object:148418}",
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {object:148418} Eternal Flame · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Accept the last quest, then wait by the {npc:268762} while he performs the ritual; when the fire spirits light the {object:148418}, hold the torch to it. From then you have six minutes: carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638}, with no detours or fights. Timer out? Abandon the quest and take it again from {npc:268592}."] = "Retournez voir {npc:268592}. Acceptez la dernière quête, puis attendez près du {npc:268762} pendant qu'il accomplit le rituel ; quand les esprits du feu allument la {object:148418}, tendez-y la torche. Vous avez alors six minutes : portez la flamme tout droit jusqu'au {npc:268679}, à côté de {npc:252382} à {area:16638}, sans détour ni combat. Temps écoulé ? Abandonnez la quête et reprenez-la auprès de {npc:268592}.",
	-- {npc:268679} Brazier of Eternal Flame · {area:16638} Valanaar
	["the ritual, then the {npc:268679} in {area:16638}"] = "le rituel, puis le {npc:268679} à {area:16638}",

	-- Step 23: Sessaria Skystride
	-- {item:5176} Fire Totem
	["Keep the {item:5176} in your bags for good: every fire totem needs it."] = "Gardez le {item:5176} dans vos sacs pour de bon : chaque totem de feu en a besoin.",
	-- {npc:252382} Sessaria Skystride · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:252382} : {spell:3599}, votre {item:5176} et le {item:263412}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Razormane casters north-east of the {area:380} drop the {item:5026} three times in four: Water Seekers and Thornweavers (level 10-11), Geomancers (level 12-13, they throw Fireballs and run for help when hurt) and Mystics (level 13-14, they heal themselves at low health). Pull them one at a time."] = "Les lanceurs de sorts Tranchecrin au nord-est de la {area:380} lâchent le {item:5026} trois fois sur quatre : Chercheurs d'eau et Tisse-épines (niveau 10-11), Géomanciens (niveau 12-13, ils lancent des Boules de feu et fuient chercher de l'aide quand ils sont blessés) et Mystiques (niveau 13-14, ils se soignent quand leur vie est basse). Attirez-les un par un.",
	-- ["{npc:5907} is not in the {area:380}: take the road north from the {area:380} and fork east towards {zone:1411}; past {area:1704} he paces by a tall tower east of the road (from {zone:1411}: over the Southfury bridge, past {area:379}). If you reach {zone:1440} you went too far."] = "{npc:5907} n'est pas à la {area:380} : prenez la route au nord de la {area:380} et bifurquez à l'est vers {zone:1411} ; après la {area:1704}, il fait les cent pas près d'une haute tour à l'est de la route (depuis {zone:1411} : passez le pont de la Furie-du-Sud, puis le {area:379}). Si vous arrivez en {zone:1440}, vous êtes allé trop loin.",
}
