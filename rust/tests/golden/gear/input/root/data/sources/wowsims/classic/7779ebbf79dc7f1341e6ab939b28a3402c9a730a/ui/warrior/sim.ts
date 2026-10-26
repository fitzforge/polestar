import * as BuffDebuffInputs from '../core/components/inputs/buffs_debuffs';
import * as WarriorInputs from '../core/components/inputs/warrior_inputs';
import * as OtherInputs from '../core/components/other_inputs';
import { Phase } from '../core/constants/other';
import { IndividualSimUI, registerSpecConfig } from '../core/individual_sim_ui';
import { Player } from '../core/player';
import { Class, Faction, HandType, ItemSlot, PartyBuffs, PseudoStat, Race, Spec, Stat } from '../core/proto/common';
import { WarriorStance } from '../core/proto/warrior';
import { Stats } from '../core/proto_utils/stats';
import { getSpecIcon } from '../core/proto_utils/utils';
import * as Presets from './presets';

const SPEC_CONFIG = registerSpecConfig(Spec.SpecWarrior, {
	cssClass: 'warrior-sim-ui',
	cssScheme: 'warrior',
	// List any known bugs / issues here and they'll be shown on the site.
	knownIssues: [],

	// All stats for which EP should be calculated.
	epStats: [
		// Attributes
		Stat.StatStrength,
		Stat.StatAgility,
		// Physical
		Stat.StatAttackPower,
		Stat.StatMeleeHit,
		Stat.StatExpertise,
		Stat.StatMeleeCrit,
	],
	epPseudoStats: [PseudoStat.PseudoStatMainHandDps, PseudoStat.PseudoStatOffHandDps, PseudoStat.PseudoStatMeleeSpeedMultiplier],
	// Reference stat against which to calculate EP. I think all classes use either spell power or attack power.
	epReferenceStat: Stat.StatAttackPower,
	// Which stats to display in the Character Stats section, at the bottom of the left-hand sidebar.
	displayStats: [
		// Attributes
		Stat.StatStrength,
		Stat.StatAgility,
		// Physical
		Stat.StatAttackPower,
		Stat.StatMeleeHit,
		Stat.StatMeleeCrit,
		Stat.StatExpertise,
	],
	displayPseudoStats: [PseudoStat.PseudoStatMeleeSpeedMultiplier],

	defaults: {
		race: Presets.OtherDefaults.race,
		// Default equipped gear.
		gear: Presets.DefaultGear.gear,
		// Default EP weights for sorting gear in the gear picker.
		epWeights: Stats.fromMap(
			{
				[Stat.StatStrength]: 2.51,
				[Stat.StatAgility]: 1.86,
				[Stat.StatAttackPower]: 1,
				[Stat.StatMeleeHit]: 28.67,
				[Stat.StatMeleeCrit]: 25.1,
				[Stat.StatFireResistance]: 0.5,
			},
			{
				[PseudoStat.PseudoStatMainHandDps]: 11.92,
				[PseudoStat.PseudoStatOffHandDps]: 4.69,
				[PseudoStat.PseudoStatMeleeSpeedMultiplier]: 4.69,
			},
		),
		// Default consumes settings.
		consumes: Presets.DefaultConsumes,
		// Default talents.
		talents: Presets.DefaultTalents.data,
		// Default spec-specific settings.
		specOptions: Presets.DefaultOptions,
		other: Presets.OtherDefaults,
		// Default raid/party buffs settings.
		raidBuffs: Presets.DefaultRaidBuffs,
		partyBuffs: PartyBuffs.create({}),
		individualBuffs: Presets.DefaultIndividualBuffs,
		debuffs: Presets.DefaultDebuffs,
	},

	modifyDisplayStats: (player: Player<Spec.SpecWarrior>) => {
		let stats = new Stats();
		const stance = player.getSpecOptions().stance;
		if (stance === WarriorStance.WarriorStanceBerserker || (stance === WarriorStance.WarriorStanceNone && player.getTalentTree() === 1)) {
			stats = stats.addStat(Stat.StatMeleeCrit, 3);
		}

		return {
			buffs: stats,
		};
	},

	// IconInputs to include in the 'Player' section on the settings tab.
	playerIconInputs: [WarriorInputs.ShoutPicker<Spec.SpecWarrior>(), WarriorInputs.StancePicker<Spec.SpecWarrior>()],
	// Buff and Debuff inputs to include/exclude, overriding the EP-based defaults.
	includeBuffDebuffInputs: [BuffDebuffInputs.SpellScorchDebuff],
	excludeBuffDebuffInputs: [],
	// Inputs to include in the 'Other' section on the settings tab.
	otherInputs: {
		inputs: [
			WarriorInputs.StartingRage<Spec.SpecWarrior>(),
			WarriorInputs.QueueDelay<Spec.SpecWarrior>(),
			WarriorInputs.StanceSnapshot<Spec.SpecWarrior>(),
			OtherInputs.InFrontOfTarget,
		],
	},
	encounterPicker: {
		// Whether to include 'Execute Duration (%)' in the 'Encounter' section of the settings tab.
		showExecuteProportion: true,
	},

	presets: {
		// Preset talents that the user can quickly select.
		talents: [...Presets.TalentPresets[Phase.Phase1]],
		// Preset rotations that the user can quickly select.
		rotations: [...Presets.APLPresets[Phase.Phase1]],
		// Preset gear configurations that the user can quickly select.
		gear: [
			...Presets.GearPresets[Phase.Phase6],
			...Presets.GearPresets[Phase.Phase5],
			...Presets.GearPresets[Phase.Phase4],
			...Presets.GearPresets[Phase.Phase3],
			...Presets.GearPresets[Phase.Phase2],
			...Presets.GearPresets[Phase.Phase1],
		],
		// Preset builds that the user can quickly select.
		builds: [],
	},

	autoRotation: player => {
		const talentTree = player.getTalentTree();

		if (player.getEquippedItem(ItemSlot.ItemSlotMainHand)?._item.handType === HandType.HandTypeTwoHand) {
			return Presets.DefaultAPLs[0].rotation.rotation!;
		}

		return Presets.DefaultAPLs[0].rotation.rotation!;
	},

	raidSimPresets: [
		{
			spec: Spec.SpecWarrior,
			tooltip: 'DPS Warrior',
			defaultName: 'DPS',
			iconUrl: getSpecIcon(Class.ClassWarrior, 0),

			talents: Presets.DefaultTalents.data,
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
					1: Presets.DefaultGear.gear,
					2: Presets.DefaultGear.gear,
					3: Presets.DefaultGear.gear,
				},
				[Faction.Horde]: {
					1: Presets.DefaultGear.gear,
					2: Presets.DefaultGear.gear,
					3: Presets.DefaultGear.gear,
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
