## Stores various calculations.
class_name Formulas extends Node

## The [SkillData.base_activation_time] can never be less than this value.
const MIN_SKILL_ACTIVATION_TIME: float = 0.0

const MIN_CRIT_CHANCE: float = 5.0

static func get_activation_time(skill_data: SkillData, stats: CharacterStats) -> float:
	var cunning_stat_val: float = float(get_calculated_value(StatHelper.StatTypes.Cunning, stats))
	var activation_time:  float = (skill_data.base_activation_time - cunning_stat_val) / 100.0
	return max(MIN_SKILL_ACTIVATION_TIME, activation_time)

static func calculate_chance_to_hit() -> float:
	randomize() # TODO: Setting a static seed to prevent cheesing/cheating?
	var rng = randf() * 100.0
	return rng

static func predict_success_chance(
	chance: float, 
	attacker: CharacterStats,
	defender: CharacterStats
) -> float:
	var attacker_perception: float = get_calculated_value(StatHelper.StatTypes.Perception, attacker)
	var defender_evasion:    float = get_calculated_value(StatHelper.StatTypes.Agility, defender)
	var prediction:          float = chance + (attacker_perception - defender_evasion)
	return prediction

static func get_calculated_value(stat_used: StatHelper.StatTypes, stats: CharacterStats) -> float:
	match stat_used:
		_:
			return stats.stats[stat_used].get_calculated_value()

static func get_max_hp_value(stats: CharacterStats) -> int:
	return floor(stats.stats[StatHelper.StatTypes.MaxHP].get_calculated_value())

static func get_max_sp_value(stats: CharacterStats) -> int:
	return floor(stats.stats[StatHelper.StatTypes.MaxSP].get_calculated_value())

## Return a float percentage for damage resistance.
static func get_resistance(stats: CharacterStats, damage_type: StatHelper.DamageTypes) -> float:
	if StatHelper.damage_to_res_map.has(damage_type) == true:
		return stats.stats[StatHelper.damage_to_res_map[damage_type]].get_calculated_value()
	return 0.0
