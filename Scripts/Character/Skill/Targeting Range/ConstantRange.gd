## For skills that will pretty much have a static range.
class_name ConstantRange extends TargetingRange

func get_targetables_in_range(start: Partition = null, user: Actor = null) -> Array[Node]:
	var partitions: Array[Partition] = Board.depth_search([], start, range_in_partitions)
	var ret: Array[Node] = []
	for p: Partition in partitions:
		ret.append(p)
	return ret
