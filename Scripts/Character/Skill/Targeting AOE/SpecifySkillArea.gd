## For skills that target a set of partitions.
class_name SpecifySkillArea extends TargetingAOE

## If == 0, then only the [Partition] itself will be targeted.
@export var range_in_partitions: int = 1
# TODO: Account for vertical AND horizontal/consider vertical and horizontal to be different?

func get_targets_in_area(partition: Partition = null, target: Actor = null) -> TargetingData:
	var td: TargetingData = TargetingData.new()
	if range_in_partitions == 0:
		td.partitions.append(partition)
	else:
		pass
	return td
