-- Chinese (simplified) (zhCN): Polestar Recorder's interface strings.
-- Keys are the English strings exactly as the code writes them; a key
-- missing here, or commented out, shows in English. Grouped by the file that
-- first uses each key. docs/TRANSLATING.md explains the rest.

local _, ns = ...
if not (GetLocale and GetLocale() == "zhCN") then return end
local L = ns.L

-- Commands.lua
L["this client exposes no talent tree API"] = "此客户端未提供天赋树 API"
L["no active talent configuration (too low level?)"] = "没有激活的天赋配置（等级太低？）"
L["the talent configuration has no trees"] = "天赋配置中没有天赋树"
L["the talent trees returned no nodes"] = "天赋树未返回任何节点"
L["recording %s"] = "记录%s"
L["on"] = "开"
L["off"] = "关"
L["session %s: %d events (%d breadcrumbs), %d min"] = "会话 %s：%d 个事件（%d 个路径点），%d 分钟"
L["%d events dropped by the per-session caps"] = "%d 个事件因每会话上限被丢弃"
L["no session yet"] = "尚无会话"
L["%d sessions stored, %d maps dumped"] = "已存储 %d 个会话，已导出 %d 张地图"
L[", talents dumped"] = "，已导出天赋"
L["this session: %s"] = "本次会话：%s"
L["commands: /psrec on | off | mark <text> | maps | talents | legacy | factions | skills | clear"] = "命令：/psrec on | off | mark <文本> | maps | talents | legacy | factions | skills | clear"
L["usage: /psrec mark <text>"] = "用法：/psrec mark <文本>"
L["recording is off; /psrec on first"] = "记录已关闭；请先输入 /psrec on"
L["marked: %s"] = "已标记：%s"
L["mark not recorded (session cap reached)"] = "标记未记录（已达会话上限）"
L["recorded %d maps"] = "已记录 %d 张地图"
L["no maps found (C_Map unavailable)"] = "未找到地图（C_Map 不可用）"
L["talents not recorded: %s"] = "天赋未记录：%s"
L["recorded %d talent nodes in %d tree(s) for %s"] = "已记录 %d 个天赋节点，共 %d 棵树，属于 %s"
L["recorded %d achievements in %d categories, %d major factions (Legacy renown %s), %d Legacy tree nodes"] = "已记录 %d 个成就（%d 个分类）、%d 个主要阵营（Legacy 名望 %s）、%d 个 Legacy 树节点"
L["factions not recorded: this client exposes no C_Reputation list"] = "阵营未记录：此客户端未提供 C_Reputation 列表"
L["recorded %d factions"] = "已记录 %d 个阵营"
L["skills not recorded: this client exposes no C_SkillInfo list"] = "技能未记录：此客户端未提供 C_SkillInfo 列表"
L["recorded %d skill lines"] = "已记录 %d 个技能线"
L["all recordings cleared; new session %s"] = "所有记录已清除；新会话 %s"
L["this deletes every recorded session. Type |cffffd100/psrec clear confirm|r within %d seconds to proceed."] = "这将删除所有已记录的会话。请在 %d 秒内输入 |cffffd100/psrec clear confirm|r 以继续。"
L["unknown command: %s"] = "未知命令：%s"
L["factions"] = "阵营"
L["skills"] = "技能"
L["legacy"] = "Legacy"
