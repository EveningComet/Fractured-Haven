## A character that exists in the game world.
class_name Actor extends CharacterBody3D

## The [Partition] this character currently occupies.
var partition: Partition = null:
	get: return partition
	set(value):
		partition = value

@onready var combatant: Combatant = $Combatant

## TODO: Delete this. Only for testing.
@export var owned_by_player: bool = false
func _ready() -> void:
	if owned_by_player == true:
		PlayerPartyController.add_to_party(self)
