-- Chinese (traditional) (zhTW): Polestar Recorder's interface strings.
-- Keys are the English strings exactly as the code writes them; a key
-- missing here, or commented out, shows in English. Grouped by the file that
-- first uses each key. docs/TRANSLATING.md explains the rest.

local _, ns = ...
if not (GetLocale and GetLocale() == "zhTW") then return end
local L = ns.L

-- Commands.lua
L["this client exposes no talent tree API"] = "此用戶端未提供天賦樹 API"
L["no active talent configuration (too low level?)"] = "沒有啟用的天賦配置（等級太低？）"
L["the talent configuration has no trees"] = "天賦配置中沒有天賦樹"
L["the talent trees returned no nodes"] = "天賦樹未傳回任何節點"
L["recording %s"] = "記錄%s"
L["on"] = "開"
L["off"] = "關"
L["session %s: %d events (%d breadcrumbs), %d min"] = "工作階段 %s：%d 個事件（%d 個路徑點），%d 分鐘"
L["%d events dropped by the per-session caps"] = "%d 個事件因每工作階段上限被捨棄"
L["no session yet"] = "尚無工作階段"
L["%d sessions stored, %d maps dumped"] = "已儲存 %d 個工作階段，已匯出 %d 張地圖"
L[", talents dumped"] = "，已匯出天賦"
L["this session: %s"] = "本次工作階段：%s"
L["commands: /psrec on | off | mark <text> | maps | talents | legacy | factions | skills | clear"] = "指令：/psrec on | off | mark <文字> | maps | talents | legacy | factions | skills | clear"
L["usage: /psrec mark <text>"] = "用法：/psrec mark <文字>"
L["recording is off; /psrec on first"] = "記錄已關閉；請先輸入 /psrec on"
L["marked: %s"] = "已標記：%s"
L["mark not recorded (session cap reached)"] = "標記未記錄（已達工作階段上限）"
L["recorded %d maps"] = "已記錄 %d 張地圖"
L["no maps found (C_Map unavailable)"] = "找不到地圖（C_Map 無法使用）"
L["talents not recorded: %s"] = "天賦未記錄：%s"
L["recorded %d talent nodes in %d tree(s) for %s"] = "已記錄 %d 個天賦節點，共 %d 棵樹，屬於 %s"
L["recorded %d achievements in %d categories, %d major factions (Legacy renown %s), %d Legacy tree nodes"] = "已記錄 %d 個成就（%d 個分類）、%d 個主要陣營（Legacy 名望 %s）、%d 個 Legacy 樹節點"
L["factions not recorded: this client exposes no C_Reputation list"] = "陣營未記錄：此用戶端未提供 C_Reputation 列表"
L["recorded %d factions"] = "已記錄 %d 個陣營"
L["skills not recorded: this client exposes no C_SkillInfo list"] = "技能未記錄：此用戶端未提供 C_SkillInfo 列表"
L["recorded %d skill lines"] = "已記錄 %d 個技能線"
L["all recordings cleared; new session %s"] = "所有記錄已清除；新工作階段 %s"
L["this deletes every recorded session. Type |cffffd100/psrec clear confirm|r within %d seconds to proceed."] = "這將刪除所有已記錄的工作階段。請在 %d 秒內輸入 |cffffd100/psrec clear confirm|r 以繼續。"
L["unknown command: %s"] = "未知指令：%s"
L["factions"] = "陣營"
L["skills"] = "技能"
L["legacy"] = "Legacy"
