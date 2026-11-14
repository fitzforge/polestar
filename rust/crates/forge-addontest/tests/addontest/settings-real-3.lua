-- A player's real SavedVariables from Polestar 0.3.6 (one account, two characters), cut down to
-- the settings and the per-character settings state: no names, realms, quests, guides, rares or recordings.
return {
	account = {
		lineStyleKept = true,
		schema = 1,
		settings = {
			alts = {},
			maps = {},
			nav = {
				arrowPos = {
					point = "TOP",
					relPoint = "TOP",
					x = -35.2111969,
					y = -20.12544632,
				},
				arrowStyle = "3d",
				journeyOpen = false,
				lineStyle = "dots",
			},
			party = {},
			qol = {
				markTarget = true,
			},
			rares = {
				toastPoint = {
					[1] = "CENTER",
					[2] = -520,
					[3] = 130,
				},
			},
			ui = {
				growUp = true,
				notesOpen = false,
				pickerCollapsed = {
					["Class/Raid"] = true,
					["Class/Warlock"] = true,
					["Leveling/Horde/30"] = true,
					["Leveling/Horde/50"] = true,
					["Leveling/other-starts"] = true,
					Professions = true,
				},
				pickerFaction = "Horde",
				pos = {
					[1] = 3044,
					[2] = 26,
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
