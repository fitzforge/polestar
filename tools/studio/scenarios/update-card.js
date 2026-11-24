'use strict';
// The update card and the guide window's update line (UI/UpdateCard.lua,
// Core/Update.lua; #1656), and the report window's warning: a Tauren Hunter
// on the shipped Barrens guide runs Polestar 0.3.6. One release behind,
// Polestar Client says so (PolestarClientInfo, which the Client writes); two
// behind with no Client, a party member's 0.3.8 says so. Each at the window's
// default and narrowest widths. Needs a checkout with UI/UpdateCard.lua
// (--checkout <update-card worktree>).

const NARROW = `Polestar.Set("ui.width", Polestar.UI.MIN_WIDTH)
stub.advance(0.5)`;

// One behind: Polestar Client found 0.3.7.
const CLIENT = `Polestar.version = "0.3.6"
PolestarClientInfo = { latest = "0.3.7", checked = time(), releases = { "0.3.7", "0.3.6" } }`;
// Two behind, no Client: a party member runs 0.3.8.
const PEER = `Polestar.version = "0.3.6"
PolestarClientInfo = nil
Polestar.Update.NotePeer("0.3.8")`;
const SHOW = `Polestar.UI.UpdateCard.Show(true)
stub.advance(0.5)
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

module.exports = {
	title: 'The update card, the guide window\'s update line and the report window\'s warning (#1656)',
	character: { race: 'Tauren', cls: 'HUNTER', faction: 'Horde', level: 17, money: 4200 },
	place: { map: 1413, x: 51.6, y: 30.1, zone: 'The Barrens', subzone: 'The Crossroads' },
	guide: { id: 'forever/horde/02-the-barrens', play: 55, hours: 1.5 },
	settings: { 'behavior.offerClassQuests': false },
	window: [1440, 690],
	capture: ['PolestarGuideFrame', 'PolestarClassToast'],
	shots: {
		'client-behind': {
			title: 'One behind, Polestar Client installed: the card, and "Polestar 0.3.7 is out: you\'re on 0.3.6." with Update',
			lua: `${CLIENT}\n${SHOW}`,
		},
		'client-behind-narrow': {
			title: 'The same at the window\'s narrowest width',
			lua: `${CLIENT}\n${NARROW}\n${SHOW}`,
		},
		'peer-two-behind': {
			title: 'Two behind, no Client (a party member on 0.3.8): the stronger line, no close button',
			lua: `${PEER}\n${SHOW}`,
		},
		'peer-two-behind-narrow': {
			title: 'The same at the window\'s narrowest width',
			lua: `${PEER}\n${NARROW}\n${SHOW}`,
		},
		report: {
			title: 'The report window, one behind: the warning line at its top',
			capture: ['PolestarReport'],
			lua: `${CLIENT}\n${SHOW}\nPolestar.UI.ShowReport()\nstub.advance(0.5)`,
		},
	},
};
