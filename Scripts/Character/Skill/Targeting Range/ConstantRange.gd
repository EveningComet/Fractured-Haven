## For skills that will pretty much have a static range.
class_name ConstantRange extends TargetingRange

func get_in_range(user: Actor, partition: Partition, target: Actor) -> TargetingData:
	var td: TargetingData = TargetingData.new()
	td.user = user
	td.partitions.append(partition)
	return td
