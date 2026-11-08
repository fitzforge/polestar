-- Chinese (traditional) (zhTW): the guide forever/class/hunter/rhokdelar (forever/class/hunter/rhokdelar.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Rhok'delar and Lok'delar"] = "洛克德拉爾與羅可德拉爾",
	["The hunter's epic bow chain: in Classic the stave and sinew became Rhok'delar and Lok'delar (unconfirmed in Forever)."] = "獵人的史詩弓任務鏈：在經典版中，法杖和弓弦會變成洛克德拉爾和羅可德拉爾（Forever中尚未確認）。",

	-- Step 1: The Ancient Petrified Leaf
	-- {item:18703} Ancient Petrified Leaf
	["The {item:18703}"] = "{item:18703}",
	-- {npc:12018} Majordomo Executus · {object:179703} Cache of the Firelord · {item:18703} Ancient Petrified Leaf
	["Molten Core is a 40-player raid inside Blackrock Mountain. When {npc:12018} yields, the {object:179703} appears; it holds the {item:18703} about half the time, one per kill, so it may take several weeks of raids. Right-click the leaf to start the quest."] = "",
	-- {item:18703} Ancient Petrified Leaf
	["from the {item:18703}"] = "從{item:18703}取得",

	-- Step 2: Vartrus the Ancient
	-- {npc:14526} Hastat the Ancient · {zone:1448} Felwood · {object:177106} Talonbranch Glade (no name in this language: may be words) · {quest:7636} Stave of the Ancients
	["Vartrus, Stoma and {npc:14526} are petrified trees on a small island in a ring-shaped lake in Irontree Woods, north {zone:1448}. Their spirits only appear when someone carrying the leaf climbs the island's little hill to its east edge. Alliance: fly to {object:177106}; Horde: fly to Bloodvenom Post. Vartrus gives {quest:7636}, Stoma A Proper String, Hastat the quiver; each can be handed in on its own."] = "",
	-- {npc:14526} Hastat the Ancient
	["{npc:14526}: the quiver, last in this guide"] = "{npc:14526}：箭袋，本指南最後一步",

	-- Step 3: Before the demons
	["Before the demons"] = "",
	-- {item:9224} Elixir of Demonslaying · {skill:171} Alchemy
	-- plural, as words: Major Mana Potions = {item:13444} Major Mana Potion
	["The four demons are level 60 elites disguised as friendly travellers; talk to one and say you know what it is, and it turns into its demon form. Fight every one alone: no pet (dismiss it), no other player's heal, buff or attack once the fight starts, or the demon calls you a coward and vanishes, with a 3 hour wait for it to return (also after it dies). Buffs and potions you take before the pull are fine, and a friend may stand by to kill wandering monsters or enemy players, as long as they never touch the demon or you. Bring an {item:9224} ({skill:171} or the auction house), Major Mana Potions for the long kites, and a melee weapon with the Demonslaying enchant if you can. Track Demons, from your trainer, shows the disguised demons on the minimap. In a group, set loot to free for all so you can loot the head."] = "",
	["Learn Track Demons and get demon-slaying potions"] = "",

	-- Step 4: Simone the Seductress
	-- {npc:14527} Simone the Inconspicuous · {npc:14533} Simone the Seductress
	["{npc:14527}, a troll with a wolf, walks a long path that starts at the lake in western Un'Goro and can reach the south of the crater; use Track Demons. Talk to her and she becomes {npc:14533}, and her wolf Precious a Felstalker. The hardest of the four: Freezing Trap Precious and pull Simone well away from it, or kite Precious away and kill it first, let Simone reset and come back for her alone. Her Chain Lightning hits hard, so drain her mana with Viper Sting (a 15-second cooldown on Forever) and keep her busy; her Temptress' Kiss cuts your ranged attack power, so finish her in melee. Loot her head before Precious breaks free."] = "",

	-- Step 5: Klinfran the Crazed
	-- {npc:14529} Franklin the Friendly · {zone:1428} Burning Steppes · {npc:14534} Klinfran the Crazed
	["{npc:14529}, a human, wanders the western {zone:1428} south of Blackrock Mountain. Talk to him and he becomes {npc:14534}, the easiest of the four. Keep Scorpid Sting on him the whole fight: while it lasts he barely hurts you. When he goes into Demonic Frenzy, remove it with Tranquilizing Shot and never stand in melee while it is up; between frenzies you can fight him in melee with Wing Clip and Raptor Strike. He cannot leave the {zone:1428}, so kite him around the trees if needed."] = "",

	-- Step 6: Solenor the Slayer
	-- {npc:14536} Nelson the Nice · {zone:1451} Silithus · {npc:14530} Solenor the Slayer · {object:164639} Frost Trap (no name in this language: may be words) · {npc:14761} Creeping Doom
	["{npc:14536}, a gnome, walks around the gates of Ahn'Qiraj in the far south-west of {zone:1451}. Talk to him and he becomes {npc:14530}. He enrages with Soul Flame as he turns: drop a {object:164639}, Feign Death, and he resets without the enrage. Wing Clip roots him for a long time; while rooted he fears you and sends beetles ({npc:14761}): kill them fast with traps and Multi-Shot before they wear you down."] = "",

	-- Step 7: Artorius the Doombringer
	-- {npc:14531} Artorius the Amiable · {zone:1452} Winterspring · {npc:14535} Artorius the Doombringer
	["{npc:14531}, a tauren, walks a loop in the rocks of northern {zone:1452}, north of Everlook. Talk to him and he becomes {npc:14535}. Within 30 yards of him Demonic Doom hits hard: keep your distance and kite him the whole fight, Aspect of the Cheetah on, south down the road. Serpent Sting on him adds Stinging Trauma, extra Nature damage, so keep it ticking while you run; his Demonic Frenzy can be removed with Tranquilizing Shot, but distance matters more. It is a long fight: bring mana potions and plan your kiting path."] = "",

	-- Step 8: Onyxia
	["Onyxia"] = "奧妮克希亞",
	-- {zone:1445} Dustwallow Marsh · {item:18705} Mature Black Dragon Sinew
	["Onyxia is the 40-player raid boss of Onyxia's Lair, a cave in the Wyrmbog of southern {zone:1445}; she returns once a week. She drops one {item:18705} in about two kills of five, lootable without the quest, so only one hunter per kill gets it: settle who first."] = "",
	-- {item:18705} Mature Black Dragon Sinew
	["{item:18705}, from Onyxia"] = "{item:18705}，來自奧妮克希亞",

	-- Step 9: Back to the Ancients
	["Back to the Ancients"] = "返回古樹",

	-- Step 10: Rhok'delar and Lok'delar
	-- {item:18707} Ancient Rune Etched Stave · {item:18724} Enchanted Black Dragon Sinew · {item:18715} Lok'delar, Stave of the Ancient Keepers
	["Not confirmed in Forever. In Classic, using the {item:18707} with the {item:18724} in your bags made Rhok'delar, and talking to Vartrus once more then gave {item:18715}, at no extra cost."] = "",
	-- {item:18707} Ancient Rune Etched Stave
	["{item:18707}, by Vartrus"] = "{item:18707}，由古樹瓦特魯斯給予",
	-- {npc:14524} Vartrus the Ancient
	["{npc:14524}: Lok'delar in Classic"] = "{npc:14524}：經典版中的羅可德拉爾",

	-- Step 11: Azuregos
	-- {item:18704} Mature Blue Dragon Sinew · {npc:6109} Azuregos · {zone:1447} Azshara · {zone:1452} Winterspring
	["Hastat's quiver needs the {item:18704}. {npc:6109}, a world boss for a raid, stands in southern {zone:1447}, returns only every two to four days and drops it nearly every kill. The elite Cobalt dragonkin in and around Mazthoril, the cave south of Everlook in {zone:1452}, drop it about once in 200 kills; Manaclaw there a little more often. Skip the rest of this guide if you do not want the quiver."] = "",
	-- {item:18704} Mature Blue Dragon Sinew · {npc:6109} Azuregos
	["{item:18704}, from {npc:6109}"] = "{item:18704}，來自{npc:6109}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Azuregos"] = "艾索雷葛斯",
	-- ["Hastat's quiver needs the {item:18704}. {npc:6109}, a world boss for a raid, roams the south of {zone:1447} and drops it most of the time; the Cobalt dragonkin of {zone:1452} drop it very rarely. Skip the rest of this guide if you do not want the quiver."] = "古樹哈斯塔特的箭袋需要{item:18704}。{npc:6109}是需要團隊的世界首領，在{zone:1447}南部遊蕩，大多會掉落；{zone:1452}的深藍龍族極少掉落。如果你不想要箭袋，跳過本指南其餘部分。",
	-- ["Not confirmed in Forever. In Classic, using the {item:18707} with the {item:18724} in your bags made Rhok'delar, and Vartrus then gave {item:18715} ({spell:425121})."] = "Forever中尚未確認。在經典版中，背包裡有{item:18724}時使用{item:18707}即可製成洛克德拉爾，然後古樹瓦特魯斯會給你{item:18715}（{spell:425121}）。",
	-- ["Onyxia drops the {item:18705}; she is the 40-player raid boss of {area:2159}, a cave in the {area:511} of southern {zone:1445}."] = "奧妮克希亞會掉落{item:18705}；她是{area:2159}的40人團隊首領，巢穴位於{zone:1445}南部{area:511}的洞穴中。",
	-- ["The {object:179703} appears in {area:2717} when {npc:12018} yields; it holds the {item:18703} about half the time. {area:2717} is a 40-player raid inside {area:254}. Right-click the leaf to start the quest."] = "{npc:12018}投降時，{object:179703}會出現在{area:2717}；約有一半機率內含{item:18703}。{area:2717}是{area:254}內的40人團隊副本。右鍵點擊葉子開始任務。",
	-- ["Vartrus, Stoma and {npc:14526} stand together in the north of {zone:1448}. Alliance: {area:1998} is the nearest flight point; Horde: {area:1997}."] = "古樹瓦特魯斯、古樹斯托瑪和{npc:14526}一起站在{zone:1448}北部。聯盟：最近的飛行點是{area:1998}；部落：{area:1997}。",
	-- ["{npc:14527}, a troll, stands in the west of {zone:1449}. Talk to her and she becomes {npc:14533}, with a pet of her own. Alone, without your pet."] = "食人妖{npc:14527}站在{zone:1449}西部。和她交談，她會變成{npc:14533}，還帶著自己的寵物。單獨對付，不帶寵物。",
	-- ["{npc:14529}, a human, stands in the west of the {zone:1428}. Talk to him and he becomes {npc:14534}. Alone, without your pet."] = "人類{npc:14529}站在{zone:1428}西部。和他交談，他會變成{npc:14534}。單獨對付，不帶寵物。",
	-- ["{npc:14531}, a tauren, waits in the north-east of {zone:1452}. Talk to him and he becomes {npc:14535}. Fight every demon alone and without your pet: help of any kind makes it vanish. Loot the head."] = "牛頭人{npc:14531}在{zone:1452}東北部等著。和他交談，他會變成{npc:14535}。每個惡魔都要單獨且不帶寵物對付：任何形式的幫助都會讓它消失。拾取頭顱。",
	-- ["{npc:14536}, a gnome, stands in the south-west of {zone:1451}. Talk to him and he becomes {npc:14530}. Alone, without your pet; keep away from the beetles he calls."] = "地精{npc:14536}站在{zone:1451}西南部。和他交談，他會變成{npc:14530}。單獨對付，不帶寵物；遠離他召喚的甲蟲。",
}
