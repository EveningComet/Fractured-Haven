## Stores various calculations.
class_name Formulas extends Node

const MAX_ATTACK_RATE: float = 10.00
const MIN_ATTACK_RATE: float = 0.20

static func get_max_hp_value(stats: CharacterStats) -> int:
	return floor(stats.stats[StatHelper.StatTypes.MaxHP].get_calculated_value())

static func get_max_sp_value(stats: CharacterStats) -> int:
	return floor(stats.stats[StatHelper.StatTypes.MaxSP].get_calculated_value())

## Return a float percentage for damage resistance.
static func get_resistance(stats: CharacterStats, damage_type: StatHelper.DamageTypes) -> float:
	if StatHelper.damage_to_res_map.has(damage_type) == true:
		return stats.stats[StatHelper.damage_to_res_map[damage_type]].get_calculated_value()
	return 0.0
