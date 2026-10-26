import * as OtherInputs from '../core/components/other_inputs.js';
import { Phase } from '../core/constants/other.js';
import { IndividualSimUI, registerSpecConfig } from '../core/individual_sim_ui.js';
import { Player } from '../core/player.js';
import {
	Class,
	Faction,
	PartyBuffs,
PseudoStat,
	Race,
	Spec,
	Stat, } from '../core/proto/common.js';
import { Stats } from '../core/proto_utils/stats.js';
import { getSpecIcon } from '../core/proto_utils/utils.js';
import * as WarriorInputs from './inputs.js';
import * as Presets from './presets.js';

const SPEC_CONFIG = registerSpecConfig(Spec.SpecWarrior, {
	cssClass: 'warrior-sim-ui',
	cssScheme: 'warrior',
	// List any known bugs / issues here and they'll be shown on the site.
	knownIssues: [
		"Rage conversion is a bit off for non 60s",
		"Prot oriented Runes (Devastate and Sword and Board) are not yet implemented",
		"Head and Bracers Runes are not yet implemented"
	],

	// All stats for which EP should be calculated.
	epStats: [
		Stat.StatStrength,
		Stat.StatAgility,
		Stat.StatAttackPower,
		Stat.StatMeleeHit,
		Stat.StatMeleeCrit,
		Stat.StatMeleeHaste,
		Stat.StatArmor,
	],
	epPseudoStats: [
		PseudoStat.PseudoStatMainHandDps,
		PseudoStat.PseudoStatOffHandDps,
	],
	// Reference stat against which to calculate EP. I think all classes use either spell power or attack power.
	epReferenceStat: Stat.StatAttackPower,
	// Which stats to display in the Character Stats section, at the bottom of the left-hand sidebar.
	displayStats: [
		Stat.StatHealth,
		Stat.StatStamina,
		Stat.StatStrength,
		Stat.StatAgility,
		Stat.StatAttackPower,
		Stat.StatMeleeHit,
		Stat.StatMeleeCrit,
		Stat.StatMeleeHaste,
		Stat.StatArmor,
	],
	modifyDisplayStats: (_: Player<Spec.SpecWarrior>) => {
		const stats = new Stats();

		return {
			talents: stats,
		};
	},

	defaults: {
		// Default equipped gear.
		gear: Presets.GearFuryPhase2.gear,
		// Default EP weights for sorting gear in the gear picker.
		epWeights: Stats.fromMap({
			[Stat.StatStrength]: 2.72,
			[Stat.StatAgility]: 1.82,
			[Stat.StatAttackPower]: 1,
			[Stat.StatExpertise]: 2.55,
			[Stat.StatMeleeHit]: 0.79,
			[Stat.StatMeleeCrit]: 2.12,
			[Stat.StatMeleeHaste]: 1.72,
			[Stat.StatArmorPenetration]: 2.17,
			[Stat.StatArmor]: 0.03,
		}, {
			[PseudoStat.PseudoStatMainHandDps]: 6.29,
			[PseudoStat.PseudoStatOffHandDps]: 3.58,
		}),
		// Default consumes settings.
		consumes: Presets.DefaultConsumes,
		// Default talents.
		talents: Presets.TalentsPhase2Fury.data,
		// Default spec-specific settings.
		specOptions: Presets.DefaultOptions,
		other: Presets.OtherDefaults,
		// Default raid/party buffs settings.
		raidBuffs: Presets.DefaultRaidBuffs,
		partyBuffs: PartyBuffs.create({}),
		individualBuffs: Presets.DefaultIndividualBuffs,
		debuffs: Presets.DefaultDebuffs,
	},

	// IconInputs to include in the 'Player' section on the settings tab.
	playerIconInputs: [
		WarriorInputs.ShoutPicker,
	],
	// Buff and Debuff inputs to include/exclude, overriding the EP-based defaults.
	includeBuffDebuffInputs: [
	],
	excludeBuffDebuffInputs: [
	],
	// Inputs to include in the 'Other' section on the settings tab.
	otherInputs: {
		inputs: [
			WarriorInputs.StartingRage,
			WarriorInputs.StanceSnapshot,
			OtherInputs.TankAssignment,
			OtherInputs.InFrontOfTarget,
		],
	},
	encounterPicker: {
		// Whether to include 'Execute Duration (%)' in the 'Encounter' section of the settings tab.
		showExecuteProportion: true,
	},

	presets: {
		// Preset talents that the user can quickly select.
		talents: [
			...Presets.TalentPresets[Phase.Phase2],
			...Presets.TalentPresets[Phase.Phase1],
		],
		// Preset rotations that the user can quickly select.
		rotations: [
			...Presets.APLPresets[Phase.Phase2],
			...Presets.APLPresets[Phase.Phase1],
		],
		// Preset gear configurations that the user can quickly select.
		gear: [
			...Presets.GearPresets[Phase.Phase2],
			...Presets.GearPresets[Phase.Phase1],
		],
	},

	autoRotation: player => {
		return Presets.DefaultAPLs[player.getLevel()][player.getTalentTree()].rotation.rotation!;
	},

	raidSimPresets: [
		{
			spec: Spec.SpecWarrior,
			tooltip: 'Arms Warrior',
			defaultName: 'Arms',
			iconUrl: getSpecIcon(Class.ClassWarrior, 0),

			talents: Presets.DefaultTalentsPhase2Arms.data,
			specOptions: Presets.DefaultOptions,
			consumes: Presets.DefaultConsumes,
			defaultFactionRaces: {
				[Faction.Unknown]: Race.RaceUnknown,
				[Faction.Alliance]: Race.RaceHuman,
				[Faction.Horde]: Race.RaceOrc,
			},
			defaultGear: {
				[Faction.Unknown]: {},
				[Faction.Alliance]: {
					1: Presets.GearPresets[Phase.Phase1][0].gear,
					2: Presets.GearPresets[Phase.Phase2][0].gear,
				},
				[Faction.Horde]: {
					1: Presets.GearPresets[Phase.Phase1][0].gear,
					2: Presets.GearPresets[Phase.Phase2][0].gear,
				},
			},
		},
		{
			spec: Spec.SpecWarrior,
			tooltip: 'Fury Warrior',
			defaultName: 'Fury',
			iconUrl: getSpecIcon(Class.ClassWarrior, 1),

			talents: Presets.DefaultTalentsPhase2Fury.data,
			specOptions: Presets.DefaultOptions,
			consumes: Presets.DefaultConsumes,
			defaultFactionRaces: {
				[Faction.Unknown]: Race.RaceUnknown,
				[Faction.Alliance]: Race.RaceHuman,
				[Faction.Horde]: Race.RaceOrc,
			},
			defaultGear: {
				[Faction.Unknown]: {},
				[Faction.Alliance]: {
					1: Presets.GearPresets[Phase.Phase1][1].gear,
					2: Presets.GearPresets[Phase.Phase2][1].gear,
				},
				[Faction.Horde]: {
					1: Presets.GearPresets[Phase.Phase1][1].gear,
					2: Presets.GearPresets[Phase.Phase2][1].gear,

				},
			},
		},
	],
});

export class WarriorSimUI extends IndividualSimUI<Spec.SpecWarrior> {
	constructor(parentElem: HTMLElement, player: Player<Spec.SpecWarrior>) {
		super(parentElem, player, SPEC_CONFIG);
	}
}
