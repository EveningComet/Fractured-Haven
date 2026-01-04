class_name ActivitiesMenuController extends Node

@export var _activities_container: Container

## Prefab of the activity UI component.
@export var _activity_ui_scene: PackedScene

@export var _roster_interaction_interface: RosterInteractionInterface

func _ready() -> void:
	_setup_activity_ui()

func _setup_activity_ui() -> void:
	for c in _activities_container.get_children():
		c.queue_free()
	
	for activity: Activity in ActivityController.activities:
		var a_ui: ActivityUI = _activity_ui_scene.instantiate()
		a_ui.set_activity(activity)
		_activities_container.add_child(a_ui)
