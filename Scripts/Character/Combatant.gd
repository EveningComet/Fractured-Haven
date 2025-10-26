## Stores combat related information for a character.
class_name Combatant extends Node

## Stores the character's information.
@export var character_data: CharacterData = CharacterData.new()

func _ready() -> void:
	character_data.init()

func _physics_process(delta: float) -> void:
	character_data.status_effect_holder.tick(delta)
