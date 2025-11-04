## While on the map, this object simply checks for characters taking damage.
class_name DeathListener extends Node

func _ready() -> void:
	Eventbus.unit_spawned.connect(_on_unit_spawned)

func _on_unit_spawned(unit: Actor) -> void:
	var unit_stats: CharacterStats = unit.combatant.character_data.stats
	unit_stats.hp_depleted.connect(
		_on_unit_defeated.bind(unit)
	)

func _on_unit_defeated(stats: CharacterStats, unit: Actor) -> void:
	if OS.is_debug_build() == true:
		print("DeathListener :: %s is kill." % [unit.combatant.character_data.char_name])
	
	if PlayerPartyController.active_party.has(unit) == false:
		# Scale the XP on enemy level?
		var xp_to_give: int = unit.combatant.character_data.base_blueprint.exp_on_death
		PlayerPartyController.give_experience_points(xp_to_give)
		# TODO: Don't just delete the character. Ragdolls would be moist and funny.
		unit.queue_free()
