-- env: atlas
-- The Guide window page's settings only the Atlas layout draws (the "ui" environment with the Atlas layout
-- loaded and picked): Journey style, read off where the layout places the Journey card.
local J
-- Whether the layout leaves the Journey card showing: it hides it in the foot style, where the chips stand for it.
-- The card is shown before it is handed over, as the window's Journey shows itself before the layout places it.
local function journeyShown()
	J:Show()
	Polestar.ThemeInternal.LAYOUTS.atlas.hooks.guidePlace("journey", J, 300, 40)
	return J:IsShown()
end
return {
	setup = function()
		Polestar.Theme.SetLayout("atlas")
		uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
		J = CreateFrame("Frame", nil, PolestarGuideFrame)
		J:SetHeight(40)
	end,
	settle = 0.3,
	probes = {
		["guideWindow.journeyStyle"] = { value = "foot", probe = journeyShown },
		-- Where the cards' stack hangs (#4269): its first point, on the window's top edge or under its foot.
		["guideWindow.cardsPlace"] = { value = "below", probe = function()
			Polestar.UI.GuideFrame.Render()
			local s = _G.PolestarGuideFrameCards
			return s and s:GetPoint(1) or false
		end },
	},
}
