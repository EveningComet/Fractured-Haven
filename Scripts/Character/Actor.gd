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

@export var combatant: Combatant

## Component managing the instanced skills for this character.
@onready var skill_handler: SkillHandler = $SkillHandler

@export var faction_owner: FactionOwner

@onready var mover: Mover = $Mover

@export var skin_handler: SkinHandler

func _ready() -> void:
	Eventbus.unit_spawned.emit(self)

func set_character_data(new_cd: CharacterData) -> void:
	combatant.character_data = new_cd
	var model: CharacterSkin = new_cd.base_blueprint.model.instantiate()
	skin_handler.set_model(model)
	# TODO: Scale the proper stuff for the model.
	
	Eventbus.unit_spawned.emit(self)
