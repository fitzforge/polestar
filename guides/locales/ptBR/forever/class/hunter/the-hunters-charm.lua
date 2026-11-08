-- Portuguese (Brazil) (ptBR): the guide forever/class/hunter/the-hunters-charm (forever/class/hunter/the-hunters-charm.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara
	["Experience at 50 through {zone:1447} and the Sunken Temple; Classic's item choice may be gone on Forever."] = "",
	["Experience"] = "Experiência",

	-- Step 1: The Hunter's Charm (Alliance)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Alliance)"] = "{quest:8151} (Aliança)",
	-- {npc:5516} Ulfir Ironbeard · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {object:32390} Hall of Arms (no name in this language: may be words) · {zone:1457} Darnassus
	["At 50 any Alliance hunter trainer offers it: {npc:5516} in {zone:1453}'s {object:28027}, {npc:5116} in {zone:1455}'s {object:32390} or Dorion in {zone:1457}' Cenarion Enclave."] = "No nível 50, qualquer instrutor de caçador da Aliança a oferece: {npc:5516} no {object:28027} de {zone:1453}, {npc:5116} no {object:32390} de {zone:1455} ou Dorion no Enclave Cenariano de {zone:1457}.",

	-- Step 2: The Hunter's Charm (Horde)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Horde)"] = "{quest:8151} (Horda)",
	-- {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:3039} Holt Thunderhorn · {object:50494} Hunter Rise (no name in this language: may be words) · {zone:1456} Thunder Bluff
	["At 50 any Horde hunter trainer offers it: {npc:3352} in {zone:1454}'s {object:172958} or {npc:3039} on {object:50494} in {zone:1456}."] = "",

	-- Step 3: Ogtinc
	-- {npc:8405} Ogtinc · {zone:1447} Azshara
	["{npc:8405} lives on a raised spot on the cliffs at the north-east rim of the Ruins of Eldarath, west-central {zone:1447}. Keep to the high ridges around the ruins: the pit below does not lead up to him. Alliance: fly to Talrendis Point; Horde: fly to Valormok, a short ride west of him."] = "",

	-- Step 4: Courser Antlers
	-- {zone:1447} Azshara
	-- plural, as words: Perfect Courser Antlers = {item:20017} Perfect Courser Antler · Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["You need two Perfect Courser Antlers. Mosshoof Coursers (level 52-53, deer) graze all over {zone:1447} and drop one about one kill in twelve, so expect two dozen kills. Good herds: north of the Thalassian Base Camp in the north, and the hills north-east and south-east of Valormok; the Lake Mennar area also has elite giants and dragonkin. They Enrage at 30% health. Coursers share spawn points with the Thunderhead hippogryphs: if none are around, kill the hippogryphs and coursers may spawn instead. Respawn is about five and a half minutes."] = "",
	-- {item:20017} Perfect Courser Antler
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["{item:20017}, from Mosshoof Coursers"] = "",

	-- Step 6: Wavethrashing
	-- {item:20087} Wavethrasher Scales · {zone:1447} Azshara
	-- plural, as words: Young Wavethrashers = {npc:6347} Young Wavethrasher · Great Wavethrashers = {npc:6349} Great Wavethrasher
	["You need six {item:20087}. Wavethrashers (three-headed sea beasts) live along {zone:1447}'s coasts, mostly underwater: the Young Wavethrashers (level 51-52) of the north-east shore drop a scale about one kill in three, the Wavethrashers (52-53) of the east coast by the Tower of Eldara about as often (a few walk the beach there), the Great Wavethrashers (53-54) of the south-east shore about one in seven. Track Beasts does not show them; fight them where you can breathe, and bring water breathing if you can. Elite sharks swim the deeper water."] = "",

	-- Step 8: Morphaz in the Sunken Temple
	["Morphaz in the Sunken Temple"] = "",
	-- {zone:1435} Swamp of Sorrows · {npc:5710} Jammal'an the Prophet
	["Morphaz is an elite green drake (level 52) inside the Sunken Temple, a five-player dungeon: needs a group of five. The temple stands in the Pool of Tears in eastern {zone:1435}: climb its outer steps, dive into the flooded hall and follow the stairs down to the entrance. Horde: fly to Stonard; Alliance: fly to Nethergarde Keep or Darkshire and ride on. He is not there when you arrive: first kill the six troll guardians on the platforms around the upper ring, which opens the way down to {npc:5710} in the Pit of Sacrifice. Jammal'an's death brings out two drakes, Weaver and Dreamscythe (pull them one at a time); when both are dead, Morphaz and Hazzas appear together and cannot be split. Clear the dragonkin around the pit first, because they call for help. Morphaz uses Acid Breath and Wing Flap. The tooth always drops. Warriors in the group may want the same run for the voodoo feathers of the balcony trolls."] = "",
	-- {item:20019} Tooth of Morphaz
	["{item:20019}, inside the Sunken Temple"] = "",

	-- Step 9: The Green Drake
	-- {item:19991} Devilsaur Eye · {item:19992} Devilsaur Tooth · {item:20083} Hunting Spear
	["In Classic Ogtinc let you choose the {item:19991}, the {item:19992} or the {item:20083} here. Forever's change notes say the choice is gone, though its quest page still lists three unnamed rewards: look at the reward window before you hand in."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 any Horde hunter trainer offers it: {npc:3352} in {zone:1454}'s {object:172958} or {npc:3039} on {area:1641} in {zone:1456}."] = "No nível 50, qualquer instrutor de caçador da Horda a oferece: {npc:3352} no {object:172958} de {zone:1454} ou {npc:3039} no {area:1641} em {zone:1456}.",
	-- ["Experience at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "Experiência no nível 50 por {zone:1447} e o {area:1417}; o Forever removeu a escolha de item do Classic.",
	-- ["Morphaz in the {area:1417}"] = "Morphaz no {area:1417}",
	-- ["Morphaz is an elite dragon boss inside the {area:1417}, a five-player dungeon: bring a group. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "Morphaz é um chefe dragão de elite dentro do {area:1417}, uma masmorra de cinco jogadores: leve um grupo. O templo fica no meio do {area:74}; mergulhe nele para chegar à entrada. Horda: voe até {area:75}; Aliança: voe até {area:42} ou {area:1438} e siga cavalgando.",
	-- ["Mosshoof Coursers graze all over {zone:1447}; one in a dozen or so drops a pair of Perfect Courser Antlers."] = "Ginetes Cascomusgo pastam por todo {zone:1447}; mais ou menos um em cada doze deixa cair um par de Galhadas Perfeitas de Ginete.",
	-- ["Wavethrashers crawl along {zone:1447}'s coasts: Young Wavethrashers on the north-east shore and Wavethrashers on the east coast drop the scales about twice as often as the Great Wavethrashers of the south shore."] = "Fura-ondas rastejam pelas costas de {zone:1447}: Jovens Fura-ondas na margem nordeste e Fura-ondas na costa leste deixam cair as escamas cerca de duas vezes mais que os Grandes Fura-ondas da margem sul.",
	-- ["{item:20019}, inside the {area:1417}"] = "{item:20019}, dentro do {area:1417}",
	-- ["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405} vive no alto dos penhascos a nordeste das {area:1221}. Aliança: voe até o {area:3137}; Horda: voe até {area:1237}.",
}
