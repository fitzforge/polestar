import * as OtherInputs from '../core/components/other_inputs.js';
import { SPELL_HIT_RATING_PER_HIT_CHANCE } from '../core/constants/mechanics';
import { Phase } from '../core/constants/other.js';
import { IndividualSimUI, registerSpecConfig } from '../core/individual_sim_ui.js';
import { Player } from '../core/player.js';
import { ItemSlot, PseudoStat, Spec, Stat } from '../core/proto/common.js';
import { Stats } from '../core/proto_utils/stats.js';
import { SpecOptions } from '../core/proto_utils/utils.js';
import * as MageInputs from './inputs.js';
import * as Presets from './presets.js';

const SPEC_CONFIG = registerSpecConfig(Spec.SpecMage, {
	cssClass: 'mage-sim-ui',
	cssScheme: 'mage',
	// List any known bugs / issues here and they'll be shown on the site.
	knownIssues: [],

	// All stats for which EP should be calculated.
	epStats: [
		// Attributes
		Stat.StatIntellect,
		Stat.StatSpirit,
		// Spell
		Stat.StatSpellPower,
		Stat.StatSpellDamage,
		Stat.StatArcanePower,
		Stat.StatFirePower,
		Stat.StatFrostPower,
		Stat.StatSpellHit,
		Stat.StatSpellCrit,
		Stat.StatMP5,
	],
	epPseudoStats: [PseudoStat.PseudoStatCastSpeedMultiplier],
	// Reference stat against which to calculate EP. I think all classes use either spell power or attack power.
	epReferenceStat: Stat.StatSpellDamage,
	// Which stats to display in the Character Stats section, at the bottom of the left-hand sidebar.
	displayStats: [
		// Primary
		Stat.StatMana,
		// Attributes
		Stat.StatIntellect,
		Stat.StatSpirit,
		// Spell
		Stat.StatSpellDamage,
		Stat.StatArcanePower,
		Stat.StatFirePower,
		Stat.StatFrostPower,
		Stat.StatHealingPower,
		Stat.StatSpellHit,
		Stat.StatSpellCrit,
		Stat.StatMP5,
	],
	displayPseudoStats: [PseudoStat.PseudoStatCastSpeedMultiplier],

	defaults: {
		// Default equipped gear.
		gear: Presets.DefaultBuild.gear!.gear,
		// Default EP weights for sorting gear in the gear picker.
		epWeights: Stats.fromMap(
			{
				[Stat.StatIntellect]: 0.49,
				[Stat.StatSpellPower]: 1,
				[Stat.StatSpellDamage]: 1,
				[Stat.StatArcanePower]: 1,
				[Stat.StatFirePower]: 1,
				[Stat.StatFrostPower]: 1,
				// Aggregated across 3 builds
				[Stat.StatSpellHit]: 18.59,
				[Stat.StatSpellCrit]: 13.91,
				[Stat.StatMP5]: 0.11,
				[Stat.StatFireResistance]: 0.5,
			},
			{
				[PseudoStat.PseudoStatCastSpeedMultiplier]: 10.3,
				[PseudoStat.PseudoStatTimewornBonus]: 20.27,
			},
		),
		// Default consumes settings.
		consumes: Presets.DefaultBuild.settings!.consumes!,
		// Default talents.
		talents: Presets.DefaultBuild.talents!.data,
		// Default spec-specific settings.
		specOptions: Presets.DefaultBuild.settings!.specOptions! as SpecOptions<Spec.SpecMage>,
		other: {
			// Default distance from target.
			distanceFromTarget: Presets.DefaultBuild.settings?.playerOptions?.distanceFromTarget,
			profession1: Presets.DefaultBuild.settings?.playerOptions?.profession1,
			profession2: Presets.DefaultBuild.settings?.playerOptions?.profession2,
		},
		// Default raid/party buffs settings.
		raidBuffs: Presets.DefaultBuild.settings!.raidBuffs!,
		partyBuffs: Presets.DefaultBuild.settings!.partyBuffs!,
		individualBuffs: Presets.DefaultBuild.settings!.buffs!,
		debuffs: Presets.DefaultBuild.settings!.debuffs!,
	},

	modifyDisplayStats: (player: Player<Spec.SpecMage>) => {
		let stats = new Stats();
		stats = stats.addPseudoStat(PseudoStat.PseudoStatSchoolHitArcane, player.getTalents().arcaneFocus * 2 * SPELL_HIT_RATING_PER_HIT_CHANCE);
		stats = stats.addPseudoStat(PseudoStat.PseudoStatSchoolHitFire, player.getTalents().elementalPrecision * 2 * SPELL_HIT_RATING_PER_HIT_CHANCE);
		stats = stats.addPseudoStat(PseudoStat.PseudoStatSchoolHitFrost, player.getTalents().elementalPrecision * 2 * SPELL_HIT_RATING_PER_HIT_CHANCE);

		return {
			talents: stats,
		};
	},

	// IconInputs to include in the 'Player' section on the settings tab.
	playerIconInputs: [MageInputs.Armor],
	// Inputs to include in the 'Rotation' section on the settings tab.
	rotationInputs: MageInputs.MageRotationConfig,
	// Buff and Debuff inputs to include/exclude, overriding the EP-based defaults.
	includeBuffDebuffInputs: [],
	excludeBuffDebuffInputs: [],
	// Inputs to include in the 'Other' section on the settings tab.
	otherInputs: {
		inputs: [OtherInputs.DistanceFromTarget, OtherInputs.TankAssignment],
	},
	itemSwapSlots: [ItemSlot.ItemSlotMainHand, ItemSlot.ItemSlotOffHand],
	encounterPicker: {
		// Whether to include 'Execute Duration (%)' in the 'Encounter' section of the settings tab.
		showExecuteProportion: false,
	},

	presets: {
		rotations: [
			...Presets.APLPresets[Phase.Phase7],
			...Presets.APLPresets[Phase.Phase6],
			...Presets.APLPresets[Phase.Phase5],
			...Presets.APLPresets[Phase.Phase4],
			...Presets.APLPresets[Phase.Phase3],
			...Presets.APLPresets[Phase.Phase2],
			...Presets.APLPresets[Phase.Phase1],
		],
		talents: [
			...Presets.TalentPresets[Phase.Phase7],
			...Presets.TalentPresets[Phase.Phase6],
			...Presets.TalentPresets[Phase.Phase5],
			...Presets.TalentPresets[Phase.Phase4],
			...Presets.TalentPresets[Phase.Phase3],
			...Presets.TalentPresets[Phase.Phase2],
			...Presets.TalentPresets[Phase.Phase1],
		],
		gear: [
			...Presets.GearPresets[Phase.Phase7],
			...Presets.GearPresets[Phase.Phase6],
			...Presets.GearPresets[Phase.Phase5],
			...Presets.GearPresets[Phase.Phase4],
			...Presets.GearPresets[Phase.Phase3],
			...Presets.GearPresets[Phase.Phase2],
			...Presets.GearPresets[Phase.Phase1],
		],
		builds: [Presets.PresetBuildFirePhase7, Presets.PresetBuildFrostPhase7, Presets.PresetBuildFirePhase6, Presets.PresetBuildFrostPhase6],
	},

	autoRotation: player => {
		const specNumber = player.getTalentTree();
		const level = player.getLevel();

		return Presets.DefaultAPLs[level][specNumber].rotation.rotation!;
	},

	raidSimPresets: [],
});

export class MageSimUI extends IndividualSimUI<Spec.SpecMage> {
	constructor(parentElem: HTMLElement, player: Player<Spec.SpecMage>) {
		super(parentElem, player, SPEC_CONFIG);
	}
}
