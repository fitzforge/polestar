-- Chinese (simplified) (zhCN): the guide forever/class/rogue/the-eye-of-bhossca (forever/class/rogue/the-eye-of-bhossca.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:277246} Ruby-Adorned Blade · {area:796} Scarlet Monastery
	["The {item:277246}, C's payment for a solo job inside the {area:796}."] = "{item:277246}，是C为一次{area:796}单人任务支付的报酬。",

	-- Step 1: C's dead drop
	["C's dead drop"] = "C的秘密投递点",
	-- {object:410369} Dead Drop · {area:204} Pyrewood Village · {area:236} Shadowfang Keep
	["C's next job comes by letter: once you are level 30 and have done the horn job, visit any capital city and C's letter arrives in the mailbox; only then does the {object:410369} near {area:204}, in southern Silverpine just south of {area:236}, offer it. The quest data lists a minimum of 25, but players get the letter, and the job, at 30."] = "C的下一份委托通过信件送达：达到30级并完成号角委托后，前往任意主城，C的信会出现在邮箱里；之后银松森林南部{area:204}附近、{area:236}南边的{object:410369}才会提供该任务。任务资料标注最低25级，但玩家实际在30级才收到信件和委托。",

	-- Step 2: The Scarlet Monastery
	-- {area:796} Scarlet Monastery
	["The {area:796}"] = "{area:796}",
	-- {zone:1420} Tirisfal Glades · {spell:427592} Scarlet Initiate's Uniform · {spell:921} Pick Pocket · {npc:4293} Scarlet Scryer · {item:210963} Scryer's Key · {item:210968} Reliquary Key
	["The monastery stands in the far north-east of {zone:1420}. Go in alone, out of any group. Before entering, take the {spell:427592} from the Supply Locker in the stables behind the monastery and wear it; stealth and suspicious actions remove it, so put it back on after each wing change. In the Graveyard, in the Chamber of Atonement (the first big room), {spell:921} a {npc:4293} or Scarlet Crier for the {item:210963}. In the Library, open the Personal Letterbox in the Athenaeum with it and read the Confidential Message. It sends you back to sit on both benches between the two statues in the Graveyard. Watch for the mechanism's messages, then take the {item:210968} from the stone coffer: an elite stands by the coffer with a patrol behind it, but from beside the northern mausoleum you can turn the camera until the box shows and click it through the wall (an interact key works too). An elite ghost walks near the mausoleum; the broken piece at its edge keeps you out of its path. Then return to the Library for the locked reliquary and the eye. Avoid fighting through the instance."] = "修道院位于 {zone:1420} 的东北尽头。必须退出小队，独自进入。进入前，先从修道院后方马厩的补给柜取得并穿戴 {spell:427592}；潜行和可疑举动会使伪装消失，因此每次切换区域后都要重新穿戴。在墓地区的忏悔室（第一个大厅），对 {npc:4293} 或 Scarlet Crier 使用 {spell:921}，取得 {item:210963}。进入图书馆，用它打开馆内的私人信箱，并阅读机密信息。信件会指引你返回墓地区，坐上两座雕像之间的两张长椅。留意机关提示，然后从石棺中取出 {item:210968}：石棺旁有一名精英，后面还有巡逻怪，但你可以站在北侧陵墓旁转动镜头，直到看见箱子，再隔墙点击（互动按键也可用）。陵墓附近有一只精英幽灵来回走动；站在陵墓边缘的残破部分可避开其路线。随后回图书馆，获取上锁圣物匣和眼睛。尽量避免在副本内战斗。",
	["Solo route: Graveyard key, Library letter, Graveyard benches and coffer, then Library reliquary for the eye. Read the letter before the bench puzzle; check the disguise each time you change wings."] = "单人路线：墓地偷钥匙→图书馆取信→墓地长椅机关与石棺→图书馆遗物匣取眼睛。先读信再做长椅机关，每次切换区域后检查伪装。",

	-- Step 3: Back to the dead drop
	["Back to the dead drop"] = "回到秘密投递点",
	-- {object:410369} Dead Drop
	["Place the eye in the {object:410369} near Pyrewood. Check a capital mailbox for C's payment letter on your next planned city visit, then return here for the reward quest. The payment may not be available immediately; do not repeat the infiltration just because the reward has not appeared."] = "把眼睛放进焚木村附近的{object:410369}。下次计划中回主城时，检查邮箱里C的报酬来信，再回这里领取奖励任务。报酬可能不会立刻出现，不要因为暂时没有奖励就重新潜入。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Find the Eye of Bhossca inside the {area:796}."] = "在{area:796}里找到那只眼睛。",
	-- ["Place the eye in the {object:410369} near Pyrewood. C's payment is the second Eye of Bhossca quest at the same chest."] = "把眼睛放进焚木村附近的{object:410369}。C的报酬是同一个箱子的第二个眼睛任务。",
	-- ["The monastery stands in the far north-east of {zone:1420}. Go in alone. Before entering, find the disguise in the chest by the outside stables. Recheck it after changing wings: stealth and suspicious actions can remove it. In the Graveyard, pickpocket a {npc:4293} for the {item:210963}; use it on the Personal Letterbox in the Library and read the message. It sends you back to sit at both benches between the statues in the graveyard. Watch for the mechanism's messages, take the {item:210968} from the stone coffer, then return to the Library for the locked reliquary. Avoid fighting through the instance."] = "修道院位于{zone:1420}最东北端，必须独自进入。进去前，先从院外马厩旁的箱子取得伪装服装。切换区域后重新检查伪装；潜行和可疑举动可能令伪装消失。在墓地从{npc:4293}身上偷取{item:210963}，用它打开图书馆里的私人信箱并阅读信件。按信中提示回墓地，在雕像之间的两处长椅分别坐下，留意机关提示。从石棺取得{item:210968}后，再回图书馆打开上锁的遗物匣。以潜入为主，避免一路硬打。",
	-- ["The monastery stands in the far north-east of {zone:1420}. Go in alone; C advises a disguise from the monastery's grounds before you enter."] = "修道院位于{zone:1420}的最东北端。独自进去；C建议你进去前先从修道院的庭院弄一身伪装。",
	-- ["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. After the horn job and C's next letter, check it for the new job. The data lists a minimum of 25, but beta players report receiving the invitation at 30 after the horn job and a city visit; this is not a guaranteed mail level. If no new note is offered, continue leveling and check after C writes."] = "{object:410369}是银松森林南部{area:204}附近的箱子，就在{area:236}南边。完成号角委托并收到C的下一封信后，再来查看新委托。资料标注最低25级，但有测试服玩家完成号角委托后，在30级回主城时才收到邀请；这并非保证触发的来信等级。没有新字条时先继续升级，收到来信后再查看。",
	-- ["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. After the horn job and C's next letter, check it for the new job. The data lists a minimum of 25; reaching that level alone does not guarantee the letter or quest is available. If no new note is offered, continue leveling and check after C writes."] = "{object:410369}是银松森林南部{area:204}附近的箱子，就在{area:236}南边。完成号角委托并收到C的下一封信后，再来查看新委托。资料标注最低25级，但达到该等级并不保证信件或任务已经触发。没有新字条时先继续升级，收到来信后再查看。",
	-- ["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. C's next note waits there once you are 25."] = "{object:410369}是银松森林南部{area:204}附近的一个箱子，就在{area:236}南边。你到25级后，C的下一张字条会在那里等你。",
}
