## For skills that should deal damage.
class_name DamageSkillEffect extends SkillEffect

@export_category("Damage Data")
## Dictates what type of damage this skill does.
@export var damage_type: StatHelper.DamageTypes = StatHelper.DamageTypes.Base

## If the target has at least one debuff applied to them, how much extra damage
## should be applied?
@export var bonus_damage_scale_on_debuffs_present: float = 0.0

## Scales the percentage of damage that should be healed for the attacker.
@export_range(0.0, 1.0) var lifesteal_percentage: float = 0.0

func execute(targeting_data: TargetingData) -> void:
	var user_stats: CharacterStats = targeting_data.user.combatant.character_data.stats
	for u: Actor in targeting_data.units:
		var target_stats: CharacterStats = u.combatant.character_data.stats
		var dd: DamageData = DamageData.new()
		dd.damage_amount        = _get_power(user_stats)
		dd.status_damage_scaler = bonus_damage_scale_on_debuffs_present
		dd.base_power_scale     = power_scale
		dd.damage_type          = damage_type
		dd.lifesteal_percentage = lifesteal_percentage
		target_stats.take_damage(dd)
