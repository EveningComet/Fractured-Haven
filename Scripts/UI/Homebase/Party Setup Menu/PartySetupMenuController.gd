class_name PartySetupMenuController extends Node

## The node that will store the player's roster. (Not the characters currently in the party.
@export var _roster_container: Container

## The node storing the player's active party.
@export var _active_party_container: Container

@export var _roster_interaction_interface: RosterInteractionInterface

## The object that will display the player's characters.
@export var roster_reference_prefab: PackedScene

@onready var parent: CanvasLayer = get_parent()

func _ready() -> void:
	# Sub to the change events
	PlayerPartyController.roster_changed.connect(_on_roster_changed)
	PlayerPartyController.party_changed.connect(_on_party_changed)
	
	parent.visibility_changed.connect(_on_visibility_changed)
	_on_visibility_changed()

func _on_visibility_changed() -> void:
	if parent.visible == true:
		_spawn_roster()
		_spawn_party()
	else:
		_clear_displayed_roster()
		_clear_displayed_party()

func _spawn_roster() -> void:
	var roster: Array[CharacterData] = PlayerPartyController.roster
	for cd: CharacterData in roster:
		_spawn_roster_ref(cd, _roster_container)

func _spawn_party() -> void:
	var active_party: Array[CharacterData] = PlayerPartyController.active_party
	for cd: CharacterData in active_party:
		_spawn_roster_ref(cd, _active_party_container)

func _spawn_roster_ref(cd: CharacterData, container: Container) -> void:
	var roster_ref: RosterReference = roster_reference_prefab.instantiate()
	roster_ref.character_ref = cd
	_roster_interaction_interface.connect_to_roster_ref(roster_ref)
	container.add_child(roster_ref)

func _on_roster_changed(new_roster: Array[CharacterData]) -> void:
	_clear_displayed_roster()
	_spawn_roster()

func _on_party_changed(new_party: Array[CharacterData]) -> void:
	_clear_displayed_party()
	_spawn_party()

func _clear_displayed_roster() -> void:
	for c in _roster_container.get_children():
		c.queue_free()

func _clear_displayed_party() -> void:
	for c in _active_party_container.get_children():
		c.queue_free()
