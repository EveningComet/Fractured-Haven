## The middle man for interacting with the player's roster UI and data.
class_name RosterInteractionInterface extends Node

@export var grabbed_character_ui: RosterReference
var _grabbed_character: CharacterData

func connect_to_roster_ref(rr: RosterReference) -> void:
	rr.pressed.connect( _on_roster_ref_selected.bind(rr) )

func _on_roster_ref_selected(rr: RosterReference) -> void:
	if OS.is_debug_build() == true:
		print("RosterInteractionInterface :: Noticed a button was pressed.")
