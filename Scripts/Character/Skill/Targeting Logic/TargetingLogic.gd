@abstract
## Helps a [SkillData] object get its targets.
class_name TargetingLogic extends Resource

func get_targets(user: Actor, partitions: Array[Partition], targets: Array[Actor]) -> TargetingData:
	var td: TargetingData = TargetingData.new()
	return td
