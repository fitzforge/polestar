-- Chinese (simplified) (zhCN): the guide forever/class/paladin/holy-mightstone (forever/class/paladin/holy-mightstone.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A one-use stone that makes you much stronger against undead for 10 minutes; the old item choice may be gone in Forever."] = "一次性石头，10分钟内大幅增强你对亡灵的战斗力；在无限服务器中，旧的物品选择可能已经取消。",

	-- Step 1: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge
	["At 50 {npc:928}, the paladin trainer in the Cathedral of Light, sends you to {area:3197} in the {zone:1422}. {npc:5149} in {zone:1455} gives the same quest."] = "50级时，圣光大教堂的圣骑士训练师{npc:928}会派你去{zone:1422}的{area:3197}。{zone:1455}的{npc:5149}也提供相同任务。",

	-- Step 2: Brandur Ironhammer
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {npc:928} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 50 {npc:5149}, the paladin trainer in the {object:32362}, sends you to {area:3197} in the {zone:1422}. {npc:928} in {zone:1453} gives the same quest."] = "50级时，{object:32362}的圣骑士训练师{npc:5149}会派你去{zone:1422}的{area:3197}。{zone:1453}的{npc:928}也提供相同任务。",

	-- Step 3: Chillwind Camp
	-- {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {npc:10838} Commander Ashlam Valorfist · {npc:10840} Argent Officer Pureheart
	["{area:3197} is the Alliance camp at the south end of the {zone:1422}, north of the Alterac foothills. {npc:10838} commands it; {npc:10840} stands in the same camp."] = "{area:3197} 是 {zone:1422} 最南端的联盟营地，位于奥特兰克山麓以北。{npc:10838} 在此指挥；{npc:10840} 也在同一个营地中。",

	-- Step 4: The Argent Dawn Commission
	-- {quest:5401} Argent Dawn Commission
	["The {quest:5401}"] = "{quest:5401}",
	-- {quest:5401} Argent Dawn Commission · {npc:10840} Argent Officer Pureheart · {area:2268} Light's Hope Chapel
	["The Scourge drop no Scourgestones unless you wear an {quest:5401}. {npc:10840} gives you one through her quest, {quest:5401}, which you hand in straight away (if you already have one from {area:2268}, wear that). Equip it in a trinket slot: it shows as a buff that never runs out. Keep it on until you have 20 stones."] = "除非佩戴{quest:5401}，否则天灾怪物不会掉落天灾石。{npc:10840}会通过她的“{quest:5401}”任务给你一个，该任务可立即交还（如果你已经从{area:2268}拿到一个，就戴那个）。将它装备到饰品栏：会显示为一个永不消失的增益效果。收集满20块石头前一直戴着。",
	-- {quest:5401} Argent Dawn Commission
	["the {quest:5401} trinket: equip it"] = "",

	-- Step 5: Minion's Scourgestones
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones"] = "{item:12840}",
	-- {zone:1422} Western Plaguelands · {item:12840} Minion's Scourgestone · {area:197} Sorrow Hill · {area:3197} Chillwind Camp · {area:196} Uther's Tomb · {spell:120} Cone of Cold · {spell:1449} Arcane Explosion
	-- plural, as words: Flesh Golems = {npc:1805} Flesh Golem · Skeletal Guardians = {npc:10390} Skeletal Guardian · Dark Summoners = {npc:8551} Dark Summoner
	["Kill the Scourge of the {zone:1422} with the Commission on: skeletons, ghouls and cultists (level 50-58) drop a {item:12840} about two kills in five. {area:197}, just east of {area:3197} around {area:196}, is the closest farm. Avoid the Flesh Golems that patrol the fields; Skeletal Guardians cast {spell:120} and {spell:1449} up close, Dark Summoners run for help at low health."] = "佩戴委任徽章，击杀{zone:1422}的天灾军团：骷髅、食尸鬼和教徒（50-58级）掉落{item:12840}的概率约为五只出两个。最近的刷怪地点是{area:197}，就在{area:3197}东边、{area:196}周围。避开在田野中巡逻的血肉傀儡；骷髅守护者会在近距离施放{spell:120}和{spell:1449}，黑暗召唤师则会在生命值低时逃跑求援。",
	-- {item:12840} Minion's Scourgestone
	["{item:12840} x20"] = "{item:12840} × 20",

	-- Step 6: High Priest Thel'danis
	-- {npc:1854} High Priest Thel'danis · {area:196} Uther's Tomb · {area:197} Sorrow Hill · {item:20612} Inert Scourgestone
	["{npc:1854} keeps watch at {area:196} on {area:197}, east of the camp. He turns your 20 stones into one {item:20612}: keep it."] = "{npc:1854} 在营地东边、{area:197} 上的 {area:196} 放哨。他会把你的 20 块石头合成一块 {item:20612}：留着它。",

	-- Step 7: Commander Ashlam Valorfist
	-- {area:3197} Chillwind Camp · {area:1417} Sunken Temple
	["Back to {area:3197}. Ashlam needs the voodoo of the {area:1417}'s trolls for the stone."] = "返回 {area:3197}。阿什拉姆需要 {area:1417} 巨魔的巫毒力量来处理这块石头。",

	-- Step 8: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1477} The Temple of Atal'Hakkar · {area:1417} Sunken Temple · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:5716} Zul'Lor
	-- plural, as words: Shadow Bolt Volleys = {spell:9081} Shadow Bolt Volley
	["{area:1477}, the {area:1417}, lies in the {area:74} in eastern {zone:1435}: go up the ruin's stairs, dive into the flooded hall and follow the stairs down to the portal. It is a dungeon for a group of five at about 50-55. Six elite troll minibosses (level 51-52) stand on the balconies around the temple's great round room, each behind a pack of elites on its side path. Each drops its feather every time: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green; you need all six. Hukku calls guardians and throws Shadow Bolt Volleys, Mijan heals: kill them first."] = "{area:1477}，也就是{area:1417}，位于{zone:1435}东部的{area:74}：沿废墟台阶上去，潜入被水淹没的大厅，再沿楼梯下行至传送门。这是适合50-55级左右五人小队的地下城。6名精英巨魔小首领（51-52级）站在神殿大型圆形大厅周围的阳台上，每个都在各自侧道的一群精英后面。它们每次必掉对应羽毛：加什尔和{npc:5716}掉琥珀色，胡库和米杉掉蓝色，祖罗和洛若尔掉绿色；6个都要击杀。胡库会召唤守护者并施放群体暗影箭，米杉会治疗：优先击杀它们。",
	-- {item:20606} Amber Voodoo Feather · {npc:5716} Zul'Lor
	["{item:20606} x2: Gasher, {npc:5716}"] = "{item:20606} x2：加什尔、{npc:5716}",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607} x2: Hukku, Mijan"] = "{item:20607} x2：胡库、米杉",
	-- {item:20608} Green Voodoo Feather
	["{item:20608} x2: Zolo, Loro"] = "{item:20608} x2：祖罗、洛若尔",

	-- Step 9: Forging the Mightstone
	-- {area:3197} Chillwind Camp · {item:20620} Holy Mightstone · {item:20505} Chivalrous Signet · {item:20504} Lightforged Blade · {item:20512} Sanctified Orb · {area:2279} Stratholme · {area:2057} Scholomance
	["Back to Ashlam in {area:3197}: he forges the {item:20620}. Look at the reward window before you hand in: Classic also offered the {item:20505}, the {item:20504} or the {item:20512}, and Forever's notes say that choice may be gone. Use the stone before a fight against undead ({area:2279}, {area:2057}): it lasts ten minutes and is gone after one use."] = "回到 {area:3197} 找阿什拉姆：他会铸成 {item:20620}。交还前先查看奖励窗口：经典怀旧服还可以选择 {item:20505}、{item:20504} 或 {item:20512}，而无限的说明称这项选择可能已取消。与亡灵作战前使用这块石头（{area:2279}、{area:2057}）：效果持续十分钟，使用一次就会消失。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A one-use stone that makes you much stronger against undead for 10 minutes; the old choice rewards are gone."] = "一次性石头，10分钟内大幅增强你对亡灵的战斗力；旧的可选奖励已经取消。",
	-- ["The Scourge throughout the {zone:1422} drop Minion's Scourgestones."] = "{zone:1422}各处的天灾都会掉落{item:12840}。",
	-- ["{area:1477} lies in the {area:74} in eastern {zone:1435}. Inside, Gasher and {npc:5716} drop the {item:20606}, Hukku and Mijan the Blue, Zolo and Loro the Green."] = "{area:1477}位于{zone:1435}东部的{area:74}。在里面，加什尔和{npc:5716}掉落{item:20606}，胡库和米杉掉落蓝色，祖罗和洛若尔掉落绿色。",
	-- ["{item:12846}: equip it"] = "{item:12846}：装备上",
	-- ["{item:20606}, inside"] = "{item:20606}，在里面",
	-- ["{item:20607}, inside"] = "{item:20607}，在里面",
	-- ["{item:20608}, inside"] = "{item:20608}，在里面",
	-- ["{npc:10838} commands {area:3197} in the south of the {zone:1422}."] = "{npc:10838}指挥着{zone:1422}南部的{area:3197}。",
	-- ["{npc:5149} is in the {object:32362}."] = "{npc:5149}在{object:32362}。",
	-- ["{npc:928} is in the Cathedral of Light."] = "{npc:928}在光明大教堂。",
}
