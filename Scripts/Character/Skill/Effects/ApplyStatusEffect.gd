class_name ApplyStatusEffect extends SkillEffect

@export var status_to_apply: StatusEffect

func execute(targeting_data: TargetingData) -> void:
	for u: Actor in targeting_data.units:
		pass
