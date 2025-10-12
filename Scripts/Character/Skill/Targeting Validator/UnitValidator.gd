## Only checks for a unit.
class_name UnitValidator extends TargetingValidator

func is_valid(targetable: Node) -> bool:
	if targetable != null and targetable is Actor:
		return true
	else:
		return false

func get_raycast_info(
	m_pos: Vector2,
	camera: Camera3D,
	ray_length: float = 1000.0
):
	return Utils.raycast_mouse(m_pos, camera, ray_length)
