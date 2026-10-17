-- Russian (ruRU): the guide forever/collectibles/mounts/alliance/paladin-charger (forever/collectibles/mounts/alliance/paladin-charger.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Charger"] = "Скакун паладина",
	["Your epic mount at 60, summoned at will: the faster step up from the Warhorse."] = "Ваше эпическое средство передвижения на 60-м уровне, призываемое в любой момент: более быстрая замена боевого коня.",

	-- Step 1: Lord Grayson Shadowbreaker (Ironforge)
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward · {quest:7638} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 60 {npc:5149} in the {object:32362} sends you to {quest:7638} in {zone:1453}'s Cathedral of Light."] = "На 60-м уровне {npc:5149} ({object:32362}) отправляет вас к NPC {quest:7638} в Собор Света ({zone:1453}).",

	-- Step 2: Lord Grayson Shadowbreaker
	-- {spell:23214} Summon Charger · {area:2279} Stratholme · {area:2577} Dire Maul · {area:2057} Scholomance
	["The {spell:23214} chain is long: it takes you through {area:2279}, {area:2577} and {area:2057}, and costs about 350 gold in donations on top of the materials. Lord Grayson stands in the Cathedral of Light."] = "Цепочка {spell:23214} длинная: она проведет вас через {area:2279}, {area:2577} и {area:2057} и обойдется примерно в 350 золотых пожертвований сверх материалов. Лорд Грейсон стоит в Соборе Света.",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}, Собор Света",

	-- Step 3: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {object:32362} Mystic Ward
	["{npc:11406} is in {zone:1455}'s {object:32362}. Bring 150 gold: the censer is yours for a donation."] = "{npc:11406} находится здесь: {object:32362} ({zone:1455}). Возьмите 150 золотых: кадило ваше за пожертвование.",
	-- {npc:11406} High Priest Rohan
	["{npc:11406}: 150 gold"] = "{npc:11406}: 150 золотых",

	-- Step 4: Back to Lord Grayson
	["Back to Lord Grayson"] = "Обратно к лорду Грейсону",

	-- Step 5: Exorcising Terrordale
	-- {area:2627} Terrordale · {zone:1423} Eastern Plaguelands · {zone:1422} Western Plaguelands · {item:18752} Exorcism Censer
	["{area:2627} lies in the far north-west of the {zone:1423}, by the {zone:1422} border. Use the {item:18752} there to drive out the spirits, then defeat them."] = "{area:2627} находится на крайнем северо-западе зоны {zone:1423}, у границы с зоной {zone:1422}. Используйте там {item:18752}, чтобы изгнать духов, затем победите их.",
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Terrordale Spirits"] = "Духи долины Ужаса",

	-- Step 7: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {object:28027} Dwarven District
	["{npc:1416} works in {zone:1453}'s {object:28027}."] = "{npc:1416} работает здесь: {object:28027} ({zone:1453}).",

	-- Step 8: Grimand Elmore's materials
	-- {npc:1416} Grimand Elmore
	["{npc:1416}'s materials"] = "Материалы {npc:1416}",
	-- {item:14047} Runecloth · {item:8836} Arthas' Tears · {zone:1448} Felwood · {skill:171} Alchemy · {zone:1453} Stormwind · {object:2096} Trade District
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["{item:14047} drops from humanoids around level 50 and up; {item:8836} is an herb of the Plaguelands and {zone:1448}; Arcanite Bars are an {skill:171} transmute. The Auction House in {zone:1453}'s {object:2096} sells all three, and so do crafters."] = "{item:14047} падает с гуманоидов примерно с 50-го уровня; {item:8836} — трава Чумных земель и зоны {zone:1448}; арканитовые слитки получают трансмутацией ({skill:171}). Все три продаются на аукционе ({zone:1453}, {object:2096}), а также у ремесленников.",
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Arcanite Bars: the Auction House"] = "Арканитовые слитки: аукцион",

	-- Step 9: Stratholme Holy Water
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {item:13180} Stratholme Holy Water
	-- plural, as words: Supply Crates = {item:4629} Supply Crate
	["{area:2279} is a group of five, level 58-60, at the north end of the {zone:1423}. The Supply Crates scattered through the city hold the {item:13180}."] = "{area:2279} — подземелье для группы из пяти игроков 58-60-го уровня на севере зоны {zone:1423}. В ящиках с припасами, разбросанных по городу, лежит {item:13180}.",
	-- plural, as words: Supply Crates = {item:4629} Supply Crate
	["Supply Crates, inside"] = "Ящики с припасами, внутри",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore
	["Bring 150 gold for {npc:1416} along with the materials."] = "Вместе с материалами возьмите 150 золотых для {npc:1416}.",
	-- {npc:1416} Grimand Elmore
	["{npc:1416}: 150 gold"] = "{npc:1416}: 150 золотых",

	-- Step 11: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker · {item:18753} Arcanite Barding
	["{npc:928}: the {item:18753}"] = "{npc:928}: {item:18753}",

	-- Step 12: Enriched Manna Biscuits
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits"] = "Витаминизированное печенье из манны",
	-- {object:2160} The Argent Dawn · {object:92525} Argent Dawn · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel · {npc:10856} Argent Quartermaster Hasana · {area:813} Bulwark
	["{object:2160} quartermasters sell the biscuits in fives once the {object:92525} is Friendly with you: {npc:10857} at {area:3197}, {npc:11536} at {area:2268}, {npc:10856} at the {area:813}."] = "Интенданты ({object:2160}) продают печенье по пять штук, когда ваше отношение с фракцией {object:92525} — дружелюбие: {npc:10857} ({area:3197}), {npc:11536} ({area:2268}), {npc:10856} ({area:813}).",
	-- {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits: {npc:10857}, {area:3197}"] = "Витаминизированное печенье из манны: {npc:10857}, {area:3197}",

	-- Step 13: Merideth Carlson
	-- {npc:2357} Merideth Carlson · {area:271} Southshore
	["{npc:2357} breeds horses in {area:271}. She also wants 50 gold."] = "{npc:2357} разводит лошадей здесь: {area:271}. Ей также нужно 50 золотых.",

	-- Step 14: Dire Maul: Tendris Warpwood
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {npc:11489} Tendris Warpwood · {quest:7643} Ancient Equine Spirit · {item:18775} Manna-Enriched Horse Feed · {item:18753} Arcanite Barding
	["{area:2577} lies in central {zone:1444}; {npc:11489} guards the start of the West wing. Defeat him to free the {quest:7643}, feed it the {item:18775} and hand it the {item:18753} to bless. Bring a group."] = "{area:2577} находится в центре зоны {zone:1444}; {npc:11489} охраняет начало западного крыла. Победите его, чтобы освободить NPC {quest:7643}, накормите его ({item:18775}) и отдайте ему {item:18753} для благословения. Возьмите группу.",
	-- {npc:11489} Tendris Warpwood
	["{npc:11489}, inside the West wing"] = "{npc:11489}, в западном крыле",

	-- Step 16: Two diamonds
	["Two diamonds"] = "Два алмаза",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {zone:1422} Western Plaguelands
	["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: the Auction House is the usual source."] = "{item:12800} добывается из ториевых жил, {item:18335} — с элитных противников зоны {zone:1422}, оба редко: обычно их покупают на аукционе.",

	-- Step 17: Lord Grayson Shadowbreaker
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "он вручает вам {item:18746}",

	-- Step 18: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:18746} Divination Scryer · {object:179746} The Great Ossuary (no name in this language: may be words) · {npc:14516} Death Knight Darkreaver · {item:18799} Charger's Redeemed Soul · {item:18792} Blessed Arcanite Barding
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057} находится под местом {area:2298} — городком на острове на юго-востоке зоны {zone:1422}. Используйте {item:18746} в центре подвала Главного склепа, победите призванных духов, а затем: {npc:14516}; отдайте его падшему скакуну {item:18799} и {item:18792}. Все они элитные: возьмите группу. Если попытка не удалась, лорд Грейсон даст вам новый прорицатель через задание «Снова в Главный склеп».",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057} находится под местом {area:2298} — городком на острове на юго-востоке зоны {zone:1422}. Используйте {item:18746} в центре подвала ({object:179746}), победите призванных духов, а затем: {npc:14516}; отдайте его падшему скакуну {item:18799} и {item:18792}. Все они элитные: возьмите группу. Если попытка не удалась, лорд Грейсон даст вам новый прорицатель через задание «Снова в {object:179746}».",
}
