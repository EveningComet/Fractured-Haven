## The state where the game is waiting for the player to have at least
class_name WaitingForUnitSelection extends PlayerInputControlState

func exit() -> void:
	_selection_controller.pawns_selected.disconnect(
		_on_units_selected
	)

func enter(msgs: Dictionary = {}) -> void:
	_selection_controller.pawns_selected.connect(
		_on_units_selected
	)

func _on_units_selected(selected_actors: Array[Actor]) -> void:
	if selected_actors.size() > 0:
		my_state_machine.change_to_state("DirectingUnits")
