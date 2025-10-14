## Manages the player's input.
class_name PlayerInputController extends StateMachine

@export var selection_controller: SelectionController
@export var camera_controller: CameraController

func _unhandled_input(event: InputEvent) -> void:
	curr_state.check_for_unhandled_input( event )

func making_character_use_skill(user: Actor, skill: SkillInstance) -> void:
	if OS.is_debug_build() == true:
		print("PlayerInputController :: Passed a user to perform a skill.")
	change_to_state("FindingSkillTarget", {"user" = user, "skill" = skill})
