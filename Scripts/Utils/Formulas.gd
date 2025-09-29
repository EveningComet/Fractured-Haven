## Stores various calculations.
class_name Formulas extends Node

const MAX_ATTACK_RATE: float = 10.00
const MIN_ATTACK_RATE: float = 0.20

static func get_max_hp_value(stats: CharacterStats) -> int:
	var sum: int = 0
	for attribute: StatHelper.StatTypes in StatHelper.physical_attributes:
		sum += stats.stats[attribute].get_calculated_value()
	return sum

static func get_max_sp_value(stats: CharacterStats) -> int:
	var sum: int = 0
	for attribute in StatHelper.mental_attributes:
		sum += stats.stats[attribute].get_calculated_value()
	return sum

## Return a float percentage for damage resistance.
static func get_resistance(stats: CharacterStats, damage_type: StatHelper.DamageTypes) -> float:
	if StatHelper.damage_to_res_map.has(damage_type) == true:
		return stats.stats[StatHelper.damage_to_res_map[damage_type]].get_calculated_value()
	return 0.0
