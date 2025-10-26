## For skills that will pretty much have a static range.
class_name ConstantRange extends TargetingRange

enum Types {
	OnlyPartitions,
	OnlyUnits,
	OnlyAllies,
	OnlyEnemies
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
				ret.append_array(_get_units_from_partition(p))
		
		# TODO: Account for something such as a confusion/possessed status effect?
		Types.OnlyAllies:
			for p: Partition in partitions:
				for u: Actor in _get_units_from_partition(p):
					if user.faction_owner.is_on_same_team(u.faction_owner) == true:
						ret.append(u)
		Types.OnlyEnemies:
			for p: Partition in partitions:
				for u: Actor in _get_units_from_partition(p):
					if user.faction_owner.is_on_same_team(u.faction_owner) == false:
						ret.append(u)
	return ret
