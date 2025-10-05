## For skills that only target a single character.
class_name UnitSkillArea extends TargetingAOE

func get_targets_in_area(partition: Partition = null, target: Actor = null) -> TargetingData:
	var td: TargetingData = TargetingData.new()
	td.targets.append(target)
	return td
