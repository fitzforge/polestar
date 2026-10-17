-- Korean (koKR): Polestar Recorder's interface strings.
-- Keys are the English strings exactly as the code writes them; a key
-- missing here, or commented out, shows in English. Grouped by the file that
-- first uses each key. docs/TRANSLATING.md explains the rest.

local _, ns = ...
if not (GetLocale and GetLocale() == "koKR") then return end
local L = ns.L

-- Commands.lua
L["this client exposes no talent tree API"] = "이 클라이언트는 특성 트리 API를 제공하지 않습니다"
L["no active talent configuration (too low level?)"] = "활성화된 특성 구성이 없습니다(레벨이 너무 낮습니까?)"
L["the talent configuration has no trees"] = "특성 구성에 트리가 없습니다"
L["the talent trees returned no nodes"] = "특성 트리에서 노드가 반환되지 않았습니다"
L["recording %s"] = "기록 %s"
L["on"] = "켜짐"
L["off"] = "꺼짐"
L["session %s: %d events (%d breadcrumbs), %d min"] = "세션 %s: 이벤트 %d개(이동 흔적 %d개), %d분"
L["%d events dropped by the per-session caps"] = "세션당 한도로 인해 이벤트 %d개가 버려졌습니다"
L["no session yet"] = "아직 세션이 없습니다"
L["%d sessions stored, %d maps dumped"] = "세션 %d개 저장됨, 지도 %d개 덤프됨"
L[", talents dumped"] = ", 특성 덤프됨"
L["this session: %s"] = "이번 세션: %s"
L["commands: /psrec on | off | mark <text> | maps | talents | legacy | factions | skills | clear"] = "명령어: /psrec on | off | mark <텍스트> | maps | talents | legacy | factions | skills | clear"
L["usage: /psrec mark <text>"] = "사용법: /psrec mark <텍스트>"
L["recording is off; /psrec on first"] = "기록이 꺼져 있습니다. 먼저 /psrec on을 입력하세요"
L["marked: %s"] = "표시됨: %s"
L["mark not recorded (session cap reached)"] = "표시가 기록되지 않음(세션 한도 도달)"
L["recorded %d maps"] = "지도 %d개 기록됨"
L["no maps found (C_Map unavailable)"] = "지도를 찾을 수 없습니다(C_Map 사용 불가)"
L["talents not recorded: %s"] = "특성이 기록되지 않음: %s"
L["recorded %d talent nodes in %d tree(s) for %s"] = "%3$s의 트리 %2$d개에서 특성 노드 %1$d개 기록됨"
L["recorded %d achievements in %d categories, %d major factions (Legacy renown %s), %d Legacy tree nodes"] = "업적 %d개(분류 %d개), 주요 진영 %d개(레거시 명성 %s), 레거시 트리 노드 %d개 기록됨"
L["factions not recorded: this client exposes no C_Reputation list"] = "평판이 기록되지 않음: 이 클라이언트는 C_Reputation 목록을 제공하지 않습니다"
L["recorded %d factions"] = "평판 %d개 기록됨"
L["skills not recorded: this client exposes no C_SkillInfo list"] = "기술이 기록되지 않음: 이 클라이언트는 C_SkillInfo 목록을 제공하지 않습니다"
L["recorded %d skill lines"] = "기술 계열 %d개 기록됨"
L["all recordings cleared; new session %s"] = "모든 기록이 삭제됨, 새 세션 %s"
L["this deletes every recorded session. Type |cffffd100/psrec clear confirm|r within %d seconds to proceed."] = "기록된 모든 세션이 삭제됩니다. 계속하려면 %d초 안에 |cffffd100/psrec clear confirm|r을 입력하세요."
L["unknown command: %s"] = "알 수 없는 명령어: %s"
L["factions"] = "평판"
L["skills"] = "기술"
L["legacy"] = "레거시"
