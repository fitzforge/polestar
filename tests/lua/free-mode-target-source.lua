local q, B = stub.qol, Polestar.QoL.Buttons
local function set(key, value)
	Polestar.Set(key, value)
	stub.runTimers()
end
local function row(i) return B.rows[i] end
local function macro(i) return (i and row(i) or B.target):GetAttribute("macrotext") end
local function isTarget(i, name)
	return row(i) and row(i):IsShown() and row(i).applied == name and macro(i):find("/targetexact " .. name, 1, true)
end
local owner = {}
q.step({ { t = "kill", target = "Guide target", npc = 6 } })
assert(isTarget(1, "Guide target"))
local first, originalStep = row(1), PolestarStepButton:GetAttribute("macrotext")
local main = "規劃器怪物"
local ender = "繳交 NPC"
local entries = {
	{ name = main, verb = "collect", id = 257, item = "任務道具", chance = 25, progress = { cur = 2, max = 5 } },
	{ name = main, verb = "kill" },
	{ name = "Unsafe\n/run example", verb = "kill" },
	{ name = ender, verb = "talk", id = 80 },
}
B.SetTargetSource(owner, entries)
assert(row(1) == first and B.anchor:IsShown() and B.ListRows() == 2, "the existing native frames are reused")
assert(isTarget(1, main) and isTarget(2, ender) and not macro():find("Guide target", 1, true))
assert(first.Note:GetText() == "任務道具" and first.Count:GetText() == "2/5")
assert(PolestarStepButton:GetAttribute("macrotext") == originalStep)
q.mouseClick(row(2))
assert(q.ran[#q.ran][2]:find("/targetexact " .. ender, 1, true))
q.units.nameplate3 = { name = main }
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate3")
stub.runTimers()
assert(first.Near:IsShown(), "the real native row scans current nameplates")
B.anchor:GetScript("OnClick")(B.anchor, "LeftButton")
assert(B.ListRows() == 1 and macro(1):find(ender, 1, true), "the native folded row scans multiple names")
B.anchor:GetScript("OnClick")(B.anchor, "LeftButton")
assert(B.ListRows() == 2)

set("qol.targetRows", 1)
assert(B.ListRows() == 1 and isTarget(1, main))
set("qol.targetSimple", true)
assert(B.ListRows() == 0 and B.target:IsShown() and macro():find(main, 1, true))
set("qol.targetSimple", false)
set("qol.targetRows", 5)
set("qol.targetButton", false)
assert(B.ListRows() == 0 and not B.anchor:IsShown())
set("qol.targetButton", true)
assert(B.ListRows() == 2 and isTarget(2, ender))
set("ui.shown", false)
assert(isTarget(1, main))
B.SetTargetSource({}, nil)
assert(isTarget(1, main), "a different caller cannot release the source")
set("ui.shown", true)
q.step({ { t = "kill", target = "Next guide target", npc = 6 } })
assert(isTarget(1, main), "changes in the guide do not override the planner's target source")
q.combat(true)
B.SetTargetSource(owner, { { name = "After combat", verb = "kill" } })
assert(isTarget(1, main) and isTarget(2, ender))
B.SetTargetSource(owner, nil)
assert(isTarget(1, main), "secure attributes stay as applied while in combat")
q.combat(false)
assert(isTarget(1, "Next guide target") and B.ListRows() == 1)
B.SetTargetSource(owner, {})
assert(B.ListRows() == 0 and not B.anchor:IsShown(), "an active empty planner clears the native list")
B.SetTargetSource(owner, nil)
assert(isTarget(1, "Next guide target") and row(1) == first)
print("Native target window: existing rows, secure click, nearby detection, folded scan, settings, combat queue, and guide restoration pass")
