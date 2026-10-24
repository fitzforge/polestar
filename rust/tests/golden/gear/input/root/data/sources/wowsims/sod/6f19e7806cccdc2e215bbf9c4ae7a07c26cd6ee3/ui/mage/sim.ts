import * as OtherInputs from '../core/components/other_inputs.js';
import { Phase } from '../core/constants/other.js';
import { IndividualSimUI, registerSpecConfig } from '../core/individual_sim_ui.js';
import { Player } from '../core/player.js';
import { Class, Faction, ItemSlot, PartyBuffs, Race, Spec, Stat } from '../core/proto/common.js';
import { MageRune } from '../core/proto/mage.js';
import { Stats } from '../core/proto_utils/stats.js';
import { getSpecIcon } from '../core/proto_utils/utils.js';
import * as MageInputs from './inputs.js';
import * as Presets from './presets.js';

const SPEC_CONFIG = registerSpecConfig(Spec.SpecMage, {
	cssClass: 'mage-sim-ui',
	cssScheme: 'mage',
	// List any known bugs / issues here and they'll be shown on the site.
	knownIssues: [],

	// All stats for which EP should be calculated.
	epStats: [
		Stat.StatIntellect,
		Stat.StatSpellPower,
		Stat.StatArcanePower,
		Stat.StatFirePower,
		Stat.StatFrostPower,
		Stat.StatSpellHit,
		Stat.StatSpellCrit,
		Stat.StatSpellHaste,
		Stat.StatMP5,
	],
	// Reference stat against which to calculate EP. I think all classes use either spell power or attack power.
	epReferenceStat: Stat.StatSpellPower,
	// Which stats to display in the Character Stats section, at the bottom of the left-hand sidebar.
	displayStats: [
		Stat.StatHealth,
		Stat.StatMana,
		Stat.StatStamina,
		Stat.StatIntellect,
		Stat.StatSpellPower,
		Stat.StatArcanePower,
		Stat.StatFirePower,
		Stat.StatFrostPower,
		Stat.StatSpellHit,
		Stat.StatSpellCrit,
		Stat.StatSpellHaste,
		Stat.StatMP5,
	],
	defaults: {
		// Default equipped gear.
		gear: Presets.DefaultGear.gear,
		// Default EP weights for sorting gear in the gear picker.
		epWeights: Stats.fromMap({
			[Stat.StatIntellect]: 0.2,
			[Stat.StatSpellPower]: 1,
			[Stat.StatArcanePower]: 1,
			[Stat.StatFirePower]: 1,
			[Stat.StatFrostPower]: 1,
			// Aggregated across 3 builds
			[Stat.StatSpellHit]: 5.0,
			[Stat.StatSpellCrit]: 6.17,
			[Stat.StatSpellHaste]: 3.0,
			[Stat.StatMP5]: 0.09,
		}),
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
	encounterPicker: {
		// Whether to include 'Execute Duration (%)' in the 'Encounter' section of the settings tab.
		showExecuteProportion: false,
	},

	presets: {
		// Preset rotations that the user can quickly select.
		rotations: [...Presets.APLPresets[Phase.Phase2], ...Presets.APLPresets[Phase.Phase1]],
		// Preset talents that the user can quickly select.
		talents: [...Presets.TalentPresets[Phase.Phase2], ...Presets.TalentPresets[Phase.Phase1]],
		// Preset gear configurations that the user can quickly select.
		gear: [...Presets.GearPresets[Phase.Phase2], ...Presets.GearPresets[Phase.Phase1]],
		builds: [Presets.PresetBuildArcane, Presets.PresetBuildFire, Presets.PresetBuildFrostfire],
	},

	autoRotation: player => {
		const specNumber = player.getTalentTree();
		const frostfireBoltEquipped = player.getEquippedItem(ItemSlot.ItemSlotWaist)?.rune?.id == MageRune.RuneBeltFrostfireBolt;

		if (specNumber == 0 || (specNumber == 1 && !frostfireBoltEquipped)) {
			// Prio standard arcane, standard fire only if not using FFB
			return Presets.DefaultAPLs[player.getLevel()][specNumber].rotation.rotation!;
		} else if (frostfireBoltEquipped) {
			// Prio FFB over Frost when FFB rune is equipped
			return Presets.DefaultAPLs[player.getLevel()][3].rotation.rotation!;
		} else {
			// Frost
			return Presets.DefaultAPLs[player.getLevel()][specNumber].rotation.rotation!;
		}
	},

	raidSimPresets: [
		{
			spec: Spec.SpecMage,
			tooltip: 'Arcane Mage',
			defaultName: 'Arcane',
			iconUrl: getSpecIcon(Class.ClassMage, 0),

			talents: Presets.DefaultTalentsArcane.data,
			specOptions: Presets.DefaultOptions,
			consumes: Presets.DefaultConsumes,
			otherDefaults: Presets.OtherDefaults,
			defaultFactionRaces: {
				[Faction.Unknown]: Race.RaceUnknown,
				[Faction.Alliance]: Race.RaceGnome,
				[Faction.Horde]: Race.RaceTroll,
			},
			defaultGear: {
				[Faction.Unknown]: {},
				[Faction.Alliance]: {
					1: Presets.GearPresets[Phase.Phase1][0].gear,
				},
				[Faction.Horde]: {
					1: Presets.GearPresets[Phase.Phase1][0].gear,
				},
			},
		},
		{
			spec: Spec.SpecMage,
			tooltip: 'Fire Mage',
			defaultName: 'Fire',
			iconUrl: getSpecIcon(Class.ClassMage, 1),

			talents: Presets.DefaultTalentsFire.data,
			specOptions: Presets.DefaultOptions,
			consumes: Presets.DefaultConsumes,
			otherDefaults: Presets.OtherDefaults,
			defaultFactionRaces: {
				[Faction.Unknown]: Race.RaceUnknown,
				[Faction.Alliance]: Race.RaceGnome,
				[Faction.Horde]: Race.RaceTroll,
			},
			defaultGear: {
				[Faction.Unknown]: {},
				[Faction.Alliance]: {
					1: Presets.GearPresets[Phase.Phase1][1].gear,
				},
				[Faction.Horde]: {
					1: Presets.GearPresets[Phase.Phase1][1].gear,
				},
			},
		},
		{
			spec: Spec.SpecMage,
			tooltip: 'Frost Mage',
			defaultName: 'Frost',
			iconUrl: getSpecIcon(Class.ClassMage, 2),

			talents: Presets.DefaultTalentsFrostfire.data,
			specOptions: Presets.DefaultOptions,
			consumes: Presets.DefaultConsumes,
			otherDefaults: Presets.OtherDefaults,
			defaultFactionRaces: {
				[Faction.Unknown]: Race.RaceUnknown,
				[Faction.Alliance]: Race.RaceGnome,
				[Faction.Horde]: Race.RaceTroll,
			},
			defaultGear: {
				[Faction.Unknown]: {},
				[Faction.Alliance]: {
					1: Presets.GearPresets[Phase.Phase1][2].gear,
				},
				[Faction.Horde]: {
					1: Presets.GearPresets[Phase.Phase1][2].gear,
				},
			},
		},
	],
});

export class MageSimUI extends IndividualSimUI<Spec.SpecMage> {
	constructor(parentElem: HTMLElement, player: Player<Spec.SpecMage>) {
		super(parentElem, player, SPEC_CONFIG);
	}
}
