## Manages the player's input.
class_name PlayerInputController extends StateMachine

@export var selection_controller: SelectionController
@export var camera_controller: CameraController

func _unhandled_input(event: InputEvent) -> void:
	curr_state.check_for_unhandled_input( event )
