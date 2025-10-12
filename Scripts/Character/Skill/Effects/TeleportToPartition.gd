## Teleports the user to a [Partition].
class_name TeleportToPartition extends SkillEffect

# TODO: Should probably create a [SkillEffect] class just for special effects.
@export var particles_prefab: PackedScene

# TODO: Figure out a way to move more than one character.
func execute(targeting_data: TargetingData) -> void:
	if targeting_data.partitions.size() == 0:
		return
	var p = particles_prefab.instantiate()
	var user: Actor = targeting_data.user
	user.get_tree().get_root().add_child(p)
	p.global_position = user.global_position
	# TODO: Setting the raw position like this is bad form.
	user.global_position = targeting_data.partitions[0].global_position + Vector3(0.0, 2.5, 0.0)
