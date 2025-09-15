## Controls the camera for the player.
class_name CameraController extends SpringArm3D

## How fast the camera moves.
@export var _pan_speed: float = 15.0
@export var _rotation_speed: float = 1.50
@export var _zoom_speed: float = 15.00
@export var _max_zoom: float = 35.00
@export var _min_zoom: float = 0.5

var _zoom_target: float = 0.0
## Stores where the camera is actively moving towards.
var _velocity: Vector3

@onready var camera: Camera3D = $Pivot/Camera3D

## The node used to handle tilting and rotating the camera.
@onready var _pivot: Node3D = $Pivot

# TODO: Rotation limits.

func _ready() -> void:
	_zoom_target = position.y

func _process(delta: float) -> void:
	_camera_movement(delta)
	_handle_zoom(delta)

func _camera_movement(delta: float) -> void:
	_velocity = Vector3.ZERO
	_velocity.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	_velocity.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	_velocity = _velocity.rotated(Vector3.UP, rotation_degrees.y)
	translate(_velocity.normalized() * _pan_speed * delta)

func _camera_rotation(delta: float) -> void:
	pass

func _handle_zoom(delta: float) -> void:
	var zoom_dir = (int(Input.is_action_just_released("camera_zoom_out")) - \
		int(Input.is_action_just_released("camera_zoom_in")))
	
	_zoom_target = zoom_dir * _zoom_speed
	translate(transform.basis.y * _zoom_target * delta)
