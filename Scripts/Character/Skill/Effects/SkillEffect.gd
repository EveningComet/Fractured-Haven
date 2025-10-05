@abstract
## Defines what a [SkillData] object does.
class_name SkillEffect extends Resource

@export_category("Base Info")
## Based on the stat being scaled, how much damage, healing, etc. to perform.
@export var power_scale: float = 1.0

## What stat does this use? Used as an enum to allow for easily selecting what
## stat to use.
@export var stat_used: StatHelper.StatTypes = StatHelper.StatTypes.Technique

func execute(targeting_data: TargetingData) -> void:
	pass

func _get_power(stats: CharacterStats):
	return floor( Formulas.get_calculated_value(stat_used, stats) * power_scale )
