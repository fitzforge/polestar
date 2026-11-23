-- A player's real SavedVariables from Polestar 0.3.6 (one account, two characters), cut down to
-- the settings and the per-character settings state: no names, realms, quests, guides, rares or recordings.
return {
	account = {
		lineStyleKept = true,
		schema = 1,
		settings = {
			nav = {
				arrowPos = {
					point = "TOP",
					relPoint = "TOP",
					x = -51.9982338,
					y = -24.00001335,
				},
				arrowStyle = "3d",
				journeyOpen = false,
				lineStyle = "sparkle",
				minimapRouteSize = 1.5,
			},
			party = {},
			qol = {
				markTarget = true,
			},
			rares = {
				toastPoint = {
					[1] = "TOP",
					[2] = -282,
					[3] = -290,
				},
			},
			ui = {
				growUp = true,
				menuScale = 0.9,
				notesOpen = false,
				pickerCollapsed = {
					["Class/Raid"] = true,
					["Class/Warlock"] = true,
					["Leveling/Horde/30"] = true,
					["Leveling/Horde/40"] = true,
					["Leveling/Horde/50"] = true,
					["Leveling/other-starts"] = true,
					Professions = true,
				},
				pos = {
					[1] = 3485,
					[2] = 28,
				},
				width = 418,
			},
		},
	},
	chars = {
		[1] = {
			qol = {
				buttonPos = {
					[1] = "BOTTOM",
					[2] = "BOTTOM",
					[3] = -56.00008392,
					[4] = 286.0001831,
				},
			},
			schema = 1,
		},
		[2] = {
			qol = {
				buttonPos = {
					[1] = "BOTTOM",
					[2] = "BOTTOM",
					[3] = -77.75753021,
					[4] = 303.1373901,
				},
			},
			schema = 1,
		},
	},
}
