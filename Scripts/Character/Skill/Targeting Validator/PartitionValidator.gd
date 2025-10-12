class_name PartitionValidator extends TargetingValidator

func is_valid(targetable: Node) -> bool:
	if targetable != null and targetable is Partition:
		return true
	else:
		return false

## Modified to only check for areas.
func get_raycast_info(
	m_pos: Vector2,
	camera: Camera3D,
	ray_length: float = 1000.0
):
	var ray_start = camera.project_ray_origin(m_pos)
	var ray_end   = ray_start + camera.project_ray_normal(m_pos) * ray_length
	var space_state = camera.get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	query.collide_with_bodies = false
	query.collide_with_areas  = true
	return space_state.intersect_ray(query)
