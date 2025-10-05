class_name CreatureLocomotionController extends StateMachine

@export var combatant: Combatant
@export var nav_agent: NavigationAgent3D
@onready var cb: CharacterBody3D       = get_parent()
@onready var skin_handler: SkinHandler = get_parent().get_node("SkinHandler")

func _physics_process(delta: float) -> void:
	curr_state.physics_update( delta )

## Used to tell the current state the direction it should move.
func set_input_direction(input_dir: Vector3) -> void:
	curr_state.set_input_direction( input_dir )

func jump_pressed() -> void:
	curr_state.jump_pressed()

func jump_released() -> void:
	curr_state.jump_released()
