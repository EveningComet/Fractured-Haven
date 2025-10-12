## Stores various helper functions.
class_name Utils extends Node

## Checks the passed parent node to see if it contains a node of the passed type.
static func get_node_of_type(parent: Node, type):
	for child in parent.get_children():
		if is_instance_of(child, type):
			return child
	
	return null
	
static func raycast_mouse(
	m_pos: Vector2,
	camera: Camera3D,
	ray_length: float = 1000.0,
):
	var ray_start = camera.project_ray_origin(m_pos)
	var ray_end   = ray_start + camera.project_ray_normal(m_pos) * ray_length
	var space_state = camera.get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	return space_state.intersect_ray(query)
