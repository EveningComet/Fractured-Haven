## A character that exists in the game world.
class_name Actor extends CharacterBody3D

## Fired whenever the character ends up in a new zone.
signal partition_changed(actor: Actor)

## The [Partition] this character currently occupies.
var partition: Partition = null:
	get: return partition
	set(value):
		partition = value
		partition_changed.emit(self)

@onready var combatant: Combatant = $Combatant

## Component managing the instanced skills for this character.
@onready var skill_handler: SkillHandler = $SkillHandler

@onready var faction_owner: FactionOwner = $FactionOwner

@onready var mover: Mover = $Mover

## TODO: Delete this when no longer needed. Only for testing.
@export var owned_by_player: bool = false

func _ready() -> void:
	Eventbus.unit_spawned.emit(self)
	
	if owned_by_player == true:
		PlayerPartyController.add_to_party(self)
