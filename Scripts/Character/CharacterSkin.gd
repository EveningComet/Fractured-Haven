## Helps with accessing a models animations.
## Meant to be attached to the model's prefab or scene.
class_name CharacterSkin extends Node3D

## Used for telling when the skill finished.
signal action_execution_finished

@onready var animation_tree: AnimationTree = $AnimationTree

## A function called by animations, related to attacks and skills, has been
## finished.
func action_anim_complete() -> void:
	action_execution_finished.emit()
