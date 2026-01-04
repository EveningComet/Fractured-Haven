class_name HomebaseController extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_perform_activity_stuff()

func _perform_activity_stuff() -> void:
	ActivityController.perform_activity_changes()
