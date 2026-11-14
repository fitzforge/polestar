-- A player's real SavedVariables from Polestar 0.3.6 (one account, two characters), cut down to
-- the settings and the per-character settings state: no names, realms, quests, guides, rares or recordings.
return {
	account = {
		schema = 1,
		settings = {
			nav = {
				arrowPos = {
					point = "TOP",
					relPoint = "TOP",
					x = 230.0016327,
					y = -37.00004959,
				},
				arrowStyle = "3d",
				journeyOpen = false,
			},
			party = {},
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
				pos = {
					[1] = 2940,
					[2] = 13,
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
