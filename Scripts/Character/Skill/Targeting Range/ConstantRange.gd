## For skills that will pretty much have a static range.
class_name ConstantRange extends TargetingRange

enum Types {
	OnlyPartitions,
	OnlyUnits
}

@export var type: Types = Types.OnlyPartitions

func get_targetables_in_range(start: Partition = null, user: Actor = null) -> Array[Node]:
	var partitions: Array[Partition] = Board.depth_search([], start, range_in_partitions)
	var ret: Array[Node] = []
	match type:
		Types.OnlyPartitions:
			for p: Partition in partitions:
				ret.append(p)
		Types.OnlyUnits:
			for p: Partition in partitions:
				for u: Actor in p.monitored:
					ret.append(u)
	return ret
