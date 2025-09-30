## Uses the activator of the skill.
class_name GetSkillUser extends TargetingLogic

func get_targets(user: Actor, partitions: Array[Partition], targets: Array[Actor]) -> TargetingData:
	var td: TargetingData = TargetingData.new()
	td.user = user
	td.partitions.append(user.partition)
	td.targets.append(user)
	return td
