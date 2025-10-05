@abstract
## Base class for a state that defines how a character should move.
class_name CLState extends State

## Every state needs to check for movement in some way.
var _cb: CharacterBody3D

# Speed & Friction
var _move_speed:             float = 10   # How fast this state moves. Controlled by the stat.
@export var acceleration:    float = 60.0
@export var friction:        float = 50.0
@export var rot_speed:       float = 10.0 # How fast we rotate

# Every state needs to keep track of their movement vector and input
var _velocity:  Vector3 = Vector3.ZERO
var _input_dir: Vector3 = Vector3.ZERO

## The node for interfacing with the character animations.
var _skin_handler: SkinHandler

var _stats: CharacterStats

func setup_state(new_sm: CreatureLocomotionController) -> void:
	super(new_sm)
	_cb           = new_sm.cb
	_skin_handler = new_sm.skin_handler
	
	# Inititialize the movement speed to be based on the relevant stat
	# TODO: Subscribe to the event for stat changes.
	_stats = new_sm.combatant.character_data.stats
	_move_speed = Formulas.get_calculated_value(StatHelper.StatTypes.MoveSpeed, _stats)

func exit() -> void:
	_velocity  = Vector3.ZERO
	_input_dir = Vector3.ZERO

func physics_update(delta: float) -> void:
	_handle_move( delta )

func _handle_move(delta: float) -> void:
	_apply_movement( delta )
	_apply_friction( delta )
	
	_cb.set_velocity( _velocity )
	_cb.move_and_slide()

func _apply_movement(delta: float) -> void:
	if _input_dir != Vector3.ZERO:
		_velocity.x = _velocity.move_toward(_input_dir * _move_speed, acceleration * delta).x
		_velocity.z = _velocity.move_toward(_input_dir * _move_speed, acceleration * delta).z
		
		# Look in the direction of movement
		_cb.rotation.y = lerp_angle(
			_cb.rotation.y,
			atan2(-_input_dir.x, -_input_dir.z),
			rot_speed * delta
		)

func _apply_friction(delta: float) -> void:
	if _input_dir == Vector3.ZERO:
		_velocity.x = _velocity.move_toward(Vector3.ZERO, friction * delta).x
		_velocity.z = _velocity.move_toward(Vector3.ZERO, friction * delta).z

func set_input_direction(input_direction: Vector3) -> void:
	_input_dir = input_direction

func jump_pressed() -> void:
	pass

func jump_released() -> void:
	pass

## Dictates how a state should handle the animations.
func _handle_animations(delta: float) -> void:
	pass
