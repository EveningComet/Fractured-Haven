class_name PartySetupMenuController extends Node

@export var _roster_displayer:       RosterDisplayer = null
@export var _active_party_displayer: RosterDisplayer = null
@export var _roster_interaction_interface: RosterInteractionInterface

@onready var parent: CanvasLayer = get_parent()

func _ready() -> void:
	
	parent.visibility_changed.connect(_on_visibility_changed)
	_on_visibility_changed()
	
	# Setup the relevant components
	_roster_displayer.roster_ref_spawned.connect(_roster_interaction_interface.connect_to_roster_ref)
	_roster_displayer.gui_input.connect(_roster_interaction_interface.on_displayer_interacted.bind(_roster_displayer))
	_active_party_displayer.roster_ref_spawned.connect(_roster_interaction_interface.connect_to_roster_ref)
	_active_party_displayer.gui_input.connect(_roster_interaction_interface.on_displayer_interacted.bind(_active_party_displayer))

func _on_visibility_changed() -> void:
	if parent.visible == true:
		pass
