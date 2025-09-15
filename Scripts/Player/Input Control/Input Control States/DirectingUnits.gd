## The state where the player has at least one character selected.
class_name DirectingUnits extends PlayerInputControlState

func enter(msgs: Dictionary = {}) -> void:
	_selection_controller.pawns_selected.connect(
		_on_units_selected
	)

func exit() -> void:
	_selection_controller.pawns_selected.disconnect(
		_on_units_selected
	)

func check_for_unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("right_click"):
		var m_pos: Vector2 = _camera_controller.get_viewport().get_mouse_position()
		if _is_partition_valid(m_pos) == true:
			var result = Utils.raycast_mouse(m_pos, _camera_controller.camera)
			if result:
				for u: Actor in _selection_controller.curr_pawns:
					u.global_position = result.position + Vector3.UP

## Return to the default state when there's nobody selected.
func _on_units_selected(units: Array[Actor]) -> void:
	if units.size() < 1:
		my_state_machine.change_to_state("WaitingForUnitSelection")
