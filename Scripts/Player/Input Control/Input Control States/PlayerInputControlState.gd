## Base class for a state that controls what the player can do at a given time.
class_name PlayerInputControlState extends State

## The player's selection controller. Many states will need to know about the
## selected units.
var _selection_controller: SelectionController
var _camera_controller: CameraController

func setup_state(new_sm) -> void:
	super(new_sm)
	_selection_controller = my_state_machine.selection_controller
	_camera_controller    = new_sm.camera_controller

## Some [PlayerIncontrolState]'s will need to know if the player is clicking in
## a valid [Partition].
func _is_partition_valid(m_pos: Vector2, ray_length: float = 1000.0) -> bool:
	var cam       = _camera_controller.camera
	var ray_start = cam.project_ray_origin(m_pos)
	var ray_end   = ray_start + cam.project_ray_normal(m_pos) * ray_length
	var space_state = cam.get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	query.collide_with_areas  = true
	query.collide_with_bodies = false
	var result = space_state.intersect_ray(query)
	if result and result.collider is Partition:
		return true
	return false

## A lot of the states will need to know about what the [SelectionController] is
## doing.
func _on_units_selected(units: Array[Actor]) -> void:
	pass
