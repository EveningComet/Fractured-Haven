@abstract
## Defines what a [SkillData] object does.
class_name SkillEffect extends Resource

@export_category("Base Info")
## Based on the stat being scaled, how much damage, healing, etc. to perform.
@export var power_scale: float = 1.0

## What is the base chance for this effect to succeed against a target?
@export_range(0.0, 100.0) var success_rate: float = 90.0

## What stat does this use? Used as an enum to allow for easily selecting what
## stat to use.
@export var stat_used: StatHelper.StatTypes = StatHelper.StatTypes.Technique

@abstract func execute(targeting_data: TargetingData) -> void

func _get_power(stats: CharacterStats):
	return floor( Formulas.get_calculated_value(stat_used, stats) * power_scale )

func _is_successful(activator: CharacterStats, receiver: CharacterStats) -> bool:
		var chance:     float = Formulas.calculate_chance_to_hit()
		var prediction: float = Formulas.predict_success_chance(
			success_rate,
			activator,
			receiver
		)
		return chance <= prediction
