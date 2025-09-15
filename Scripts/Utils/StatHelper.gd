## A class that stores variables related to different types of stats.
class_name StatHelper

## Used to assist with accessing stats easily.
enum StatTypes {
	# Attributes
	Fighting,
	Agility,
	Strength,
	Endurance,
	Reasoning,
	Intuition,
	Psyche,
	
	# Vitals
	MaxHP,                # Max hit points
	CurrentHP,            # Current hit points
	MaxSP,                # Our max mana/stamina/etc.
	CurrentSP,            # Our current mana/stamina/etc.
	
	MoveSpeed,
	
	# Derived stats
	CriticalHitChance,
	Evasion,
	Perception,
	
	PhysicalPower,
	SpecialPower,
	HeatMods,
	ColdMods,
	ElectricityMods,
	PsychicMods,
	
	# Resistances (Damage Type)
	# Except for regular damage, the rest are primarily percentage based (0.0-1.0)
	Defense,
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
	DamageTypes.Base: StatTypes.Defense,
	DamageTypes.Heat: StatTypes.HeatRes,
	DamageTypes.Cold: StatTypes.ColdRes,
	DamageTypes.Electricity: StatTypes.ElectricityRes,
	DamageTypes.Psychic: StatTypes.PsychicRes
}

static var physical_attributes: Array[StatTypes] = [
	StatTypes.Fighting,
	StatTypes.Agility,
	StatTypes.Strength,
	StatTypes.Endurance
]
