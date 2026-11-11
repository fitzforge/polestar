-- Chinese (simplified) (zhCN): the guide forever/class/shaman/call-of-fire-horde (forever/class/shaman/call-of-fire-horde.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1522} Call of Fire
	["{quest:1522} (Horde)"] = "{quest:1522}（部落）",
	-- {item:5176} Fire Totem · {spell:3599} Searing Totem · {item:263412} Totem of Charged Flames
	["Your {item:5176} for every fire totem, {spell:3599} with it, and Forever's {item:263412}."] = "获得用于所有火焰图腾的{item:5176}、借此学会的{spell:3599}，以及无限的{item:263412}。",

	-- Step 1: Swart
	-- {npc:3173} Swart · {area:362} Razor Hill · {npc:5907} Kranal Fiss · {zone:1413} Barrens · {npc:5892} Searn Firewarder · {zone:1454} Orgrimmar
	["At 10 {npc:3173}, the shaman trainer on the east side of {area:362}, sends you to {npc:5907} in the {zone:1413}. Already carry {npc:5892}'s letter from {zone:1454}? It goes to {npc:5907} too: skip {npc:3173}."] = "达到 10 级后，{area:362} 东侧的萨满祭司训练师 {npc:3173} 会让你去找 {zone:1413} 的 {npc:5907}。已经带着 {zone:1454} 的 {npc:5892} 给的信？那封信也交给 {npc:5907}：可跳过 {npc:3173}。",

	-- Step 2: Narm Skychaser
	-- {npc:3066} Narm Skychaser · {area:222} Bloodhoof Village · {npc:5907} Kranal Fiss · {zone:1413} Barrens · {npc:5906} Xanis Flameweaver · {zone:1456} Thunder Bluff
	["At 10 {npc:3066}, the shaman trainer in {area:222}, sends you to {npc:5907} in the {zone:1413}. Already carry {npc:5906}'s letter from {zone:1456}? It goes to {npc:5907} too: skip Narm."] = "10 级时，{area:222} 的萨满祭司训练师 {npc:3066} 会让你去 {zone:1413} 找 {npc:5907}。已经带着 {zone:1456} 的 {npc:5906} 给你的信？那也是去找 {npc:5907}：跳过纳姆即可。",

	-- Step 3: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {zone:1411} Durotar · {area:1704} Grol'dom Farm · {area:379} Far Watch Post · {zone:1440} Ashenvale
	["{npc:5907} is not in the Crossroads: take the road north from the Crossroads and fork east towards {zone:1411}; past {area:1704} he paces by a tall tower east of the road (from {zone:1411}: over the Southfury bridge, past {area:379}). If you reach {zone:1440} you went too far."] = "{npc:5907}不在十字路口：从十字路口沿路向北，在岔路转向东边的{zone:1411}，经过{area:1704}后，他就在路东一座高塔旁来回走动（从{zone:1411}出发：过怒水河大桥，再经过{area:379}）。如果走到{zone:1440}，就是走过头了。",

	-- Step 4
	-- {npc:5907} Kranal Fiss · {npc:3173} Swart
	["{npc:5907}: {npc:3173}'s letter"] = "{npc:5907}：{npc:3173} 的信。",

	-- Step 5
	-- {npc:5907} Kranal Fiss · {npc:5892} Searn Firewarder
	["{npc:5907}: {npc:5892}'s letter"] = "{npc:5907}：{npc:5892} 的信。",

	-- Step 6
	-- {npc:5907} Kranal Fiss · {npc:3066} Narm Skychaser
	["{npc:5907}: {npc:3066}'s letter"] = "{npc:5907}：{npc:3066} 的信。",

	-- Step 7
	-- {npc:5907} Kranal Fiss · {npc:5906} Xanis Flameweaver
	["{npc:5907}: {npc:5906}'s letter"] = "{npc:5907}：{npc:5906} 的信。",

	-- Step 8: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {item:6653} Torch of the Dormant Flame
	["{npc:5907} hands you the {item:6653}: keep it until the end of the chain."] = "{npc:5907} 会给你 {item:6653}：一直保留到任务链结束。",

	-- Step 9: Telf Joolam
	-- {zone:1411} Durotar · {npc:5900} Telf Joolam
	["Back east over the bridge, then south along the {zone:1411} bank of the river to where the mountains meet the water. The trail up starts at the foot of the mountain beside a small dark stone carved with symbols, near the quilboar camp; it is narrow, and a slip costs fall damage. {npc:5900} keeps the shrine at the top."] = "向东过桥返回，再沿河流的 {zone:1411} 一侧河岸南下，直到山体与水面相接的地方。上山小径的起点在山脚，旁边有一块刻着符号的深色小石头，靠近野猪人营地；小路很窄，失足会受到坠落伤害。{npc:5900} 看守着山顶的神龛。",

	-- Step 10: Fire Tar
	-- {item:5026} Fire Tar
	-- plural, as words: Fireballs = {spell:133} Fireball
	["The Razormane casters north-east of the Crossroads drop the {item:5026} three times in four: Water Seekers and Thornweavers (level 10-11), Geomancers (level 12-13, they throw Fireballs and run for help when hurt) and Mystics (level 13-14, they heal themselves at low health). Pull them one at a time."] = "十字路口东北边的钢鬃施法者约每四只掉三个{item:5026}：寻水者和织棘者（10-11级）、地卜师（12-13级，会施放火球术，受伤后会逃跑求援）、秘法师（13-14级，低血量时会自疗）。逐只引来击杀。",

	-- Step 11: Reagent Pouch
	-- {spell:348} Immolate · {area:371} Dustwind Cave · {area:362} Razor Hill · {area:817} Skull Rock · {zone:1454} Orgrimmar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["The Burning Blade Cultists (level 10-11, they call imps and cast {spell:348}) live deep in {area:371} north of {area:362}: climb the ramp just north-east of town and stay on the high ground above the ravines. The orcs at the cave mouth are not cultists; the cultists are further in, off to the left. Three kills in four drop a pouch. {area:817} by {zone:1454} is the wrong cave."] = "火刃祭司（10-11 级，会召唤小鬼并施放 {spell:348}）在 {area:362} 北边的 {area:371} 深处：从镇子东北不远处的斜坡上去，一直沿沟壑上方的高地走。洞口的兽人不是祭司；祭司在更深处偏左的位置。大约每四次击杀有三次掉落袋子。{zone:1454} 旁的 {area:817} 不是要找的洞穴。",

	-- Step 12: Telf Joolam
	-- {npc:5900} Telf Joolam · {quest:1464} Fire Sapta
	["Back up the trail to {npc:5900}. He makes the {quest:1464} from the tar and the pouch and hands it to you with the torch: keep both."] = "沿小径回到山上找 {npc:5900}。他会用焦油和小袋制作 {quest:1464}，并连同火炬一起交给你：两件都要保留。",

	-- Step 13: Lost the Fire Sapta?
	-- {quest:1464} Fire Sapta
	["Lost the {quest:1464}?"] = "弄丢了{quest:1464}？",
	-- {quest:1464} Fire Sapta · {npc:5900} Telf Joolam
	["Only if the {quest:1464} is gone from your bags: {npc:5900} gives you another."] = "仅在 {quest:1464} 已经不在背包里时需要：{npc:5900} 会再给你一份。",
	-- {npc:5900} Telf Joolam · {quest:1464} Fire Sapta
	["{npc:5900}: a new {quest:1464}"] = "{npc:5900}：新的{quest:1464}",

	-- Step 14: The Minor Manifestation of Fire
	-- {npc:5893} Minor Manifestation of Fire
	["The {npc:5893}"] = "{npc:5893}",
	-- {item:6636} Fire Sapta · {object:63674} Shaman Shrine (no name in this language: may be words) · {spell:8017} Rockbiter Weapon · {spell:8042} Earth Shock · {item:6655} Glowing Ember
	["Drink the {item:6636} beside the {object:63674}, the big grey stone just below the summit, then climb to the plateau. Of the fire elementals there only the one in the middle can be attacked: it is level 12, immune to fire and grows stronger the longer the fight lasts, so open at once with {spell:8017} and {spell:8042} and leave the others alone. Its {item:6655} drops every time."] = "在{object:63674}旁喝下{item:6636}，它是接近山顶处的一块灰色巨石，然后登上平台。那里的火元素只有中间那只能攻击：它为12级，免疫火焰，战斗拖得越久就越强，所以立即用{spell:8017}和{spell:8042}开打，别碰其他火元素。它必定掉落{item:6655}。",
	-- {item:6636} Fire Sapta · {object:63674} Shaman Shrine (no name in this language: may be words)
	["{item:6636}, beside the {object:63674}"] = "在 {object:63674} 旁使用 {item:6636}",

	-- Step 15: The Brazier of the Dormant Flame
	-- {object:61934} Brazier of the Dormant Flame
	["The {object:61934}"] = "{object:61934}",
	-- {object:61934} Brazier of the Dormant Flame · {item:277329} Torch of Eternal Flame
	["Click the {object:61934} on the plateau with the torch in your bags to place the ember, then click it a second time: the next quest does not open by itself. It gives you the lit {item:277329}."] = "确保火炬在背包中，点击高地上的 {object:61934} 放置火种，然后再点击一次：下一个任务不会自动出现。它会给你点燃的 {item:277329}。",

	-- Step 16: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {item:5176} Fire Totem
	["Down the trail, back over the bridge to {npc:5907} by his tower. Keep the {item:5176} in your bags for good: every fire totem needs it."] = "沿小径下山，过桥回到塔楼旁的 {npc:5907} 处。将 {item:5176} 永久保留在背包中：所有火焰图腾都需要它。",
	-- {npc:5907} Kranal Fiss · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:5907}：{spell:3599}、你的 {item:5176} 和 {item:263412}",

	-- Step 17: Sessaria Skystride
	-- {npc:252382} Sessaria Skystride · {npc:251968} Ayessa Dawnsinger · {area:16638} Valanaar · {item:6653} Torch of the Dormant Flame · {npc:254082} Aarnor Galestrike · {quest:97243} Call of Fire · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {spell:8050} Flame Shock · {npc:268605} Kuramaa
	["At 10 {npc:252382}, the shaman trainer beside {npc:251968} in {area:16638}, hands you the {item:6653} ({npc:254082} offers the same quest). Already left the isle? A {quest:97243} sends you back to them: take the skycutter from the cliffs south of {area:17045}, north of {zone:1456}. Learn {spell:8050} from her now: {npc:268605}, later in the chain, only takes fire damage."] = "达到 10 级后，{area:16638} 中、{npc:251968} 旁的萨满祭司训练师 {npc:252382} 会给你 {item:6653}（{npc:254082} 也提供同一任务）。已经离岛了？{quest:97243} 会让你回去找他们：到 {zone:1456} 北方、{area:17045} 南侧的悬崖乘坐空艇。现在就向她学习 {spell:8050}：任务链后面的 {npc:268605} 只受火焰伤害。",

	-- Step 18: Olariaan Swiftburn
	-- {area:16638} Valanaar · {area:16663} Windfield Orchard · {npc:268592} Olariaan Swiftburn
	["The Shrine of Flames hides on the island's outer rim south-west of {area:16638}, just south-east of {area:16663}: {npc:268592} keeps it."] = "火焰神殿藏在 {area:16638} 西南的岛屿外缘，位于 {area:16663} 东南不远处：由 {npc:268592} 看守。",

	-- Step 19: Skypriest Faladiel
	-- {npc:268602} Skypriest Faladiel · {area:16638} Valanaar · {area:16629} Shrine of Akir · {area:17675} East Pylon Watchtower
	["{npc:268602} (level 10, a turncoat Windshaper with a single spawn) holds the farm north-east past {area:16638}, just south of the {area:16629}, on the hill west of the falls north of the {area:17675}. Kill him and take his heart."] = "{npc:268602}（10级，叛变的 塑风者，只有一个刷新点）占据了{area:16638}东北方向更远处的农场，就在{area:16629}南面、{area:17675}北面瀑布以西的山丘上。击杀他并取走心脏。",

	-- Step 20: Olariaan Swiftburn
	-- {npc:268592} Olariaan Swiftburn
	["Back to {npc:268592} at the Shrine of Flames."] = "返回供奉火焰的神龛旁的{npc:268592}处。",

	-- Step 21: Kuramaa
	-- {object:660848} Kuramaa's Stump (no name in this language: may be words) · {area:16638} Valanaar · {npc:268605} Kuramaa · {spell:8050} Flame Shock
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["{object:660848} is the twisted stump on the hilltop by the Shen'dar Highlands Anchor Pylon, west of {area:16638}, in the hills south of the Windsong Crawlers' lakes. Knock on it to call {npc:268605} (level 10). The spirit shrugs off most magic: only fire hurts it, so keep {spell:8050} on it. Take its wooden mask."] = "{object:660848}是申达尔高地锚点水晶塔旁山顶上的扭曲树桩，在{area:16638}西面、风歌爬行者所在湖泊以南的山丘中。敲击它即可召出{npc:268605}（10级）。该灵体几乎不受魔法影响：只有火焰能伤到它，所以持续保持{spell:8050}。取走它的木制面具。",
	-- {object:660848} Kuramaa's Stump (no name in this language: may be words)
	["{object:660848}: knock on the bark"] = "{object:660848}：敲击树皮",

	-- Step 22: The Eternal Flame
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {object:148418} Eternal Flame · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Accept the last quest, then wait by the {npc:268762} while he performs the ritual; when the fire spirits light the {object:148418}, hold the torch to it. From then you have six minutes: carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638}, with no detours or fights. Timer out? Abandon the quest and take it again from {npc:268592}."] = "回到 {npc:268592} 处。接受最后一个任务，然后在 {npc:268762} 身旁等他进行仪式；火焰之灵点燃 {object:148418} 时，将火炬靠上去。从那一刻起你有六分钟：径直将火焰送到 {area:16638} 的 {npc:252382} 身旁的 {npc:268679} 处，不要绕路，也不要战斗。如果超时，就放弃任务，再从 {npc:268592} 处重接。",
	-- {npc:268679} Brazier of Eternal Flame · {area:16638} Valanaar
	["the ritual, then the {npc:268679} in {area:16638}"] = "先完成仪式，再去找{area:16638}的{npc:268679}",

	-- Step 23: Sessaria Skystride
	-- {item:5176} Fire Totem
	["Keep the {item:5176} in your bags for good: every fire totem needs it."] = "始终把 {item:5176} 留在背包中：每次使用火焰图腾都需要它。",
	-- {npc:252382} Sessaria Skystride · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:252382}：{spell:3599}、你的 {item:5176} 和 {item:263412}",
}
