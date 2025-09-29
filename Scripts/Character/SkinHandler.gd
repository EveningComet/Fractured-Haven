## The middle man between a character model with animations and other components.s
class_name SkinHandler extends Node3D

## The character model.
@onready var character_skin: CharacterSkin = get_child(0)

var animation_tree: AnimationTree:
	get: return character_skin.animation_tree

## Set a new model.
func set_model(new_model: CharacterSkin) -> void:
	if get_child_count() > 0:
		get_child(0).queue_free()
	character_skin = new_model
	add_child(new_model)
