class_name PartySetupMenuController extends Node

## The node that will store the player's roster. (Not the characters currently in the party.
@export var _roster_container: Container

## The node storing the player's active party.
@export var _active_party_container: Container

## The object that will display the player's characters.
@export var roster_reference_prefab: PackedScene

@onready var parent: CanvasLayer = get_parent()

func _ready() -> void:
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
		var roster_ref: RosterReference = roster_reference_prefab.instantiate()
		roster_ref.character_ref = cd
		_roster_container.add_child(roster_ref)

func _spawn_party() -> void:
	var active_party: Array[CharacterData] = PlayerPartyController.active_party
	for cd: CharacterData in active_party:
		var roster_ref: RosterReference = roster_reference_prefab.instantiate()
		roster_ref.character_ref = cd
		_active_party_container.add_child(roster_ref)

func _clear_displayed_roster() -> void:
	for c in _roster_container.get_children():
		c.queue_free()

func _clear_displayed_party() -> void:
	for c in _active_party_container.get_children():
		c.queue_free()
