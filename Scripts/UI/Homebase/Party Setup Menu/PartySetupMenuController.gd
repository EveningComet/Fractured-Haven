class_name PartySetupMenuController extends Node

@export var _roster_interaction_interface: RosterInteractionInterface

@onready var parent: CanvasLayer = get_parent()

func _ready() -> void:
	
	parent.visibility_changed.connect(_on_visibility_changed)
	_on_visibility_changed()

func _on_visibility_changed() -> void:
	if parent.visible == true:
		pass
