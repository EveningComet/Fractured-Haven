## The middle man for interacting with the player's roster UI and data.
class_name RosterInteractionInterface extends Node2D

@export var _grabbed_character_ui: RosterReference
@export var _active_party_container: Container
@export var _roster_container:       Container

## Stores the character we're doing something with.
var _grabbed_character: CharacterData

func _ready() -> void:
	get_parent().visibility_changed.connect(_on_visibility_changed )
	
	# Sub to the gui input events
	_active_party_container.gui_input.connect(_on_container_interacted.bind(_active_party_container))
	_roster_container.gui_input.connect(_on_container_interacted.bind(_roster_container))

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
	if _grabbed_character != null:
		# TODO: Swap when someone is already selected.
		return
		
	if OS.is_debug_build() == true:
		print("RosterInteractionInterface :: Noticed a button was pressed.")
	
	_grabbed_character = rr.character_ref
	PlayerPartyController.find_and_remove(_grabbed_character)
	_update_grabbed_slot()

func _on_container_interacted(event: InputEvent, container: Container) -> void:
	if _grabbed_character != null and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if container == _roster_container:
			PlayerPartyController.add_to_roster(_grabbed_character)
			_grabbed_character = null
			_update_grabbed_slot()
		elif container == _active_party_container:
			PlayerPartyController.add_to_party(_grabbed_character)
			_grabbed_character = null
			_update_grabbed_slot()

func _update_grabbed_slot() -> void:
	if _grabbed_character != null:
		_grabbed_character_ui.global_position = get_global_mouse_position()
		_grabbed_character_ui.show()
		# TODO: Display visual.
	else:
		_grabbed_character_ui.hide()
