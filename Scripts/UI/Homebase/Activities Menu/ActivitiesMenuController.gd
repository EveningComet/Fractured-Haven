class_name ActivitiesMenuController extends Node

## Where the displayed activities will go.
@export var _activities_container: Container

@export var _roster_displayer: RosterDisplayer

## Prefab of the activity UI component.
@export var _activity_ui_scene: PackedScene

@export var _roster_interaction_interface: RosterInteractionInterface

func _ready() -> void:
	_setup_activity_ui()

func _setup_activity_ui() -> void:
	_roster_displayer.roster_ref_spawned.connect(_roster_interaction_interface.connect_to_roster_ref)
	_roster_displayer.gui_input.connect(_roster_interaction_interface.on_displayer_interacted.bind(_roster_displayer))
	
	for c in _activities_container.get_children():
		c.queue_free()
	
	for activity: Activity in ActivityController.activities:
		var a_ui: ActivityUI = _activity_ui_scene.instantiate()
		
		# Set things up for the roster interaction
		# This will allow the player to actually add and remove people
		_roster_interaction_interface.connect_to_activity_ui(a_ui)
		a_ui.roster_ref_spawned.connect(_roster_interaction_interface.connect_to_roster_ref)
		
		a_ui.set_activity(activity)
		_activities_container.add_child(a_ui)
