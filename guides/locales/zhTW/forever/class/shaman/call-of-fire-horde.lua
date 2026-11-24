-- Chinese (traditional) (zhTW): the guide forever/class/shaman/call-of-fire-horde (forever/class/shaman/call-of-fire-horde.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1522} Call of Fire
	["{quest:1522} (Horde)"] = "{quest:1522}（部落）",
	-- {item:5176} Fire Totem · {spell:3599} Searing Totem · {item:263412} Totem of Charged Flames
	["Your {item:5176} for every fire totem, {spell:3599} with it, and Forever's {item:263412}."] = "獲得用於所有火焰圖騰的{item:5176}、藉此學會的{spell:3599}，以及Forever的{item:263412}。",

	-- Step 1: Swart
	-- {npc:3173} Swart · {area:362} Razor Hill · {npc:5907} Kranal Fiss · {zone:1413} Barrens · {npc:5892} Searn Firewarder · {zone:1454} Orgrimmar
	["At 10 {npc:3173}, the shaman trainer on the east side of {area:362}, sends you to {npc:5907} in the {zone:1413}. Already carry {npc:5892}'s letter from {zone:1454}? It goes to {npc:5907} too: skip {npc:3173}."] = "10級時，{area:362}東側的薩滿訓練師{npc:3173}讓你去{zone:1413}找{npc:5907}。已經帶著{zone:1454}{npc:5892}的信了？那封信也是給{npc:5907}的：跳過{npc:3173}。",

	-- Step 2: Narm Skychaser
	-- {npc:3066} Narm Skychaser · {area:222} Bloodhoof Village · {npc:5907} Kranal Fiss · {zone:1413} Barrens · {npc:5906} Xanis Flameweaver · {zone:1456} Thunder Bluff
	["At 10 {npc:3066}, the shaman trainer in {area:222}, sends you to {npc:5907} in the {zone:1413}. Already carry {npc:5906}'s letter from {zone:1456}? It goes to {npc:5907} too: skip Narm."] = "10級時，{area:222}的薩滿訓練師{npc:3066}讓你去{zone:1413}找{npc:5907}。已經帶著{zone:1456}{npc:5906}的信了？那封信也是給{npc:5907}的：不必再跑納姆這一趟。",

	-- Step 3: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {zone:1411} Durotar · {area:1704} Grol'dom Farm · {area:379} Far Watch Post · {zone:1440} Ashenvale
	["{npc:5907} is not in the Crossroads: take the road north from the Crossroads and fork east towards {zone:1411}; past {area:1704} he paces by a tall tower east of the road (from {zone:1411}: over the Southfury bridge, past {area:379}). If you reach {zone:1440} you went too far."] = "{npc:5907}不在十字路口：從十字路口沿路向北，在岔口向東朝{zone:1411}走；過了{area:1704}，他就在大路東側一座高塔旁踱步（從{zone:1411}出發：過南怒河大橋，經過{area:379}）。要是走到{zone:1440}，說明你走過頭了。",

	-- Step 4
	-- {npc:5907} Kranal Fiss · {npc:3173} Swart
	["{npc:5907}: {npc:3173}'s letter"] = "{npc:5907}：{npc:3173}的信",

	-- Step 5
	-- {npc:5907} Kranal Fiss · {npc:5892} Searn Firewarder
	["{npc:5907}: {npc:5892}'s letter"] = "{npc:5907}：{npc:5892}的信",

	-- Step 6
	-- {npc:5907} Kranal Fiss · {npc:3066} Narm Skychaser
	["{npc:5907}: {npc:3066}'s letter"] = "{npc:5907}：{npc:3066}的信",

	-- Step 7
	-- {npc:5907} Kranal Fiss · {npc:5906} Xanis Flameweaver
	["{npc:5907}: {npc:5906}'s letter"] = "{npc:5907}：{npc:5906}的信",

	-- Step 8: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {item:6653} Torch of the Dormant Flame
	["{npc:5907} hands you the {item:6653}: keep it until the end of the chain."] = "{npc:5907}交給你{item:6653}：一直留到任務鏈結束。",

	-- Step 9: Telf Joolam
	-- {zone:1411} Durotar · {npc:5900} Telf Joolam
	["Back east over the bridge, then south along the {zone:1411} bank of the river to where the mountains meet the water. The trail up starts at the foot of the mountain beside a small dark stone carved with symbols, near the quilboar camp; it is narrow, and a slip costs fall damage. {npc:5900} keeps the shrine at the top."] = "向東過橋折返，再沿河的{zone:1411}一岸向南，走到群山與水面相接的地方。上山的小徑從山腳開始，旁邊有一塊刻著符號的黑色小石，離野豬人營地很近；路很窄，失足會摔傷。{npc:5900}守在山頂的神龕。",

	-- Step 10: Fire Tar
	-- {item:5026} Fire Tar
	-- plural, as words: Fireballs = {spell:133} Fireball
	["The Razormane casters north-east of the Crossroads drop the {item:5026} three times in four: Water Seekers and Thornweavers (level 10-11), Geomancers (level 12-13, they throw Fireballs and run for help when hurt) and Mystics (level 13-14, they heal themselves at low health). Pull them one at a time."] = "十字路口東北方的刺背部落施法者約四次擊殺掉三個{item:5026}：尋水者和織棘者（10-11級）、地卜師（12-13級，會扔火球，受傷就逃跑喊人）和秘法師（13-14級，血量低時會治療自己）。一次拉一隻打。",

	-- Step 11: Reagent Pouch
	-- {spell:348} Immolate · {area:371} Dustwind Cave · {area:362} Razor Hill · {area:817} Skull Rock · {zone:1454} Orgrimmar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["The Burning Blade Cultists (level 10-11, they call imps and cast {spell:348}) live deep in {area:371} north of {area:362}: climb the ramp just north-east of town and stay on the high ground above the ravines. The orcs at the cave mouth are not cultists; the cultists are further in, off to the left. Three kills in four drop a pouch. {area:817} by {zone:1454} is the wrong cave."] = "火刃教徒（10-11級，會召小鬼、施放{spell:348}）盤踞在{area:362}以北{area:371}的深處：從鎮子東北邊的坡道爬上去，一直走在溝壑上方的高地上。洞口的獸人不是教徒；教徒在更深處，進去後靠左走。大約四次擊殺掉三個袋子。{zone:1454}旁邊的{area:817}是錯的洞。",

	-- Step 12: Telf Joolam
	-- {npc:5900} Telf Joolam · {quest:1464} Fire Sapta
	["Back up the trail to {npc:5900}. He makes the {quest:1464} from the tar and the pouch and hands it to you with the torch: keep both."] = "沿小徑回到{npc:5900}那裡。他用焦油和袋子做出{quest:1464}，連同火把一起交給你：兩樣都收好。",

	-- Step 13: Lost the Fire Sapta?
	-- {quest:1464} Fire Sapta
	["Lost the {quest:1464}?"] = "{quest:1464}弄丟了？",
	-- {quest:1464} Fire Sapta · {npc:5900} Telf Joolam
	["Only if the {quest:1464} is gone from your bags: {npc:5900} gives you another."] = "只有當{quest:1464}不在你揹包裡時：{npc:5900}會再給你做一個。",
	-- {npc:5900} Telf Joolam · {quest:1464} Fire Sapta
	["{npc:5900}: a new {quest:1464}"] = "{npc:5900}：一個新的{quest:1464}",

	-- Step 14: The Minor Manifestation of Fire
	-- {npc:5893} Minor Manifestation of Fire
	["The {npc:5893}"] = "{npc:5893}",
	-- {item:6636} Fire Sapta · {object:63674} Shaman Shrine · {spell:8017} Rockbiter Weapon · {spell:8042} Earth Shock · {item:6655} Glowing Ember
	["Drink the {item:6636} beside the {object:63674}, the big grey stone just below the summit, then climb to the plateau. Of the fire elementals there only the one in the middle can be attacked: it is level 12, immune to fire and grows stronger the longer the fight lasts, so open at once with {spell:8017} and {spell:8042} and leave the others alone. Its {item:6655} drops every time."] = "在峰頂正下方那塊大灰石{object:63674}旁喝下{item:6636}，然後爬上高地。那裡的一群火元素裡只有中間那隻能打：12級，火焰免疫，戰鬥拖得越久它越強，所以一開打就用{spell:8017}和{spell:8042}，其他的別碰。它每次都掉{item:6655}。",
	-- {item:6636} Fire Sapta · {object:63674} Shaman Shrine
	["{item:6636}, beside the {object:63674}"] = "{item:6636}，在{object:63674}旁",

	-- Step 15: The Brazier of the Dormant Flame
	-- {object:61934} Brazier of the Dormant Flame
	["The {object:61934}"] = "{object:61934}",
	-- {object:61934} Brazier of the Dormant Flame · {item:277329} Torch of Eternal Flame
	["Click the {object:61934} on the plateau with the torch in your bags to place the ember, then click it a second time: the next quest does not open by itself. It gives you the lit {item:277329}."] = "揹包裡帶著火把，點選高地上的{object:61934}放下餘燼，然後再點一次：後續任務不會自己彈出來。它會把點燃的{item:277329}給你。",

	-- Step 16: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {item:5176} Fire Totem
	["Down the trail, back over the bridge to {npc:5907} by his tower. Keep the {item:5176} in your bags for good: every fire totem needs it."] = "走下小徑，過橋回到高塔旁的{npc:5907}那裡。把{item:5176}永遠留在揹包裡：每根火焰圖騰都離不開它。",
	-- {npc:5907} Kranal Fiss · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:5907}：{spell:3599}、你的{item:5176}和{item:263412}",

	-- Step 17: Sessaria Skystride
	-- {npc:252382} Sessaria Skystride · {npc:251968} Ayessa Dawnsinger · {area:16638} Valanaar · {item:6653} Torch of the Dormant Flame · {npc:254082} Aarnor Galestrike · {quest:97243} Call of Fire · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {spell:8050} Flame Shock · {npc:268605} Kuramaa
	["At 10 {npc:252382}, the shaman trainer beside {npc:251968} in {area:16638}, hands you the {item:6653} ({npc:254082} offers the same quest). Already left the isle? A {quest:97243} sends you back to them: take the skycutter from the cliffs south of {area:17045}, north of {zone:1456}. Learn {spell:8050} from her now: {npc:268605}, later in the chain, only takes fire damage."] = "10級時，{area:16638}裡{npc:251968}身旁的薩滿訓練師{npc:252382}交給你{item:6653}（{npc:254082}提供同一個任務）。已經離島了？{quest:97243}會把你送回去：在{zone:1456}以北、{area:17045}以南的懸崖乘天艇。現在就向她學習{spell:8050}：任務鏈後面的{npc:268605}只吃火焰傷害。",

	-- Step 18: Olariaan Swiftburn
	-- {area:16638} Valanaar · {area:16663} Windfield Orchard · {npc:268592} Olariaan Swiftburn
	["The Shrine of Flames hides on the island's outer rim south-west of {area:16638}, just south-east of {area:16663}: {npc:268592} keeps it."] = "火焰神龕藏在{area:16638}西南方、島嶼的外緣，就在{area:16663}東南方：由{npc:268592}看守。",

	-- Step 19: Skypriest Faladiel
	-- {npc:268602} Skypriest Faladiel · {area:16638} Valanaar · {area:16629} Shrine of Akir · {area:17675} East Pylon Watchtower
	["{npc:268602} (level 10, a turncoat Windshaper with a single spawn) holds the farm north-east past {area:16638}, just south of the {area:16629}, on the hill west of the falls north of the {area:17675}. Kill him and take his heart."] = "{npc:268602}（10級，變節的塑風者，只有一個重生點）佔著{area:16638}東北邊的那座農場，就在{area:16629}以南、{area:17675}以北瀑布西側的山丘上。殺掉他，取他的心臟。",

	-- Step 20: Olariaan Swiftburn
	-- {npc:268592} Olariaan Swiftburn
	["Back to {npc:268592} at the Shrine of Flames."] = "回火焰神龕找{npc:268592}。",

	-- Step 21: Kuramaa
	-- {object:660848} Kuramaa's Stump (no name in this language: may be words) · {area:16638} Valanaar · {npc:268605} Kuramaa · {spell:8050} Flame Shock
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["{object:660848} is the twisted stump on the hilltop by the Shen'dar Highlands Anchor Pylon, west of {area:16638}, in the hills south of the Windsong Crawlers' lakes. Knock on it to call {npc:268605} (level 10). The spirit shrugs off most magic: only fire hurts it, so keep {spell:8050} on it. Take its wooden mask."] = "{object:660848}是{area:16638}以西、辛達爾高地錨定塔旁邊山頂上的那截扭曲樹樁，在風歌爬行者湖泊南邊的丘陵裡。敲擊樹皮召喚{npc:268605}（10級）。這個精魂幾乎不吃魔法：只有火焰能傷到它，所以全程保持{spell:8050}。拿走它的木製面具。",
	-- {object:660848} Kuramaa's Stump (no name in this language: may be words)
	["{object:660848}: knock on the bark"] = "{object:660848}：敲擊樹皮",

	-- Step 22: The Eternal Flame
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {object:148418} Eternal Flame · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Accept the last quest, then wait by the {npc:268762} while he performs the ritual; when the fire spirits light the {object:148418}, hold the torch to it. From then you have six minutes: carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638}, with no detours or fights. Timer out? Abandon the quest and take it again from {npc:268592}."] = "回到{npc:268592}處。接最後一個任務，然後在{npc:268762}旁等他完成儀式；等火靈點亮{object:148418}，就把火把湊上去點著。從那一刻起你有六分鐘：把火焰徑直送到{area:16638}{npc:252382}身旁的{npc:268679}那裡，不許繞路、不許戰鬥。超時了？放棄任務，重新找{npc:268592}接。",
	-- {npc:268679} Brazier of Eternal Flame · {area:16638} Valanaar
	["the ritual, then the {npc:268679} in {area:16638}"] = "儀式，然後送去{area:16638}的{npc:268679}",

	-- Step 23: Sessaria Skystride
	-- {item:5176} Fire Totem
	["Keep the {item:5176} in your bags for good: every fire totem needs it."] = "把{item:5176}永遠留在揹包裡：每根火焰圖騰都離不開它。",
	-- {npc:252382} Sessaria Skystride · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:252382}：{spell:3599}、你的{item:5176}和{item:263412}",
}
