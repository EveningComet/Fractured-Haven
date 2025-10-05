class_name HealSkillEffect extends SkillEffect

func execute(targeting_data: TargetingData) -> void:
	for t: Actor in targeting_data.targets:
		var healing_power: int = _get_power(targeting_data.user.stats)
		t.combatant.character_data.stats.heal(healing_power)
