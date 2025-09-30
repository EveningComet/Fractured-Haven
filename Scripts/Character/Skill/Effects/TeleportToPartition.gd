## Teleports to [Partition].
class_name TeleportToPartition extends SkillEffect

func execute(targeting_data: TargetingData) -> void:
	for t: Actor in targeting_data.targets:
		t.global_position = targeting_data.partitions[0].global_position
