## Represets a status effect that does something overtime, such as heal/damage.
class_name TickSED extends StatusEffectDefinition

@export var is_dot: bool = false

func trigger(target: Combatant) -> void:
	var amount: int = mod.get_value()
	match mod.stat_changing:
		StatHelper.StatTypes.CurrentHP:
			if is_dot == true:
				target.stats.take_damage(_to_damage_data())
			else:
				target.stats.heal(amount)
