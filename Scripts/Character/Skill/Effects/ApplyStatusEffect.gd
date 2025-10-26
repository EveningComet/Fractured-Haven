class_name ApplyStatusEffect extends SkillEffect

@export var status_to_apply: StatusEffect

func execute(targeting_data: TargetingData) -> void:
	for u: Actor in targeting_data.units:
		u.combatant.character_data.status_effect_holder.add_status(status_to_apply)
