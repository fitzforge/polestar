-- Polestar.Anim: short property tweens for the UI (fade, slide, pop, fill).
--
-- One hidden driver frame owns the only OnUpdate, and it is attached only
-- while something is moving. A tween record lives on its object per property
-- and is reused, so starting an animation allocates nothing after the first
-- time and a running one allocates nothing per frame.
--
-- Setting ui.reduceMotion: movement (offset, size, scale, width) snaps to its
-- end; opacity still fades, shorter, because a fade aids comprehension.

local ADDON, ns = ...
local Anim = {}
ns.Anim = Anim

local GetTime = GetTime

Anim.FAST = 0.12
Anim.BASE = 0.18
Anim.SLOW = 0.20

-- Easing. Strong ease-out for anything entering or responding to the user;
-- back-out for the small "pop" of a check; in-out for things moving on screen;
-- in for a run that gathers speed.
local EASE = {
	out = function(t) local u = 1 - t; return 1 - u * u * u * u end,
	back = function(t) local u = t - 1; return 1 + 2.4 * u * u * u + 1.4 * u * u end,
	inout = function(t) if t < 0.5 then return 4 * t * t * t end local u = -2 * t + 2; return 1 - u * u * u / 2 end,
	linear = function(t) return t end,
	-- Slow, then faster: a list going by (the guide window's catch-up).
	["in"] = function(t) return t * t end,
}
Anim.EASE = EASE

local MOTION = { offset = true, offsetX = true, size = true, scale = true, width = true, height = true, value = true }

-- How a value lands on an object, per property.
local APPLY = {
	alpha = function(o, v) o:SetAlpha(v) end,
	width = function(o, v) o:SetWidth(v) end,
	height = function(o, v) o:SetHeight(v) end,
	scale = function(o, v) o:SetScale(v) end,
	size = function(o, v) o:SetSize(v, v) end,
	-- Vertical offset from the anchor recorded by Anim.Anchor.
	offset = function(o, v)
		local p = o.psAnchor
		o:ClearAllPoints()
		o:SetPoint(p[1], p[2], p[3], p[4], p[5] + v)
	end,
	offsetX = function(o, v)
		local p = o.psAnchor
		o:ClearAllPoints()
		o:SetPoint(p[1], p[2], p[3], p[4] + v, p[5])
	end,
	-- Any number the object shows itself: o.psOnValue(o, v) (a count rolling up).
	value = function(o, v) o.psOnValue(o, v) end,
}

local driver = CreateFrame("Frame")
local active, count = {}, 0

local function finish(rec)
	rec.running = false
	APPLY[rec.kind](rec.obj, rec.to)
	local done = rec.done
	if done then
		rec.done = nil
		done(rec.obj)
	end
end

local function step()
	local now = GetTime()
	local i = 1
	while i <= count do
		local rec = active[i]
		local p = (now - rec.t0) / rec.dur
		if p >= 1 then
			active[i] = active[count]
			active[count] = nil
			count = count - 1
			finish(rec)
		else
			if p < 0 then p = 0 end
			APPLY[rec.kind](rec.obj, rec.from + (rec.to - rec.from) * rec.ease(p))
			i = i + 1
		end
	end
	if count == 0 then driver:SetScript("OnUpdate", nil) end
end

function Anim.Reduced()
	return ns.Get and ns.Get("ui.reduceMotion") and true or false
end

-- Remember where an object belongs, for "offset" tweens.
function Anim.Anchor(obj, point, rel, relPoint, x, y)
	local p = obj.psAnchor
	if not p then
		p = {}
		obj.psAnchor = p
	end
	p[1], p[2], p[3], p[4], p[5] = point, rel, relPoint, x or 0, y or 0
	obj:ClearAllPoints()
	obj:SetPoint(point, rel, relPoint, x or 0, y or 0)
end

-- Tween obj's property `kind` from -> to over dur seconds. A running tween of
-- the same property is retargeted, not stacked. done(obj) runs at the end
-- (also when snapped).
function Anim.To(obj, kind, from, to, dur, ease, done)
	local recs = obj.psTweens
	if not recs then
		recs = {}
		obj.psTweens = recs
	end
	local rec = recs[kind]
	if not rec then
		rec = { obj = obj, kind = kind }
		recs[kind] = rec
	end
	if Anim.Reduced() then
		if MOTION[kind] then dur = 0 else dur = (dur or Anim.BASE) * 0.6 end
	end
	rec.from, rec.to, rec.done = from, to, done
	rec.ease = EASE[ease or "out"] or EASE.out
	if not dur or dur <= 0 then
		if rec.running then
			for i = 1, count do
				if active[i] == rec then
					active[i] = active[count]
					active[count] = nil
					count = count - 1
					break
				end
			end
		end
		finish(rec)
		if count == 0 then driver:SetScript("OnUpdate", nil) end
		return
	end
	rec.t0, rec.dur = GetTime(), dur
	APPLY[kind](obj, from)
	if not rec.running then
		rec.running = true
		count = count + 1
		active[count] = rec
		if count == 1 then driver:SetScript("OnUpdate", step) end
	end
end

-- Jump a running tween to its end.
function Anim.Stop(obj, kind)
	local rec = obj.psTweens and obj.psTweens[kind]
	if rec and rec.running then
		rec.dur = 1e-9
		rec.t0 = GetTime() - 1
		step()
	end
end

function Anim.IsRunning(obj, kind)
	local rec = obj and obj.psTweens and obj.psTweens[kind]
	return rec and rec.running or false
end

-- Number of tweens in flight (the driver's OnUpdate exists only while > 0).
function Anim.Active()
	return count
end
