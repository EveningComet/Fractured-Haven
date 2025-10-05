## Returns the user and their [Partition].
class_name SelfRange extends TargetingRange

func get_in_range(user: Actor, partition: Partition, target: Actor) -> TargetingData:
	var td: TargetingData = TargetingData.new(
		user,
		[partition],
		[user]
	)
	return td
