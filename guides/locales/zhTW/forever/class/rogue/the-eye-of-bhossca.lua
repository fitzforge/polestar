-- Chinese (traditional) (zhTW): the guide forever/class/rogue/the-eye-of-bhossca (forever/class/rogue/the-eye-of-bhossca.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:277246} Ruby-Adorned Blade · {area:796} Scarlet Monastery · {quest:78307} The Horn of Xelthos
	["The {item:277246}, C's payment for a solo job in the {area:796}, after {quest:78307}."] = "{item:277246}，C為{area:796}的一次單人工作支付的報酬，在{quest:78307}之後。",

	-- Step 1: C's dead drop
	["C's dead drop"] = "C的秘密投遞點",
	-- {quest:78307} The Horn of Xelthos · {object:410369} Dead Drop · {area:204} Pyrewood Village · {area:236} Shadowfang Keep
	["C's next job comes by letter: once you are level 30 and have done the horn job ({quest:78307}, its payment from this {object:410369} handed in), visit any capital city and C's letter arrives in the mailbox; only then does the {object:410369} near {area:204}, in southern Silverpine just south of {area:236}, offer it. The quest data lists a minimum of 25, but players get the letter, and the job, at 30."] = "C的下一份工作透過信件送來：當你達到30級並完成了號角的工作（{quest:78307}，以及從這個{object:410369}領取的報酬已繳交），去任意主城，C的信就會寄到信箱；只有那時，{area:204}附近的{object:410369}（在銀松森林南部、{area:236}以南）才會提供這份工作。任務資料中寫的最低等級是25，但玩家在30級才收到信和工作。",

	-- Step 2: The Scarlet Monastery
	-- {area:796} Scarlet Monastery
	["The {area:796}"] = "{area:796}",
	-- {zone:1420} Tirisfal Glades · {item:210955} Scarlet Initiate's Uniform · {object:412147} Supply Locker (no name in this language: may be words) · {spell:921} Pick Pocket · {npc:4293} Scarlet Scryer · {item:210963} Scryer's Key · {object:412759} Personal Letterbox (no name in this language: may be words) · {item:210967} Confidential Message · {item:210968} Reliquary Key
	["The monastery stands in the far north-east of {zone:1420}. Go in alone, out of any group. Before entering, take the {item:210955} from the {object:412147} in the stables behind the monastery and wear it; stealth and suspicious actions remove it, so put it back on after each wing change. In the Graveyard, in the Chamber of Atonement (the first big room), {spell:921} a {npc:4293} or Scarlet Crier for the {item:210963}. In the Library, open the {object:412759} in the Athenaeum with it and read the {item:210967}. It sends you back to sit on both benches between the two statues in the Graveyard. Watch for the mechanism's messages, then take the {item:210968} from the stone coffer: an elite stands by the coffer with a patrol behind it, but from beside the northern mausoleum you can turn the camera until the box shows and click it through the wall (an interact key works too). An elite ghost walks near the mausoleum; the broken piece at its edge keeps you out of its path. Then return to the Library for the locked reliquary and the eye. Avoid fighting through the instance."] = "修道院位於{zone:1420}的最東北部。獨自進入，不要在任何隊伍中。進入前，從修道院後面馬廄裡的{object:412147}拿取{item:210955}並穿上；潛行和可疑行為會讓它脫落，所以每次換區後都要重新穿上。在墓地的贖罪之廳（第一個大房間），對{npc:4293}或血色傳令官使用{spell:921}，取得{item:210963}。在圖書館，用它打開學者之廳裡的{object:412759}並閱讀{item:210967}。它會讓你回到墓地，坐在兩座雕像之間的兩張長椅上。注意機關的訊息，然後從石櫃中拿取{item:210968}：石櫃旁站著一個精英，後面有巡邏，但從北邊陵墓旁可以轉動視角直到看見箱子，然後隔著牆點擊它（互動鍵也可以）。一個精英幽靈在陵墓附近走動；陵墓邊緣的斷塊能讓你避開它的路線。然後回到圖書館拿取上鎖的聖物匣和眼睛。避免在副本裡一路打過去。",
	["Solo route: Graveyard key, Library letter, Graveyard benches and coffer, then Library reliquary for the eye. Read the letter before the bench puzzle; check the disguise each time you change wings."] = "單人路線：墓地偷鑰匙→圖書館取信→墓地長椅機關與石棺→圖書館遺物匣取眼睛。先讀信再做長椅機關，每次切換區域後檢查偽裝。",
	["the locked reliquary in the Library"] = "圖書館裡上鎖的聖物箱",

	-- Step 3: Back to the dead drop
	["Back to the dead drop"] = "回到秘密投遞點",
	-- {object:410369} Dead Drop
	["Place the eye in the {object:410369} near Pyrewood. Check a capital mailbox for C's payment letter on your next planned city visit, then return here for the reward quest. The payment may not be available immediately; do not repeat the infiltration just because the reward has not appeared."] = "把眼睛放進焚木村附近的{object:410369}。下次計劃中回主城時，檢查郵箱裡C的報酬來信，再回這裡領取獎勵任務。報酬可能不會立刻出現，不要因為暫時沒有獎勵就重新潛入。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["C's next job comes by letter: once you are level 30 and have done the horn job (The {item:210183}, its payment from this {object:410369} handed in), visit any capital city and C's letter arrives in the mailbox; only then does the {object:410369} near {area:204}, in southern Silverpine just south of {area:236}, offer it. The quest data lists a minimum of 25, but players get the letter, and the job, at 30."] = "C的下一個任務會透過信件送來：等你到30級並完成號角任務（{item:210183}，並已從這個{object:410369}繳交報酬）後，前往任一主城，C的信就會出現在信箱裡；之後位於銀松森林南部、{area:236}南邊不遠處的{area:204}附近的{object:410369}才會提供任務。任務資料標示最低25級，但玩家都是在30級才收到信並接到任務。",
	-- ["Find the Eye of Bhossca inside the {area:796}."] = "在{area:796}裡找到任務要的那顆眼睛。",
	-- ["Place the eye in the {object:410369} near Pyrewood. C's payment is the second Eye of Bhossca quest at the same chest."] = "把眼睛放進焚木村附近的{object:410369}。C的報酬是同一個箱子的第二個眼睛任務。",
	-- ["The monastery stands in the far north-east of {zone:1420}. Go in alone, out of any group. Before entering, take the {item:210955} from the {object:412147} in the stables behind the monastery and wear it; stealth and suspicious actions remove it, so put it back on after each wing change. In the Graveyard, in the Chamber of Atonement (the first big room), {spell:921} a {npc:4293} or Scarlet Crier for the {item:210963}. In the Library, open the Personal Letterbox in the Athenaeum with it and read the {item:210967}. It sends you back to sit on both benches between the two statues in the Graveyard. Watch for the mechanism's messages, then take the {item:210968} from the stone coffer: an elite stands by the coffer with a patrol behind it, but from beside the northern mausoleum you can turn the camera until the box shows and click it through the wall (an interact key works too). An elite ghost walks near the mausoleum; the broken piece at its edge keeps you out of its path. Then return to the Library for the locked reliquary and the eye. Avoid fighting through the instance."] = "修道院位於 {zone:1420} 的東北盡頭。必須退出小隊，獨自進入。進入前，先從修道院後方馬廄的 {object:412147} 取得並穿戴 {item:210955}；潛行和可疑舉動會使偽裝消失，因此每次切換區域後都要重新穿戴。在墓地區的懺悔室（第一個大廳），對 {npc:4293} 或 Scarlet Crier 使用 {spell:921}，取得 {item:210963}。進入圖書館，用它開啟館內的私人信箱，並閱讀 {item:210967}。信件會指引你返回墓地區，坐上兩座雕像之間的兩張長椅。留意機關提示，然後從石棺中取出 {item:210968}：石棺旁有一名精英，後面還有巡邏怪，但你可以站在北側陵墓旁轉動鏡頭，直到看見箱子，再隔牆點選（互動按鍵也可用）。陵墓附近有一隻精英幽靈來回走動；站在陵墓邊緣的殘破部分可避開其路線。隨後回圖書館，獲取上鎖聖物匣和眼睛。儘量避免在副本內戰鬥。",
	-- ["The monastery stands in the far north-east of {zone:1420}. Go in alone; C advises a disguise from the monastery's grounds before you enter."] = "修道院位於{zone:1420}的最東北方。單獨進去；C建議你在進入前先從修道院的庭院取得偽裝。",
	-- ["The {item:277246}, C's payment for a solo job in the {area:796}, after The {item:210183}."] = "{item:277246}，C為{area:796}內一次單人任務支付的報酬，接在{item:210183}之後。",
	-- ["The {item:277246}, C's payment for a solo job inside the {area:796}."] = "{item:277246}，C為{area:796}內一次單人任務支付的報酬。",
	-- ["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. C's next note waits there once you are 25."] = "{object:410369}是銀松森林南部{area:204}附近的一個箱子，就在{area:236}南邊。你25級後，C的下一張字條就在那裡等著。",
}
