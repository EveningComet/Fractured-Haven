## Teleports to [Partition].
class_name TeleportToPartition extends SkillEffect

# TODO: Should probably create a [SkillEffect] class just for special effects.
@export var particles_prefab: PackedScene

func execute(targeting_data: TargetingData) -> void:
	for t: Actor in targeting_data.targets:
		var p = particles_prefab.instantiate()
		t.get_tree().get_root().add_child(p)
		p.global_position = t.global_position
		# TODO: Setting the raw position like this is bad form.
		t.global_position = targeting_data.partitions[0].global_position + Vector3.UP
