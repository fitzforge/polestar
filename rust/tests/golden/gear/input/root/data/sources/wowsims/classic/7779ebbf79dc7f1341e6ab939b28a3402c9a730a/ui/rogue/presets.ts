import { Phase } from '../core/constants/other.js';
import * as PresetUtils from '../core/preset_utils.js';
import {
	AgilityElixir,
	AttackPowerBuff,
	Conjured,
	Consumes,
	Debuffs,
	Flask,
	Food,
	IndividualBuffs,
	Profession,
	RaidBuffs,
	SaygesFortune,
	SpellPowerBuff,
	StrengthBuff,
	TristateEffect,
	WeaponImbue,
	ZanzaBuff,
	SapperExplosive,
} from '../core/proto/common.js';
import { RogueOptions } from '../core/proto/rogue.js';
import { SavedTalents } from '../core/proto/ui.js';
import BackstabAPL from './apls/combat_backstab.apl.json';
import BackstabSweatyAPL from './apls/combat_backstab_sweaty.apl.json';
import SinisterStrikeAPL from './apls/combat_sinister_strike.apl.json';
import SinisterStrikeSweatyAPL from './apls/combat_sinister_strike_sweaty.apl.json';
import SinisterStrikeIEAAPL from './apls/combat_sinister_strike_iea.apl.json';
import BlankGear from './gear_sets/blank.gear.json';
import BackstabGearPreBiS from './gear_sets/combat_backstab_prebis.gear.json';
import SinisterStrikeGearPreBiS from './gear_sets/combat_sinister_strike_prebis.gear.json';
import BackstabGearP1BiS from './gear_sets/combat_backstab_p1_bis.gear.json';
import BackstabGearP2BiS from './gear_sets/combat_backstab_p2_bis.gear.json';
import SinisterStrikeGearP1BiS from './gear_sets/combat_sinister_strike_p1_bis.gear.json';
import SinisterStrikeGearP2BiS from './gear_sets/combat_sinister_strike_p2_bis.gear.json';

// Preset options for this spec.
// Eventually we will import these values for the raid sim too, so its good to
// keep them in a separate file.

///////////////////////////////////////////////////////////////////////////
//                                 Gear Presets
///////////////////////////////////////////////////////////////////////////

export const GearBlank = PresetUtils.makePresetGear('Blank', BlankGear);
export const GearBackstabPreBiS = PresetUtils.makePresetGear('Backstab Pre-BiS', BackstabGearPreBiS);
export const GearSinisterStrikePreBiS = PresetUtils.makePresetGear('Sinister Strike Pre-BiS', SinisterStrikeGearPreBiS);
export const GearBackstabP1BiS = PresetUtils.makePresetGear('Backstab P1 BiS', BackstabGearP1BiS);
export const GearBackstabP2BiS = PresetUtils.makePresetGear('Backstab P2 BiS', BackstabGearP2BiS);
export const GearSinisterStrikeP1BiS = PresetUtils.makePresetGear('Sinister Strike P1 BiS', SinisterStrikeGearP1BiS);
export const GearSinisterStrikeP2BiS = PresetUtils.makePresetGear('Sinister Strike P2 BiS', SinisterStrikeGearP2BiS);

export const GearPresets = {
	[Phase.Phase1]: [GearBackstabPreBiS, GearSinisterStrikePreBiS, GearBackstabP1BiS, GearSinisterStrikeP1BiS],
	[Phase.Phase2]: [GearBackstabPreBiS, GearSinisterStrikePreBiS, GearBackstabP2BiS, GearSinisterStrikeP2BiS],
};

export const DefaultGear = GearSinisterStrikePreBiS;

///////////////////////////////////////////////////////////////////////////
//                                 APL Presets[]
///////////////////////////////////////////////////////////////////////////

export const ROTATION_PRESET_BACKSTAB = PresetUtils.makePresetAPLRotation('Backstab', BackstabAPL, {});
export const ROTATION_PRESET_SINISTER_STRIKE = PresetUtils.makePresetAPLRotation('Sinister Strike', SinisterStrikeAPL, {});
export const ROTATION_PRESET_BACKSTAB_SWEATY = PresetUtils.makePresetAPLRotation('Backstab (Sweaty)', BackstabSweatyAPL, {});
export const ROTATION_PRESET_SINISTER_STRIKE_SWEATY = PresetUtils.makePresetAPLRotation('Sinister Strike (Sweaty)', SinisterStrikeSweatyAPL, {});
export const ROTATION_PRESET_SINISTER_STRIKE_IEA = PresetUtils.makePresetAPLRotation('Improved Expose Armor (SS)', SinisterStrikeIEAAPL, {});

export const APLPresets = {
	[Phase.Phase1]: [ROTATION_PRESET_BACKSTAB, ROTATION_PRESET_SINISTER_STRIKE, ROTATION_PRESET_BACKSTAB_SWEATY, ROTATION_PRESET_SINISTER_STRIKE_SWEATY, ROTATION_PRESET_SINISTER_STRIKE_IEA],
	[Phase.Phase2]: [ROTATION_PRESET_BACKSTAB, ROTATION_PRESET_SINISTER_STRIKE, ROTATION_PRESET_BACKSTAB_SWEATY, ROTATION_PRESET_SINISTER_STRIKE_SWEATY, ROTATION_PRESET_SINISTER_STRIKE_IEA],
};

//Need to add main hand equip logic or talent/rotation logic to map to Auto APL
export const DefaultAPLs: Record<number, PresetUtils.PresetRotation> = {
	[0]: ROTATION_PRESET_SINISTER_STRIKE,
	[1]: ROTATION_PRESET_BACKSTAB,
};

export const DefaultAPLBackstab = APLPresets[Phase.Phase2][0];
export const DefaultAPLSinisterStrike = APLPresets[Phase.Phase2][1];
export const DefaultAPLIEA = APLPresets[Phase.Phase2][4];

///////////////////////////////////////////////////////////////////////////
//                                 Talent Presets
///////////////////////////////////////////////////////////////////////////

// Default talents. Uses the wowhead calculator format, make the talents on
// https://wowhead.com/classic/talent-calc and copy the numbers in the url.

// Preset name must be unique. Ex: 'Backstab DPS' cannot be used as a name more than once

export const CombatBackstabTalents = PresetUtils.makePresetTalents(
	'Backstab',
	SavedTalents.create({ talentsString: '005023104-0233050020550100221-05' }),
);
export const CombatSinisterStrikeTalents = PresetUtils.makePresetTalents('Sinister Strike', SavedTalents.create({ talentsString: '005323105-0240052020050150231' }));
export const CombatSinisterStrikeIEATalents = PresetUtils.makePresetTalents('Improved Expose Armor (SS)', SavedTalents.create({ talentsString: '005323123-0240052020050150231' }));

export const TalentPresets = {
	[Phase.Phase1]: [CombatBackstabTalents, CombatSinisterStrikeTalents, CombatSinisterStrikeIEATalents],
	[Phase.Phase2]: [CombatBackstabTalents, CombatSinisterStrikeTalents, CombatSinisterStrikeIEATalents],
};

export const DefaultTalentsAssassin = TalentPresets[Phase.Phase2][0];
export const DefaultTalentsCombat = TalentPresets[Phase.Phase2][0];
export const DefaultTalentsSubtlety = TalentPresets[Phase.Phase2][0];

export const DefaultTalentsBackstab = TalentPresets[Phase.Phase2][0];
export const DefaultTalentsSinisterStrike = TalentPresets[Phase.Phase2][1];
export const DefaultTalentsIEA = TalentPresets[Phase.Phase2][2];

export const DefaultTalents = DefaultTalentsSinisterStrike;

///////////////////////////////////////////////////////////////////////////
//                                Build Presets
///////////////////////////////////////////////////////////////////////////
export const PresetBuildBackstab = PresetUtils.makePresetBuild('Backstab', {
	gear: GearBackstabP2BiS,
	talents: DefaultTalentsBackstab,
	rotation: DefaultAPLBackstab,
});
export const PresetBuildSinisterStrike = PresetUtils.makePresetBuild('Sinister Strike', {
	gear: GearSinisterStrikeP2BiS,
	talents: DefaultTalentsSinisterStrike,
	rotation: DefaultAPLSinisterStrike,
});
export const PresetBuildIEA = PresetUtils.makePresetBuild('IEA', {
	gear: GearSinisterStrikeP2BiS,
	talents: DefaultTalentsIEA,
	rotation: DefaultAPLIEA,
});

///////////////////////////////////////////////////////////////////////////
//                                 Options
///////////////////////////////////////////////////////////////////////////

export const DefaultOptions = RogueOptions.create({});

///////////////////////////////////////////////////////////////////////////
//                         Consumes/Buffs/Debuffs
///////////////////////////////////////////////////////////////////////////

export const P1Consumes = Consumes.create({
	agilityElixir: AgilityElixir.ElixirOfTheMongoose,
	attackPowerBuff: AttackPowerBuff.JujuMight,
	defaultConjured: Conjured.ConjuredRogueThistleTea,
	dragonBreathChili: true,
	flask: Flask.FlaskOfSupremePower,
	food: Food.FoodGrilledSquid,
	mainHandImbue: WeaponImbue.InstantPoison,
	offHandImbue: WeaponImbue.DeadlyPoison,
	spellPowerBuff: SpellPowerBuff.GreaterArcaneElixir,
	strengthBuff: StrengthBuff.JujuPower,
	zanzaBuff: ZanzaBuff.GroundScorpokAssay,
	sapperExplosive: SapperExplosive.SapperGoblinSapper,
});

export const DefaultConsumes = {
	[Phase.Phase1]: P1Consumes,
};

export const P1RaidBuffs = RaidBuffs.create({
	battleShout: TristateEffect.TristateEffectImproved,
	fireResistanceAura: true,
	fireResistanceTotem: true,
	giftOfTheWild: TristateEffect.TristateEffectImproved,
	strengthOfEarthTotem: TristateEffect.TristateEffectImproved,
	graceOfAirTotem: TristateEffect.TristateEffectImproved,
	leaderOfThePack: true,
	trueshotAura: true, 
});

export const DefaultRaidBuffs = {
	[Phase.Phase1]: P1RaidBuffs,
};

export const P1IndividualBuffs = IndividualBuffs.create({
	blessingOfKings: true,
	blessingOfMight: TristateEffect.TristateEffectImproved,
	fengusFerocity: true,
	rallyingCryOfTheDragonslayer: true,
	//saygesFortune: SaygesFortune.SaygesDamage,
	slipkiksSavvy: true,
	songflowerSerenade: true,
	spiritOfZandalar: false,
	warchiefsBlessing: true,
});

export const DefaultIndividualBuffs = {
	[Phase.Phase1]: P1IndividualBuffs,
};

export const P1DefaultDebuffs = Debuffs.create({
	curseOfRecklessness: true,
	faerieFire: true,
	improvedScorch: true,
	sunderArmor: true,
});

export const DefaultDebuffs = {
	[Phase.Phase1]: P1DefaultDebuffs,
};

export const P1OtherDefaults = {
	profession1: Profession.Engineering,
	profession2: Profession.ProfessionUnknown,
};

export const OtherDefaults = {
	[Phase.Phase1]: P1OtherDefaults,
};
