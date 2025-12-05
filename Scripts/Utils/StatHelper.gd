## A class that stores variables related to different types of stats.
class_name StatHelper

## Used to assist with accessing stats easily.
enum StatTypes {
	# Attributes/ Core Stats
	MaxHP,                # Max hit points
	CurrentHP,            # Current hit points
	MaxSP,                # Max special points
	CurrentSP,            # Current special points
	Technique,            # Physical power
	Will,                 # Special power
	Toughness,            # Defense, lowers all non-elemental/typed damage
	Agility,              # Evasion
	Cunning,              # Attack rate/activation/cast time
	Perception,           # Chance to hit
	
	MoveSpeed,
	
	# Other stats
	CriticalHitChance,
	HealingReceivedScaler,
	
	## Effects how much stronger buffs are. Should be 1.00 by default.
	BuffPotency,
	
	## Effects how much stronger debuffs are. Should be 1.00 by default.
	DebuffPotency,
	
	HeatMods,
	ColdMods,
	ElectricityMods,
	PsychicMods,
	
	# Resistances (Damage Type)
	HeatRes,
	ColdRes,
	ElectricityRes,
	PsychicRes,
	
	# Resistances (Status Effects)
	# Percentage based (0.0-1.0)
	PlaguedRes
}

## The different types of damage.
enum DamageTypes {
	Base,
	Heat,
	Cold,
	Electricity,
	Psychic,
	True ## Ignores resistance.
}

## Easy accessor for returning the resistance for damage types.
static var damage_to_res_map: Dictionary = {
	DamageTypes.Base: StatTypes.Toughness,
	DamageTypes.Heat: StatTypes.HeatRes,
	DamageTypes.Cold: StatTypes.ColdRes,
	DamageTypes.Electricity: StatTypes.ElectricityRes,
	DamageTypes.Psychic: StatTypes.PsychicRes
}
