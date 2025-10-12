@abstract
## Filters targets for a skill.
class_name TargetingValidator extends Resource

func is_valid(targetable: Node) -> bool:
	return false

## Raycast for something. Mainly used for the player.
func get_raycast_info(
	m_pos: Vector2,
	camera: Camera3D,
	ray_length: float = 1000.0
):
	pass
