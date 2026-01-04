## The middle man for interacting with the player's roster UI and data.
class_name RosterInteractionInterface extends Node2D

@export var _grabbed_character_ui: RosterReference

@export var _roster_displayer: RosterDisplayer
@export var _active_party_displayer: RosterDisplayer

## Stores the character we're doing something with.
var _grabbed_character: CharacterData

func _ready() -> void:
	get_parent().visibility_changed.connect(_on_visibility_changed )
	
	# Sub to the relevant events
	if _roster_displayer != null:
		_roster_displayer.roster_ref_selected.connect(_on_roster_ref_selected)
		_roster_displayer.gui_input.connect(_on_displayer_interacted.bind(_roster_displayer))
	if _active_party_displayer != null:
		_active_party_displayer.roster_ref_selected.connect(_on_roster_ref_selected)
		_active_party_displayer.gui_input.connect(_on_displayer_interacted.bind(_active_party_displayer))

func _input(event: InputEvent) -> void:
	if _grabbed_character_ui.visible == true:
		_grabbed_character_ui.global_position = get_global_mouse_position() + Vector2(5, 5)

func connect_to_roster_ref(rr: RosterReference) -> void:
	rr.pressed.connect( _on_roster_ref_selected.bind(rr) )

func _on_visibility_changed() -> void:
	if get_parent().visible == false and _grabbed_character != null:
		PlayerPartyController.add_to_roster(_grabbed_character)
		_grabbed_character = null
		_update_grabbed_slot()

func _on_roster_ref_selected(rr: RosterReference) -> void:
	# TODO: More refined handling. What if the player just wants to inspect equipment?
	if _grabbed_character != null:
		# TODO: Swap when someone is already selected.
		return
		
	if OS.is_debug_build() == true:
		print("RosterInteractionInterface :: Noticed a button was pressed.")
	
	_grabbed_character = rr.character_ref
	PlayerPartyController.find_and_remove(_grabbed_character)
	_update_grabbed_slot()

## Used to easily add and remove the characters from the roster or the party.
func _on_displayer_interacted(event: InputEvent, rd: RosterDisplayer) -> void:
	if _grabbed_character != null:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			rd.add_to_roster(_grabbed_character)
			_grabbed_character = null
			_update_grabbed_slot()

func _update_grabbed_slot() -> void:
	if _grabbed_character != null:
		_grabbed_character_ui.global_position = get_global_mouse_position()
		_grabbed_character_ui.show()
		# TODO: Display visual.
	else:
		_grabbed_character_ui.hide()
